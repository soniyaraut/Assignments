/*
Author: Soniya Raut
Class for Programming Model 1 Assignments Set 1
*/

public class PM_1_Set_1 {

    public PM_1_Set_1() {
        System.debug(' This is Constructor ');
    }

    // 1. Method which will accept Integer as parameter and determine & print the number is
    // even or odd
    public void even_odd_check(Integer num) {
        Integer r = System.Math.mod(num, 2);
        if (r == 0) {
            System.debug(num + ' is a even number');
        } else {
            System.debug(num + ' is a odd number');
        }
    }

    // 2.  Method which will accept Integer parameter and build an print array of upto that Integer
    //     parameter
    //     (For example : If your accepts (Integer) 5 as parameter then build array of any
    //     data-type but array size should be accepted parameter so in this case your array size
    //     should be 5     
    public static List<String> generateStringArray1(Integer n) {
        List<String> str = new List<String>();        
        for (Integer i = 0 ; i < n ; i++) {
            str.add('Test ' + i);
        }
        return str;
    }
    
    // 3. Method which will accept array of Integers as parameters write a code to
    // a. Sort the array in ascending order
    // b. Sort the array in descending order
    // c. Print the Maximum number in the array
    // d. Print the Minimum number in the array
    // e. Print duplicates and its occurrences in the array

    // (for ex: if array is [2,2,3,4,4,5] then your output will be as follows :
    // Number : Appearance
    // 2 : 2
    // 3: 1
    // 4 :2
    // 5 :1
    // )
    public void operations(Integer[] array1) {
        System.debug('' + array1);
    }

    public void ascending(List<Integer> array1) {
        array1.sort();
        System.debug('Minimum element:' + array1.get(0));
        System.debug('Ascending Order:' + array1);
    }

    public void Descending(List<Integer> array1) {
        List<Integer> finalList = new List<Integer>();

        for (Integer i = array1.size()-1 ; i >= 0 ; i--) {
            finalList.add(array1.get(i));
        }

        System.debug('Descending Order:' + finalList);
        System.debug('Maximum element:' + finalList.get(0));   
    }

    public void occurence(List<Integer> array1) {
        Map<Integer, Integer> count = new Map<Integer, Integer>();

        for (Integer key : array1) {
            if (!count.containsKey(key)) {
                count.put(key, 0);
            }
            count.put(key, count.get(key) + 1);
        }
       System.debug(count);
    }

    //  OUTPUT:
    // ArrayOperations ao=new ArrayOperations();
    // List<Integer> myArray = new List<Integer>();
    // myArray.add(30);    
    // myArray.add(90);
    // myArray.add(20);           
    // myArray.add(5);   
    // myArray.add(20);
    // myArray.add(20);
    // myArray.add(5);
    // ao.operations(myArray);
    // ao.ascending(myArray);
    // ao.descending(myArray);
    // ao.occurence(myArray);

    // 4. Method to display the summation of numbers from zero to parameter number
    public void summation(Integer num) {
        Integer sum = 0;
        for (Integer i = 0 ; i <= num ; i++) {
            sum = sum + i;
        }

        System.debug('Sum of numbers till parameter ' + num + ' is : ' + sum);
    }

    // Summation_of_Numbers son=new Summation_of_Numbers();
    // son.summation(5);

    // 5. Method which will calculate the simple interest (Accept necessary parameters)
    public double calculate(Integer p, Integer rate, Integer n) {
       return (p * n * rate) / 100;
    }

    // Simple_Interest si=new Simple_Interest();
    // System.debug('Simple_Interest'+si.calculate(1000,2,2)); 

    // 2. Write a method which will accept following parameters & return the result :
    // Parameter: String : (Value here will be any of the following :
    // ‘SUM’,’SUB’,’MUL’,’DIV’)
    // Parameter: Two Integers :
    // Example :
    // Integer result = Calculator(‘SUM’, 2 ,3);
    // here the result will be 5

    // Public Integer calculator(String operation, Integer inp1 , Integer Inp2) {
    // // Write a logic which will identify the operation & return the result
    // Return Integer ;
    // }

    public Integer calculate(String operation, Integer num1, Integer num2) {
        if (operation.equalsIgnoreCase('sum')) {
            return num1 + num2;
        } else if (operation.equalsIgnoreCase('mul')) {
            return num1 * num2;
        } else if (operation.equalsIgnoreCase('sub')) {
            return num1 - num2;
        } else {
            return num1 / num2;
        }
    }

    // Calculator c=new Calculator();
    // System.debug('Multiplication : '+c.calculate('mul',10,20));
    // System.debug('Addition : '+c.calculate('sum',10,20));
    // System.debug('Subtraction : '+c.calculate('sub',10,20));
    // System.debug('Division : '+c.calculate('div',10,20));

    // 3. Show the demo of Inheritance
    public virtual void run() {
        System.debug('I am running');
    }

    public class Walk extends InheritanceDemo {
        public override void run() {
            System.debug('I am walking');
        }
    }

    // 4. Implement an abstract method
    // 5. Override the abstract method created above
    public class Animal implements Activity {
        public void run() {
            System.debug('Animal Runs');
        }

        public void talk() {
            System.debug('Animals talk, dog=bark, cat=meow');
        }
    }

    public class Humans implements Activity {
        public void run() {
            System.debug('Humans Run');
        }

        public void talk() {
            System.debug('Humans talk in different languages');
        }
    }

    public interface Activity {
        void run();
        void talk();
    }


    // Activity h1=new Humans();
    // h1.run();
    // h1.talk();

    // Activity h2=new Animal();
    // h2.run();
    // h2.talk();

    // Advanced concepts / Collections/SOQL Queries/DML Operations (Set 1)
    // 1. Query on Account object/ records and show/print each account record using :
    // a. Traditional for loop
    // b. Advanced for loop
    // c. While loop
    public void printAccountData() {
        Integer size, j = 0;
        List<Account> accountResultList = [
            SELECT Id
                 , Name
                 , BillingAddress
                 , Phone
              FROM Account
        ];

        //Traditional for loop
        for (Integer i = 0 ; i < accountResultList.size() ; i++) {
            System.debug('' + accountResultList[i]);
        }

        //Advanced for loop
        for (Account tempobj : accountResultList) {
            System.debug('' + tempobj);
        }

        //While Loop
        size = accountResultList.size();
        while(size != 0) {
            System.debug('' + accountResultList.get(j));
            size--;
            j++;
        }
    }//end of printAccountData

    // 2. Query on all Lead records & add ID of record to the set and print that set.
    public void printLeadRecords() {
        List<Lead> recordId = [
            SELECT Id
             FROM Lead
        ];

        Set<Lead> ids = new Set<Lead>(recordId);
        LeadRecords lr = new LeadRecords();
        lr.print();

        for (Lead l : ids) {
            System.debug('' + l);
        }
    }

}



//3. Create a Account Record with Name =”Eternus”. Create associated contacts.
//Create a Custom field called Contact Count on Account . Query on Contact
//where Account.Name =”Eternus” and count the associated contacts. Update
//the custom field on Accounts with that count.
