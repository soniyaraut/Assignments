/*
4. Task Creation Trigger
Create a task upon successful creation of a new Account.
The task subject should be set as –Meeting with <specific Account’s name>.
Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
*/

trigger CreateTaskForAccount on Account (after insert) {

    List<Task> tasks = new List<Task>();
    List<Account> Opps = Trigger.new; 
    for (Account acc : Opps) {
        Task tsk = new Task(
                whatID = acc.ID
             , Ownerid = acc.OwnerId
             , Subject = ' Meeting with ' + acc.Name
        ); 

        tasks.add(tsk); 
    } 

    insert tasks;    
    System.debug('' + tasks);   
}