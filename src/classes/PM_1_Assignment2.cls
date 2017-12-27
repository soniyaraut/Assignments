/*
Author: Soniya Raut
Class for Programming Model 1 Assignments Set 2
*/
	public class PM_1_Assignment2 {

		//  1.Method which will accept Integer as parameter and determine & print the number is
		// prime or not
		public void checkPrime(Integer num) {
			Integer count = 0;
			for (Integer i = 0 ; i < num / 2 ; i++) {
				if (Math.mod(i, num) == 0) {
					count++;
				}
			}

			if (count > 0) {
				System.debug('Prime');
			} else {
				System.debug('Not prime');
			}
		}

		// 2.Accept String as a parameter and print whether it is a palindrome or not
		public void checkPalindrome(String str) {
			String mystr = str.reverse();

			if (mystr.equals(str)) {
				System.debug('Palindrome');
			} else {
				System.debug('Not palindrome');
			}
		}

		// 3. Method to replace every occurrence of 'a' character FROM each String in an array accept
		// both character and array of strings as param
		public void replaceStringwith_a(String str,String a) {
			String[] chars = str.split('');
			for (Integer j = 0 ; j < str.length() ; j++) {
				if (chars[j] == 'a' ) {
					chars[j] = a;
				}
			}

			System.debug(String.join(chars, ''));
		}

		// 3. Method to count the length of a String (not using length function)
		public void find_Length_of_string(String str) {
			String[] chars = str.split('');
			Integer length_of_string = 0;
			length_of_string = str.lastIndexOf('') - 1;
			System.debug('Length of String : \t' + length_of_string);
		}
		
		// 5. Method to find only the unique numbers in an array (accept array as a parameter) Hint:
		// Use list and set
		public void find_Unique_Array_Numbers(List<Integer> array_of_numbers) {
			System.debug('You have list : ' + array_of_numbers);
			Set<Integer> myUniqueNumberSet = new Set<Integer> ( array_of_numbers ) ;
			System.debug('Unique List : ' + myUniqueNumberSet);
		}


		//  OOPS Concepts (Set 2)
		// 1. Show the demo of parameterized constructor
		// 2. Show the demo of method overriding
		// 3. Declare the variables with static and identify its result
		// 4. Implement an abstract method
		// 5. Override the abstract method created above
		// 6. State the basic difference between an interface and an abstract class (common for all)
		public PM_1_Assignment2() {
			System.debug('This is default constructor');
		}

		public  PM_1_Assignment2(String mystring) {
			System.debug('This is parameterised constructor with String parameter : ' + mystring);
		}

		// Advanced concepts / Collections/SOQL Queries/DML Operations (Set 2)
		// 1. Query on Account object /records and if the account is person account print the ID of
		// that record. (Hint : You have to enable person account )
		// a. Print the result using traditional for loop
		// b.. Print the result using advanced for loop

		// 2.Query on all Opportunity records WHERE its Account != NULL and Status = Closed
		// c. Prepare the Map having Key as OpportunityId and Value as AccountId
		   // 2.SELECT id
		   //         , Name
		   //         , StageName
		   //         , Account.Name
		   //      FROM Opportunity
		   //      WHERE StageName LIKE '%Closed%'  AND Account.Name != NULL
		
		//2a. Add all Opportunity Id’s to the List and print the result 
		public void displayOpportunity() {        
			for (Opportunity o : [
				SELECT Id
				  FROM Opportunity
			]) {
				System.debug('' + o);
			}
		}   

		// 2.b.Add all Account Id’s to the set and print the result  
		public void displayAccount() {
			Set<Id> myset11 = new Set<Id>();

			for (Account accitr : [
				SELECT Id
				  FROM Account
			]) {
				myset11.add(accitr.Id);
			}
		}   

		public void two_A_c() {
			Map<Id, Set<Id>> map_of_Account = new Map<Id, Set<Id>>();
			Map<Id, Opportunity> map_of_Opportunity = new Map<Id, Opportunity>([
				SELECT Id
					 , AccountId
				  FROM Opportunity
			]);

			System.debug('' + map_of_Opportunity);

			// Now let's get the accountId
			Set<Id> accountId = new Set<Id>();
			for (Opportunity op : map_of_Opportunity.values()) {
				accountId.add(op.AccountId);
			}

			System.debug('' + accountId);

			// Put them together
			for (Id opId : map_of_Opportunity.keySet()) {
				map_of_Account.put(opId,accountId);
			}
			// Done        
	   }

		public void four_A() {
			Map<Id, List<Opportunity>> myMap = new Map<Id, List<Opportunity>>();
			
			for (Opportunity o : [
				SELECT Id
					 , AccountId
				  FROM Opportunity
			]) {
				if (mymap.containsKey(o.AccountId)) {
					List<Opportunity> oppOfAccount = mymap.get(o.AccountId);
					oppOfAccount.add(o);
					myMap.put(o.AccountId, oppOfAccount);
				} else {
					List<Opportunity> oppOfAccount = new List<Opportunity>();
					oppOfAccount.add(o);
					mymap.put(o.AccountId, oppOfAccount);
				}           
			}

			System.debug('' + myMap);
		}

		// Find all the Account Names starting with ‘a’. Print that count and update all those
		// accounts with New Name as ‘Updated via update DML operation’.

		public void accountUpdate() {
			List<Account> mylst = [
				SELECT Id
				  FROM Account
				 WHERE Name LIKE 'A%'
			];

			for (Account a1 : mylst) {
				a1.Name = ' Updated via update DML operation ';
			}

			try {
				update mylst;
				System.debug('Updated');
			} catch (DmlException e) {
				System.debug('' + e.getMessage());
			}

		 }

		// Write a SOQL Query on to retrieve/print 10 Campaign records and sort in ascending
		// as well as descending order

			// SELECT Name
			//   FROM Campaign
			//  ORDER BY Name DESC NULLS LAST
			//  LIMIT 10

			// SELECT Name
			//   FROM Campaign
			//  ORDER BY Name ASC NULLS LAST
			//  LIMIT 10

		// Write a SOQL query to retrieve/print the Contact records WHERE Last Modified Date =
		// Today

			// SELECT Name
			//      , LastModifiedBy
			//   FROM Contact
			//  WHERE LastModifiedDate = TODAY
		
	}