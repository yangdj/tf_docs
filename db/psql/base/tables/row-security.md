# row-level security

*row security policies* restrict, on a per-user basis, which rows can be returned by normal queries or inserted, updated, or deleted by data modification commands. this feature is also known as *row-level security*.

when row security is enabled on a table (with alter table ... enable row level security), all normal access to the table for selecting rows or modifying rows must be followed by a row security policy. however, the table's owner is typically not subject to row security policies. if no policy exists for the table, a *default-deny* policy is used, meaning that no rows are visible or can be modified. operators that apply to the *whole table*, such as `truncate` and `references`, are not subject to row security.

*superusers* and roles with *bypassrls* attribute always bypass the row security system when accessing a table. table owners normally bypass row security as well.

    create table accounts (manager text, company text, contact_email text);

    alter table accounts enable row level security;

    create policy account_managers on accounts to managers using (manager = current_user);

if no role is specified, or the special user name `public` is used, then the policy applies to all users on the system. to allow all users to access their own row in a *user* table, a simple policy can be userd:

    create policy user_policy on users using (user_name = current_user);

to use a different policy for rows that are being added to the table compared to those rows that are visible, the `with check` clause can be used. this policy would allow all users to view all rows in the `user` table, but only modify their own:

    create policy user_policy on users using (true) with check (user_name = current_user);

row security can also be diabled with the `alter table` command. disabling row security does not remove any policies that are defined on the table; they are simply ignored. then all rows in the table are visible and modifiable, subject to the standard SQL privilege system.

a full example:

    -- simple passwd-file based example
    create table passwd (
    user_name             text unique not null,
    pwhash                text,
    uid                   int  primary key,
    gid                   int  not null,
    real_name             text not null,
    home_phone            text,
    extra_info            text,
    home_dir              text not null,
    shell                 text not null
    );

    create role admin;  -- administrator
    create role bob;    -- normal user
    create role alice;  -- normal user

    -- populate the table
    insert into passwd values
    ('admin','xxx',0,0,'admin','111-222-3333',null,'/root','/bin/dash');
    insert into passwd values
    ('bob','xxx',1,1,'bob','123-456-7890',null,'/home/bob','/bin/zsh');
    insert into passwd values
    ('alice','xxx',2,1,'alice','098-765-4321',null,'/home/alice','/bin/zsh');

    -- be sure to enable row level security on the table
    alter table passwd enable row level security;

    -- create policies
    -- administrator can see all rows and add any rows
    create policy admin_all on passwd to admin using (true) with check (true);
    -- normal users can view all rows
    create policy all_view on passwd for select using (true);
    -- normal users can update their own records, but
    -- limit which shells a normal user is allowed to set
    create policy user_mod on passwd for update
    using (current_user = user_name)
    with check (
    current_user = user_name and
    shell in ('/bin/bash','/bin/sh','/bin/dash','/bin/zsh','/bin/tcsh')
    );

    -- allow admin all normal rights
    grant select, insert, update, delete on passwd to admin;
    -- users only get select access on public columns
    grant select
    (user_name, uid, gid, real_name, home_phone, extra_info, home_dir, shell)
    on passwd to public;
    -- allow users to update certain columns
    grant update
    (pwhash, real_name, home_phone, extra_info, shell)
    on passwd to public;
