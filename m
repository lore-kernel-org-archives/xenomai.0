Date: Mon, 07 Aug 2006 15:05:04 +0200
Message-Id: <1903678222@domain.hid>
MIME-Version: 1.0
From: Steve Kreyer <steve.kreyer@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problems with rt_task_wait_period
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

Hi,

Iam new to xenomai. 
For warming up I try to run this little test program:

-----------------------------------------------------------------------
#include <native/task.h>
#include <stdio.h>
#include <sys/mman.h>

RT_TASK task1;

void rt_task1(void* user_data){
    int err = 0;
    printf("%d\n", rt_task_set_periodic(NULL, TM_NOW, 100));
    err = rt_task_wait_period(NULL);
    if(err){
        fprintf(stderr, "Cannot wait periodic: %d, %d\n", err, EWOULDBLOCK);

    }
}

int main(){
    char* task1_data = NULL;
    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_timer_set_mode(TM_ONESHOT);
    rt_task_spawn(&task1, "task1", 0, 99, 0, rt_task1, &task1_data);
    sleep(10);
    rt_task_delete(&task1);
    return 0;
}
-----------------------------------------------------------------------

But rt_task_wait_period gives me always the Error EWOULDBLOCK, which means that I did not set the task periodic
but which in fact I did... The call to rt_task_set_periodic is succesful.
Can anyone help me figure out why? If you need additional infos please let me know...

Thanks in advance!

Steve

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193


