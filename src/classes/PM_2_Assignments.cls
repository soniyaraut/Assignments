public class PM_2_Assignments {

    public void getContacts(){
        List<Contact> records = [
            SELECT id
            	 , name
            FROM Contact];
    
        for(Contact conitr : records){
            System.debug('' + conitr);
        }
    }


}