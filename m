Message-ID: <44EF17E8.5040606@domain.hid>
Date: Fri, 25 Aug 2006 17:31:52 +0200
From: Steve Kreyer <steve.kreyer@domain.hid>
MIME-Version: 1.0
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
In-Reply-To: <1154964748.4322.31.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: steve.kreyer@domain.hid
Subject: [Xenomai-help] Timer problems?
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

Ive got a problem using periodic tasks, or timers in generally.
First of all the relevant piece of source:

-----------------------------------------------------------------------------------------------------
#define SLEEP_TIME 100000000

...

static void xmit(void* user_data){
    int err = 0;
    unsigned long timeout;
    err = rt_task_set_periodic(NULL, TM_NOW, SLEEP_TIME);
    if(err < 0){
        fprintf(stderr, "Error: Cannot set rt task 'xmit' periodic! 
errcode=%d\n", err);
        return;
    }
    err = rt_task_wait_period(&timeout);
    if(err < 0)
        fprintf(stderr, "Warning: Cannot wait for task period! 
errcode=%d timeout=%ld\n", err, timeout);
}
...
int main(){
    int err = 0;
    mlockall(MCL_CURRENT | MCL_FUTURE);
    signal(SIGINT, cleanup);
    err = rt_timer_set_mode(TM_ONESHOT);
    if(err < 0){
        fprintf(stderr, "Error: Cannot set rt timer mode to TM_ONESHOT! 
errcode=%d\n", err);
        return 1;
    }
    err = rt_task_spawn(&xmit_task, xmit_task_name, 0, XMIT_TASK_PRIO, 
T_FPU, xmit, NULL);
...
}
-------------------------------------------------------------------------------------------------------------

The task did not wait for the period to which it is set.
I get always an ETIMEDOUT error, and a timer overrun of 16 times when I 
try to call rt_task_wait_period...
Also another problem is, everytime I try to call rt_task_sleep or the 
standard linux library functions pause,sleep or usleep,
my system does not react on inputs anymore and I have to restart the 
machine...
Can anyone tell me whats going on there?
If you need additional informations, please let me know :)

Thanks in advance,
Steve

