 /**
 * Class created for questions under assignment no. 2
 * Created Date: 12/07/17
 * Author: Soniya Raut
 */
  public class User_2 {
        // 1. Query on all Contact records and add them to the List. 
        // Print that contents of this list.	
        public void getContacts() {
          List<Contact> records = [
                 SELECT Id
                      , Name
                   FROM Contact
          ];

          for (Contact conitr : records) {
            System.debug('' + conitr);
          }
        }

        // 2. Write a SOQL query to retrieve/print all active Users. 
        // Prepare a Map having User Id as key and User record as value.	
        public void check_Active() {
          List<User> lstUser = [
            SELECT Id
                 , Name
                 , IsActive
              FROM User
             WHERE IsActive = TRUE
          ];

        // Write a SOQL query to retrieve/print all active Users. 
        //    Query:
        //           SELECT Id
        // 		      	   , Name
        // 		      	   , isActive
        // 	          FROM User 
        // 		       WHERE isActive = TRUE

        // Prepare a Map having User Id 
        // as key and User record as value.	    
          Map<Id,User> mapUsers_2 = new Map<Id,User>(lstUser);
          System.debug('' + mapUsers_2);

          //3. Prepare the following map structures :
          //a. Account Name as key and AccountId as value. 		
          Map<String,Id> mapAccount_3a = new Map<String,Id>();

          //b. Account Id as key and entire Account object as value.        
          Map<Id,Account> mapAccount_3b = new Map<Id,Account>();
        }      

        //4.Get all account records where in selected 'Enrollment Year' is:
        //a. 2010
        //b. 2013 and 2014
        // Query:

        //  SELECT Id
        //       , Name
        //       , Enrollment_Year__c
        //    FROM Account
        //   WHERE Enrollment_Year__c INCLUDES ('2013','2010','2014')
          
        // 5.Write a SOQL query to find all Account records where 
        // 'Billing State' is not 'Maharashtra' and 'Kerala'. 
        // Order the results by Billing State in descending 
        // order with null values at the end. Display first 10,000 records
        // only. NOTE: do not use AND operator.

        // SELECT Id
        //      , Name
        //      , BillingState 
        //  FROM  Account
        //  WHERE BillingState
        //    NOT IN ('Maharashtra','Kerala')
        //  ORDER BY BillingState DESC NULLS LAST
        //  LIMIT 10000

        // 6. Write a SOQL query to display 100 opportunity records with amount
        // greater than 10,000 order by created date. Skip first 50 records
        // and include records from recycle bin.
        // ==================
        // Aggregate Functions
        // =======================      
        public void OpportunityRecords_6() {
          List<Opportunity> lstOpportunity = [
              SELECT Id
                  , Name
                  , Amount
               FROM Opportunity
              WHERE Amount > 10000
              ORDER BY CREATEDDATE
              LIMIT 100
             OFFSET 25   
                ALL ROWS
          ];

          for ( Opportunity opptemp : lstOpportunity) {
            System.debug('' + opptemp);
          }
        }

        // 1. Write a SOQL query to retrieve sum of all closed Opportunity
        // amount for current fiscal year. Store this information in a
        // map with key as year and value as sum of amount. Iterate this 
        // map to display statistics.
        void diplsayOpportunityStatistics() {
          List<AggregateResult> listofopportunity = [                	   
              SELECT CALENDAR_YEAR (CloseDate) Calyear
                   , SUM (Amount) amount
                FROM Opportunity
               WHERE StageName = ' Closed Won '
                 AND CloseDate = THIS_FISCAL_YEAR
               GROUP BY CALENDAR_YEAR(CloseDate)
          ];

          Map<Integer, Integer> opportunityMap = new   Map<Integer, Integer>();
  
          for(AggregateResult aggritr : listofopportunity) {
              OpportunityMap.put((Integer)aggritr.get('Calyear'), (Integer)aggritr.get('amount'));
          }
  
          System.debug('' + opportunityMap);
        }

        // DML Operations:
        // 1.	Create a custom object called as 'Logs'. Create a long text area
        // field called as 'Error'. 

        // Create 100 Lead records using DML operations having a unique name.

        // For all records which were not inserted into Lead object, 
        // insert a record in Log object along with the reason why a record 
        // was not inserted.

        // Also, execute assignment rules to auto allocate Lead records to 
        // correct owner.

        // 2. Find total number of distinct Lead records on basis of 'Lead Source'
        // having greater than 10 leads. 
        // Print this information.

            // SELECT LeadSource
            //      , Count(FirstName)
            //   FROM Lead
            //  GROUP BY LeadSource
            // HAVING COUNT(LeadSource) > 1
        
        // 3. Write a SOQL query to find total number of Lead records by status 
        // by Lead Source. 
        // Store this information in map and display the same.
        // (Hint: map<string,map<string,integer>>)
        public void Nestedmap() {
            List<AggregateResult> myLeadList_1 = [
              SELECT Status
                   , COUNT_DISTINCT(Id) cnt
                FROM Lead
               GROUP BY Status
            ];

            Map<String, Integer> myLeadMap = new map<String, Integer>();
            Map<String, Map<String, Integer>> myleadfinalmap = 
                                              new Map<String, Map<String, Integer>>();

            for(AggregateResult aggitr : myLeadList_1) {
                 myLeadMap.put( (String)aggitr.get('Status'), (Integer)aggitr.get('cnt'));
            }

            List<AggregateResult> myLeadList_2 = [
              SELECT LeadSource
                   , Status
                   , Count(Id)
                FROM Lead
               GROUP BY LeadSource
                      , Status
            ];

            for(AggregateResult aggitr : myLeadList_2) {
                myleadfinalmap.put( (String)aggitr.get('LeadSource'), myLeadMap);
            }

            System.debug('' + myleadfinalmap);
        }

        // ======================================================
        // Relationship query:
        // ======================================================
        // 1. Create a custom object 'A', 'B' and 'C'. Establish 'Master Detail'
        // relationship between them such that 'C' is junction object.

        // Child to Parent
        // ---------------
        // 1. Write a SOQL query on Contact to retrieve all active contacts
        // belonging to 'media' Industry. Also display the name of the account
        // to which it is associated to.

        // SELECT Name
        //      , Account.Name
        //   FROM Contact
        //  WHERE Account.Active__c = ' Yes ' AND Account.Industry = ' Media ' 


        // 2. Write SOQL query on 'C'(created above) to retrieve all records of 
        // 'C' with name 'John' along with parent details.

        // SELECT Name
        //      , A_names__r.Name
        //   FROM C__c
        //  WHERE Name LIKE 'Jo%'

        // Parent to Child
        // --------------
        // 1. Write a SOQL query on Account and find all associated contact
        // records of the Account which contains the word 'John'. 
        // Print all Account and Contact records retrieved above.

        // SELECT (
            // SELECT Name
            //      , Account.Name
            //   FROM Contacts
            //   WHERE FirstName  LIKE 'John'
            // )
        // FROM Account

        // 2. Write a SOQL query to find all Account records which have at
        // least an opportunity record which is 'Closed Won'.
         // SELECT Id
         //        , (
         //             SELECT Name 
         //               FROM Opportunities
         //              WHERE StageName = ' Closed Won ' 
         //          )
         // FROM Account

        // 3. Write a SOQL query on 'A' and retrieve all parents with all their
        // child records where in child name is 'John'.
        //  SELECT id
        //       , (
        //           SELECT Name
        //           FROM Cs__r 
        //           WHERE Name LIKE 'John%'
        //         )
        // FROM A__c

        // SOSL
        // 1. Find the word 'test' in all name fields returning Contact, Account, 
        // Lead and User.

        // FIND {So}
        // IN ALL FIELDS RETURNING Contact, Account, Lead, User       

        
        // 1.  Create a custom object called as 'Logs'.
        // Create a long text area field called as 'Error'. 
        // Create 100 Lead records using DML operations having a unique name.
        // For all records which were not inserted into Lead object,
        // insert a record in Log object along with the reason why a record 
        // was not inserted. Also, execute assignment rules to auto allocate
        // Lead records to correct owner.     
        public void dmlOperations() {
            list<Lead> objlead = new List<Lead>();
            Lead leadobj;
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = TRUE;

            for(Integer i = 0 ; i < 100 ; i++) {
                leadobj = new Lead(
                            FirstName = ' Test_FN_ '
                          ,  LastName = ' LN ' + i
                          ,   Company = ' Eternus ' ,FollowUp__c = system.today() 
                          ,    Status = ' Open-Not Contacted '
                );

                objlead.add(leadobj);
                leadobj.setOptions(dmo);
            }

            objlead.add(new Lead (
                        FirstName = ' Test '
                    ,     Company = ' Eternus '
                    , FollowUp__c = system.today()
                    ,      Status = ' Open-Not Contacted ')
            );

            Database.SaveResult[] srList = Database.insert(objlead , false);
            List<Log__c> myLogList = new List<Log__c>();

            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                   System.debug('Record inserted Sucessfully');
                } else {	
                   for (Database.Error err : sr.getErrors()) {
                        myLogList.add(new Log__c (Name = '' + err.getStatusCode()
                                            , Error__c = '' + err));
                    }
                }
            }

            insert myLogList;
        }

        // 	SOSL
        //  ===================================================================
        // 2. Delete all inactive Account records created in last 90 days.
        public void deleteInactiveAccounts() {
            Date createdDate, todayDate, temp;
            Account[] lstDeleteAccount = new  List<Account>();           
            todayDate = (Date)System.today();

            for (Account a1 :[ SELECT Id
                                   , Name
                                FROM Account
                               WHERE Active__c = ' No '
                             ]
               ) {
                  temp = (Date)a1.CreatedDate;
                  Integer daysBetween = temp.daysBetween(todayDate);
 
                  if (daysBetween <= 90) {
                    lstDeleteAccount.add(a1);
                  }
            }

            delete lstDeleteAccount;
        }  
  }