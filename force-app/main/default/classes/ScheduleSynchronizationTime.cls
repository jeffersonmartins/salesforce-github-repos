/**
 * @description       : Classe para agendar a sincronizar dos repositórios 
 *                      com mais estrelas do GitHub
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
public class ScheduleSynchronizationTime {

    /**
    * @description : Cria o scheduler com a hora passada como parâmetro
    *                Caso exista uma job agenda, cancela primeiro para depois agendar a nova.
    * @author Jefferson Martins | 12-27-2021 
    * @param schTime : Hora que a job será agendada
    **/
    @AuraEnabled
    public static Boolean scheduleTime(String schTime){
        try {
            
            String[] schTimeSplit = schTime.split(':');
            Time scheduleTime = Time.newInstance( Integer.valueOf(schTimeSplit[0]) 
                                                  ,Integer.valueOf(schTimeSplit[1])
                                                  ,0                               
                                                  ,0);                             

            Repository_Schedulable.Scheduler(scheduleTime);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
