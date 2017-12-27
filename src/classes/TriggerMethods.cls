public class TriggerMethods {

   public  void allocateAccountviaDomain(List<Contact> newTrigger) {
        Integer flag = 0;
        List<Account> accNameList = new List<Account>([
          SELECT Name
          FROM Account
        	Where Name LIKE '@%'
        ]);

        Set<Account> myAccDomainset = new Set<Account>(accNameList);
        List<Contact> contactsList = Trigger.new;
        List<Account> newAccountList = new List<Account>();

       for (Account a: accNameList) {         
      	 for (Contact c : contactsList) {
               if (a.Name.split('@').get(1)==c.Email.split('@').get(1)) {
                    c.AccountId=a.Id;                    
            	 } else {
                     Account aaa = new  Account(  Name = c.Email.split('@').get(1) );
                     newAccountList.add(aaa);
                     flag = 1;
               }                
          }
        }
       
       if(flag==1) {
         insert newAccountList;
         for(Account a: newAccountList) {
              for(Contact c: newTrigger) {
                  c.AccountId=a.Id;
              }
          }       	
       }
    }
}