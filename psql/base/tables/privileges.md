# privileges

when an object is created, it is assigned an owner. the owner is normally the role that executed the creation statement. for most kinds of objects, the initial state is that only the owner (or a superuser) can do anything with the oject. to allow other roles to use id, the *privilege* must be *granted*.

there are different kinds of privileges:

* create
* select
* insert
* delete
* update
* truncate
* references
* trigger
* connect
* temporary
* execute
* usage

the right to modify or destroy an object is always the privilege of the owner only.

an object can be assigned to a new owner with an `alter` command. superuser can always do this; ordinary roles can only do it if they are both the current owner of the object (or a member of the owning role) and a member of the new owning role.

you can use `grant` to assign privileges:

    grant update on accounts to joe;

writing `all` in place of a specific privilege grants all privileges that are relevant for the object type.

the special role name `public` can be used to grant a privilege to every role on the system. also, *group* roles can be set up to help manage privileges when there are many users of a database.

using `revoke` to revoke privileges:

    revoke all on accounts from public;

the special privileges of the object owner (`drop`, `grant`, `revoke`, etc.) are always implicit in being the owner, and cannot be granted or revoked. but the object owner can choose to revoke their ordinary privileges.

ordinarily, only the object's owner (or superuser) can grant or revoke privileges on an object. however, it is possible to grant a privilege *with grant option*, which gives the recipent the right to grant it in turn to others. if the grant option is subsequently revoked then all who receive the privilege from the recipent (directly or through a chain of grants) will lose the privilege.
