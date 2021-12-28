/**
 * @description       : Schedulable para executar a sincronização dos repositórios
 * @author            : Jefferson Martins
 * @group             : 
 * @last modified on  : 12-28-2021
 * @last modified by  : Jefferson Martins
**/
public with sharing class Repository_Schedulable implements Schedulable {
    // Executa em determinada HORA e MINUTO
    private static String CRON_EXP = '00 {0} {1} * * ?';

    public void execute(SchedulableContext ctx) {
        RepositoryService_Callout.getRepositories();
    }


    /**
    * @description : Cria o scheduler com a hora passada como parâmetro
    *                Caso exista uma job agenda, cancela primeiro para depois agendar a nova.
    * @author Jefferson Martins | 12-27-2021 
    * @param schTime : Hora que a job será agendada
    **/
    public static void Scheduler(Time schTime) {
        List<CronTrigger> job = [SELECT  Id FROM CronTrigger  where CronJobDetail.Name = 'Update repositories GitHub'];
        if (job.size() > 0) {
            System.abortJob(job[0].Id);    
        }
        
        String cronExp = String.format(CRON_EXP, new List<Object> {schTime.minute(), schTime.hour()});
        
        Repository_Schedulable repositoriesSch = new Repository_Schedulable();        
        System.schedule('Update repositories GitHub', cronExp, repositoriesSch);
    }
}
