# transaction

the essential point of a transaction is that it bundles multiple steps into a single, all-or-nothing operation. the intermediate states between the steps are not visible to other concurrent transactions, and if some failure occurs that prevents the transaction from completing, then none of the steps affect the database at all.

a transaction is said to be *atomic* if it either happens completely or not at all.

a transactional database guarantees that all the updates made by a transaction are logged in permanent storage (i.e., on disk) before the transaction is reported complete.

when multiple transactions are running concurrent, each one should not be able to see the incomplete changes changes made by others. so transactions must be all-or-nothing not only in terms of their permanent effect on the database, but also in terms of their visibility as they happen. the updates made so far by an open transaction are invisible to other transctions until the transaction completes, whereupon all the updates become visible simultaneously.

a transaction is set up by surrounding the sql commands of the transaction with `BEGIN` and `COMMIT` commands:

    BEGIN:
        update ...
        ...
    COMMIT;

if, partway through the transaction, we decide not to commit, we can issue command `ROLLBACK` instead of `COMMIT`, and all our updates so far will be canceled.

postgresql actually treats every sql statement as being executed within a transaction. if you do not issue a `BEGIN` command then each individual statement has an implicit `BEGIN` and (if successful) `COMMIT` wrapped around it. a group of statement surrounded by `BEGIN` and `COMMIT` is sometimes called a *transaciton block*.

it is possible to control the statements in a transaction in a more fashion through the use of `savepoints`. `savepoints` allow you to selectively discard parts of the transaction, while committing the rest. after defining a `savepoint`, you can if needed roll back to the savepoint with `ROLLBACK TO`.

    BEGIN;
        UPDATE accounts SET balance = balance - 100.00
        WHERE name = 'Alice';
    SAVEPOINT my_savepoint;
        UPDATE accounts SET balance = balance + 100.00
        WHERE name = 'Bob';
        -- oops ... forget that and use Wally's account
    ROLLBACK TO my_savepoint;
        UPDATE accounts SET balance = balance + 100.00
        WHERE name = 'Wally';
    COMMIT;
