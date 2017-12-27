  /**
 * Class created for questions under assignment no. 1 set 3
 * Created Date: 12/07/17
 * Author: Soniya Raut
 */   
  public class Pm_1_Set_3 {

      //==================================================================================
      //		Basic Programming (Set 3)
      //==================================================================================

      //  1. Method which will accept Integer parameter and print Fibonacci series upto that number     
      public void printFibonacci(Integer num) {
            Integer first,second,next=0; 
            first = 0;
            second = 1;       

            for(Integer i = 0 ; i < num ; i++) {
                if (i == 0) {
                  System.debug('' + i);
                } else if (i == 1) {
                  System.debug('' + i);
                } else {          
                  next = first + second;
                  System.debug('' + next);
                  first = second;
                  second = next;   
                }
            }     
      }//end of printFibonacci()

      //2. Method to reverse the string    
      public void stringReverse(String str) {
            String[] chars = str.split('');
            System.debug('' + chars);
            String reverse = '';
            System.debug('' + chars.size());

            for (Integer i = chars.size() - 1 ; i >= 0 ; i--) {
                  reverse = reverse + '' + chars[i];
            }

            System.debug('' + reverse);
          }
     
      // 4. Method which will accept String as Parameter and performs following operations :
      // String : ‘Welcome to @pex Programming’        
       public void operateOnString(String str) {
          String tempstr = '';
            // a. Replace the occurrences of ‘@’ with A and print it       
            String[] chars = tempstr.split('');
            for (Integer i = 0 ; i < chars.size() ; i++) {
                if(chars[i] == ' @ ' ) {
                    chars[i] = ' A ';
                }
            }
            str = (String)String.join(chars, '');
            System.debug(String.join(chars, ''));
            
            //  b. Print the substring ‘Apex Programming’         
            System.debug('' + str.substring(10, chars.size()));
            
            //c. Split the String using space and print the result            
            tempstr = str;
            chars = tempstr.split(' ');
            System.debug('' + chars );

            // d. Remove the spaces in the String and Print the result   
            System.debug('' + String.join(chars, ''));

            //-------------------------------------------------------------------------------------------------
            // e. Convert the string to the upper case and print the result
            // f. Convert the string to the lower case and print the result
            //-------------------------------------------------------------------------------------------------
            tempstr = str;
            System.debug('' + tempstr.toUpperCase());
            System.debug('' + tempstr.toLowerCase());
      }
     
      public static String callMeFromAnotherClass() {
      return 'executed';
      }
      
      //	 Advanced concepts / Collections/SOQL Queries/DML Operations (Set 3)      
      //   1. Query on All Contact records & add all to the List and print that list.
      
      public void displayAccount() {
            List<Account> accountList = new List<Account>([
                SELECT Name
                FROM Account
            ]);

            System.debug(''+accountList);
      }

     //2. Write a Method which find all the associated contact records of the Account and Print it      
      public  void displayAssociatedContacts() {
            List<Contact> contactList = new List<Contact>([
              SELECT Id
                   , AccountId
                   , Name
              FROM Contact
            ]);

            System.debug('' + contactList);
      }
      //     3. Create a Account , Contact, Lead , Opportunity record through DML operations.      

      //   4. Write a SQOL Query to show Parent Child relationship and print the result.
      //(for example : Account is parent and Contact is child. Then Query on Account)      
        // SELECT Name
        //      , AccountId
        //      , Account.Name //Calling parent FROM child
        //   FROM Contact     
     
      //  5. Write a SOQL query to retrieve/print the User records where Active = true. 
            // SELECT Name
            //      , Username
            //   FROM User
            //  WHERE IsActive = true

      //    Prepare the  Map having User Id as key and User record as value
      //    (Hint : Map<Id,User>)
      public void displayUsers() {
            Map<Id, User> userMap = new  Map<Id, User> ([
                   SELECT Name
                        , IsActive
                        , Username
                     FROM User
                    WHERE IsActive = true
            ]);

            System.debug('' + userMap);
      }
      
      // 6. Prepare the Following Map Structures :
      // a. AccountName as key and AccountId as Value
      // b. AccountId as key Entire Account object as Value
      public  void displayAccountMap() {
            Map<String, Id> mapAccount_6a = new Map<String, Id>();
            for(Account a : [
                  SELECT Name
                    FROM Account
            ]) {
                mapAccount_6a.put(a.Name, a.Id);
            }

            System.debug('' + mapAccount_6a);
      }
  }