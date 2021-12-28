
import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import scheduleTime from '@salesforce/apex/ScheduleSynchronizationTime.scheduleTime';


export default class CreateSchedulerLWC extends LightningElement {
    timeValue;

    handleInputTimeChange(event) {
        this.timeValue = event.detail.value;
    }

    handleSchedulerClick(event) {
        scheduleTime({schTime: this.timeValue})
            .then(result => {
                if (result) {
                    this.showAlert('Scheduler', 'Synchronization has been successfully scheduled!', 'success')                    
                } else {
                    this.showAlert('Scheduler', 'Sync was not scheduled successfully!', 'error');
                }
                
            })
            .catch(err => {
                this.showAlert(`Scheduler', 'Sync was not scheduled successfully: ${err}`, 'error');                
            });
    }

    showAlert(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
                
    }
}