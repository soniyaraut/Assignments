trigger MyTriiger on Account (after insert) {
    
     // 1.System.debug the following statements for any object 
     // a)Trigger.New b) Trigger.Old c)Trigger.NewMap d)Trigger.oldMap

    for (Account a : Trigger.new) {
              System.debug('Hi ' + a.Name + ' ' + a.Id + '!');
    }   
  
     if (trigger.isafter && trigger.isInsert) {
        Map<id, account> insertaccount = trigger.newmap;      
        list<account> lstaccount = [
          SELECT Id
            FROM Account
           WHERE Id IN : insertaccount.keyset()
        ];

       System.debug(''+lstaccount);
     }

    if (trigger.isafter && trigger.isDelete) {
      Map<Id, Account> deleteaccount = trigger.oldmap;
      list<account> lstaccount = [
        SELECT Id 
          FROM Account
         WHERE Id IN : deleteaccount.keyset()
      ];

     System.debug(''+lstaccount);
    }

   //3.Write a Trigger on Account which will create the clone record.
   // (Hint : Map trigger.new to clone record)*/
   
  if (CloneAccount.flag == true) {
      CloneAccount.flag = false;
      List<Account> clonedAcc = Trigger.new.deepClone();     
      insert clonedAcc;
  } 
}