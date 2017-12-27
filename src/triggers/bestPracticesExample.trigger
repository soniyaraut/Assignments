trigger bestPracticesExample on Contact (before insert) {

      List<Contact> contactsList = Trigger.new;
      List<Account> newAccountList = new List<Account>();	
      Integer flag = 0;
      List<Account> accNameList = new List<Account>([
          SELECT Email__c
            FROM Account
           WHERE Name LIKE ' @% '
      ]);

      Set<Account> myAccDomainset = new Set<Account>(accNameList);
      Map<String, Account> Accountemailmap = new  Map<String, Account>();

      for (Account Accountitr : myAccDomainset) {
          Accountemailmap.put(Accountitr.Email__c, Accountitr);
      }
 
      for (Contact conitr : contactsList) {
          if (conitr.Email!=null) {                
             if (Accountemailmap.containsKey(conitr.Email.split( ' @ ' ).get(1))) {
                  conitr.AccountId = Accountemailmap.get(conitr.Email.split( ' @ ' ).get(1)).Id;
             } else {                
                  Account aaa = new  Account(Name = conitr.Email.split('@').get(1));
                  newAccountList.add(aaa);
                  flag = 1;
             }
          }
      }

      if (flag == 1) {
          insert newAccountList;
          for (Account a : newAccountList) {
              for (Contact c : Trigger.new) {
                  c.AccountId = a.Id;
              }
          }
      }
 }