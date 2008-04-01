Message-ID: <47F2158F.307@domain.hid>
Date: Tue, 01 Apr 2008 12:59:27 +0200
From: Mouaiad Alras <Mouaiad.Alras@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] difference between "alarm_wait" and
	"task_wait_period"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,
is there any difference between "periodic task" and "periodic alarm 
triggered task" ??

are "task1" and "task2" the same in this example ? :



void task1_do(void *cookies){
       while(1){
            rt_alarm_wait(&alarm1);
            ......
        }
}

int main(void){
    ......
    rt_alarm_create(&alarm1,"alarm1");
    rt_task_create(&task1,"task1",_STK,_PRIO,_MOD);
    rt_task_start(&task1, &task1_do, NULL);
    rt_alarm_start(&alarm1,_OFFSET,_INTERVAL);
    ......
}

===================================

void task2_do(void *cookies){
       while(1){
             rt_task_wait_period(&task2);
             ......
       }
}

int main(void){
    ......
    rt_task_create(&task2,"task2",_STK,_PRIO,_MOD);
    rt_task_set_periodic(&task2,_OFFSET,_INTERVAL);
    rt_task_start(&task2, &task2_do, NULL);
    ......
}




thank you,

