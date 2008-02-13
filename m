Message-ID: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
Date: Wed, 13 Feb 2008 17:29:47 +0100
From: "Salvatore De Astis" <dev.rinux@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2610_13288603.1202920187266"
Subject: [Xenomai-help] Why Xenomai kill my process?
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

------=_Part_2610_13288603.1202920187266
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I need to implement a multitask application.
The most important point is to have a 'custom' exit procedure for each task.
The calling of the exit procedure should happen in asynchronous mode.
The exit procedure of each task, after the 'custom' code, must call  the
rt_task_delete()   before leaving.

The following code is a simple example:
There are two tasks, two semaphores and two other tasks (pending on
semaphores) whose target is to execute the parent's exit procedure.
In this case the exit procedure is the my_exit() routine for both tasks,
but, of course, I'd like to have custom exit procedure for each task.
Please read the questions following the code section.

/*#########################################################*/
#include <stdio.h>
#include <signal.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/sem.h>

#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */


typedef void (*TASK_EP)(void*);

RT_TASK task_desc, task_desc1;
RT_SEM  sem_desc, sem_desc1;

int cleanup (RT_TASK*);
void catch_signal(int);
static char* unique_name_create(void* tid, const char* name);
static RT_TASK* task_id_self(void);

static void my_exit(void* dum)
{
    char* name;
    RT_TASK_INFO info;
    RT_TASK *tid;

    tid = task_id_self();
    rt_task_inquire(tid, &info);
    name = info.name;
    printf("%s: exit\n", name);
    if(cleanup(tid))
        printf("Cleanup Error!\n");
    else
        printf("Cleanup successfull!\n");
}

typedef struct {
    TASK_EP break_routine;
    RT_SEM* sem;
} my_brk;

void break_receiver(my_brk* pbrk)
{
    rt_sem_p(pbrk->sem, TM_INFINITE);
    pbrk->break_routine(NULL);
    rt_sem_delete(pbrk->sem);
    free(pbrk);
}

int set_break_receiver(TASK_EP break_routine, RT_SEM* sem)
{
    const char *brktask_name;
    RT_TASK *tid, *tid_br;
    RT_TASK_INFO info;
    my_brk* pbrk;
    int err;

    pbrk = malloc(sizeof(my_brk));

    tid = rt_task_self();
    err = rt_task_inquire(tid, &info);
    if(err)
        printf("ERROR: rt_task_inquire. error:%d \n", err);


    pbrk->break_routine = break_routine;
    pbrk->sem = sem;

    brktask_name = unique_name_create(tid, "BRK_RCV");
    tid_br = malloc(sizeof(*tid));
    err = rt_task_spawn(tid_br, brktask_name, 20000, info.bprio, 0,
                (TASK_EP)break_receiver, pbrk);
    if(err)
        printf("ERROR: rt_task_spawn. error:%d \n", err);
    return(err);
}

void task_body (void *cookie)
{
    int i=0;

    set_break_receiver(my_exit, &sem_desc);
    rt_task_set_periodic(NULL,TM_NOW,20000);

    for (;;) {
        if(!i){
        i++;
            printf("Pippo task RUNNING!\n");
    }
        rt_task_wait_period(NULL);
    }
}

void task_body_1 (void *cookie)
{
    int i=0;

    set_break_receiver(my_exit, &sem_desc1);
    rt_task_set_periodic(NULL,TM_NOW,20000);

    for (;;) {
        if(!i) {
           printf("CruelPippo task RUNNING!\n");
       i++;
    }
        rt_task_wait_period(NULL);
    }
}

int send_break(void)
{
   int err;
   /*  char *sem_name, *sem_name1;
    RT_SEM sem, sem1;
    RT_SEM_INFO info, info1;


    rt_sem_inquire(&sem_desc, &info);
    sem_name = info.name;
    rt_sem_inquire(&sem_desc1, &info1);
    sem_name1 = info1.name;
    err = rt_sem_bind(&sem, sem_name, TM_NONBLOCK) ||
          rt_sem_bind(&sem1, sem_name1, TM_NONBLOCK);
    if(err) return(err); */
    err = rt_sem_v(&sem_desc) ||
          rt_sem_v(&sem_desc1);
    return(err);
}

int main (int argc, char *argv[])
{
    int err;

    signal(SIGTERM, catch_signal);
    signal(SIGINT, catch_signal);

    mlockall(MCL_CURRENT|MCL_FUTURE);

    err = rt_sem_create(&sem_desc, "PippoBRK_SEM", 0, S_FIFO) ||
          rt_sem_create(&sem_desc1,"CruelPippoBRK_SEM", 0, S_FIFO);
    if (err)
       printf("ERROR: rt_sem_create fail.\n");

    err = rt_task_create(&task_desc,
             "Pippo",
             TASK_STKSZ,
             TASK_PRIO,
             TASK_MODE)  ||
      rt_task_create(&task_desc1,
             "CruelPippo",
             TASK_STKSZ,
             TASK_PRIO,
             TASK_MODE);
    if (!err){
    rt_task_start(&task_desc,&task_body,NULL);
    rt_task_start(&task_desc1,&task_body_1,NULL);
    }
    else
       printf("ERROR: rt_task_create fail.\n");

    pause();
    printf("MAIN exit\n");
    return(err);
}

void catch_signal(int sig)
{
    int err;
    err = send_break();
    if(err)
        printf("Error Sending Break!\n");
    return;
}

int cleanup (RT_TASK* tid)
{
    int err;
    RT_TASK_INFO info;

    rt_task_inquire(tid, &info);
    printf("rt_task_delete(%s) calling...\n", info.name);
    err = rt_task_delete(tid);
    if(!err)
        printf("rt_task_delete done!\n");
    return(err);
}

static char* unique_name_create(void* tid, const char* name)
{
    static char unique_name[XNOBJECT_NAME_LEN];
    unsigned int utid;

    if (strlen(name) + 11 > XNOBJECT_NAME_LEN)
        return(NULL);

    utid = (unsigned int)tid;
    sprintf(unique_name, "0x%8.8x", utid);
    strcpy(unique_name + strlen(unique_name), name);
    return(unique_name);
}

static RT_TASK* task_id_self(void)
{
    RT_TASK *tid;
    unsigned int utid;
    RT_TASK_INFO info;
    char* fullname;

    rt_task_inquire(rt_task_self(), &info);
    fullname = info.name;
    fullname[10] = 0;
    sscanf(fullname,"0x%x", &utid);

    tid = (RT_TASK*)utid;
    return(tid);
}
/*#########################################################*/

When I execute this code, Xenomai Kills my process and the shell shows me
the following output:

Pippo task RUNNING!
CruelPippo task RUNNING!
Pippo: exit
rt_task_delete(Pippo) calling...
I am rt_task_delete user-space calling!
task: 0x804b0a8 - opaque2: 0
rt_task_delete: XENOMAI_SKINCALL1 calling...
Killed

As you see I put some printf in Xenomai*/src/skins/native/task.c to trace
what happens.

I put some printk also in ../ksrc/.. task.c  shadow.c and this is dmesg
output:

Xenomai: I AM xnshadow_sys_bind() in shadow.c.
Xenomai: After ppd test in shadow.c.
Xenomai: in __rt_task_create(Pippo) --> ph.opaque2 =3086322608.
Xenomai: in __rt_task_create(CruelPippo) --> ph.opaque2 =3084864432.
Xenomai: in __rt_task_create(0x0804b0a8BRK_RCV) --> ph.opaque2 =3086256592.
Xenomai: in __rt_task_create(0x0804b120BRK_RCV) --> ph.opaque2 =3086232016.
Xenomai: I AM rt_task_delete() of task:df621010.
Xenomai: After xnpod_asynch_p.
Xenomai: After xnlock_get_irqsave.
Xenomai: After xeno_h2obj_validate.
Xenomai: After __native_task_safewait.
Xenomai: After xnpod_delete_thread.
Xenomai: After xnlock_put_irqrestore.
Xenomai: rt_task_delete END with error: 0
Xenomai: detach_ppd() in shadow.c.
Xenomai: native: cleaning up sem "PippoBRK_SEM" (ret=0).
Xenomai: native: cleaning up sem "CruelPippoBRK_SEM" (ret=0).

Why the opaque2 is 0 in Pippo's rt_task_delete call? Dmesg shows me
3086322608 in __rt_task_create() of Pippo task.
What's wrong with my code?
Does a better method exist to implemet  asyncronous rt_task_delete in
Xenomai?


Thanks for help

Salvatore De Astis

------=_Part_2610_13288603.1202920187266
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I need to implement a multitask application. <br>The most important point is to have a &#39;custom&#39; exit procedure for each task.<br>The calling of the exit procedure should happen in asynchronous mode.<br>The exit procedure of each task, after the &#39;custom&#39; code, must call&nbsp; the&nbsp; rt_task_delete()&nbsp;&nbsp; before leaving.<br>
<br>The following code is a simple example: <br>There are two tasks, two semaphores and two other tasks (pending on semaphores) whose target is to execute the parent&#39;s exit procedure. <br>In this case the exit procedure is the my_exit() routine for both tasks, but, of course, I&#39;d like to have custom exit procedure for each task. <br>
Please read the questions following the code section.<br><br>/*#########################################################*/<br>#include &lt;stdio.h&gt;<br>#include &lt;signal.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>
#include &lt;native/sem.h&gt;<br><br>#define TASK_PRIO&nbsp; 99 /* Highest RT priority */<br>#define TASK_MODE&nbsp; 0&nbsp; /* No flags */<br>#define TASK_STKSZ 0&nbsp; /* Stack size (use default one) */<br><br><br>typedef void (*TASK_EP)(void*);<br>
<br>RT_TASK task_desc, task_desc1;<br>RT_SEM&nbsp; sem_desc, sem_desc1;<br><br>int cleanup (RT_TASK*);<br>void catch_signal(int);<br>static char* unique_name_create(void* tid, const char* name);<br>static RT_TASK* task_id_self(void);<br>
<br>static void my_exit(void* dum)<br>{<br>&nbsp;&nbsp;&nbsp; char* name;<br>&nbsp;&nbsp;&nbsp; RT_TASK_INFO info;<br>&nbsp;&nbsp;&nbsp; RT_TASK *tid;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; tid = task_id_self();<br>&nbsp;&nbsp;&nbsp; rt_task_inquire(tid, &amp;info);<br>&nbsp;&nbsp;&nbsp; name = <a href="http://info.name">info.name</a>;<br>
&nbsp;&nbsp;&nbsp; printf(&quot;%s: exit\n&quot;, name);<br>&nbsp;&nbsp;&nbsp; if(cleanup(tid))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Cleanup Error!\n&quot;);<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Cleanup successfull!\n&quot;); <br>}<br><br>typedef struct {<br>&nbsp;&nbsp;&nbsp; TASK_EP break_routine;<br>
&nbsp;&nbsp;&nbsp; RT_SEM* sem;<br>} my_brk;<br><br>void break_receiver(my_brk* pbrk)<br>{<br>&nbsp;&nbsp;&nbsp; rt_sem_p(pbrk-&gt;sem, TM_INFINITE);<br>&nbsp;&nbsp;&nbsp; pbrk-&gt;break_routine(NULL);<br>&nbsp;&nbsp;&nbsp; rt_sem_delete(pbrk-&gt;sem);<br>&nbsp;&nbsp;&nbsp; free(pbrk);<br>}<br><br>
int set_break_receiver(TASK_EP break_routine, RT_SEM* sem)<br>{<br>&nbsp;&nbsp;&nbsp; const char *brktask_name;<br>&nbsp;&nbsp;&nbsp; RT_TASK *tid, *tid_br;<br>&nbsp;&nbsp;&nbsp; RT_TASK_INFO info;<br>&nbsp;&nbsp;&nbsp; my_brk* pbrk;<br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; pbrk = malloc(sizeof(my_brk));<br>
&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; tid = rt_task_self();<br>&nbsp;&nbsp;&nbsp; err = rt_task_inquire(tid, &amp;info);<br>&nbsp;&nbsp;&nbsp; if(err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;ERROR: rt_task_inquire. error:%d \n&quot;, err);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; pbrk-&gt;break_routine = break_routine;<br>
&nbsp;&nbsp;&nbsp; pbrk-&gt;sem = sem;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; brktask_name = unique_name_create(tid, &quot;BRK_RCV&quot;);<br>&nbsp;&nbsp;&nbsp; tid_br = malloc(sizeof(*tid));<br>&nbsp;&nbsp;&nbsp; err = rt_task_spawn(tid_br, brktask_name, 20000, info.bprio, 0,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (TASK_EP)break_receiver, pbrk);<br>
&nbsp;&nbsp;&nbsp; if(err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;ERROR: rt_task_spawn. error:%d \n&quot;, err);<br>&nbsp;&nbsp;&nbsp; return(err);<br>}<br><br>void task_body (void *cookie)<br>{<br>&nbsp;&nbsp;&nbsp; int i=0;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; set_break_receiver(my_exit, &amp;sem_desc);<br>
&nbsp;&nbsp;&nbsp; rt_task_set_periodic(NULL,TM_NOW,20000);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; for (;;) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!i){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Pippo task RUNNING!\n&quot;);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_wait_period(NULL);<br>&nbsp;&nbsp;&nbsp; }<br>
}<br><br>void task_body_1 (void *cookie)<br>{<br>&nbsp;&nbsp;&nbsp; int i=0;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; set_break_receiver(my_exit, &amp;sem_desc1);<br>&nbsp;&nbsp;&nbsp; rt_task_set_periodic(NULL,TM_NOW,20000);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; for (;;) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!i) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;CruelPippo task RUNNING!\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; i++;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_wait_period(NULL);<br>&nbsp;&nbsp;&nbsp; }<br>}<br><br>int send_break(void)<br>{<br>&nbsp;&nbsp; int err;<br>&nbsp;&nbsp; /*&nbsp; char *sem_name, *sem_name1;<br>&nbsp;&nbsp;&nbsp; RT_SEM sem, sem1;<br>&nbsp;&nbsp;&nbsp; RT_SEM_INFO info, info1;<br>&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; rt_sem_inquire(&amp;sem_desc, &amp;info);<br>&nbsp;&nbsp;&nbsp; sem_name = <a href="http://info.name">info.name</a>;<br>&nbsp;&nbsp;&nbsp; rt_sem_inquire(&amp;sem_desc1, &amp;info1);<br>&nbsp;&nbsp;&nbsp; sem_name1 = <a href="http://info1.name">info1.name</a>;<br>
&nbsp;&nbsp;&nbsp; err = rt_sem_bind(&amp;sem, sem_name, TM_NONBLOCK) || <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_sem_bind(&amp;sem1, sem_name1, TM_NONBLOCK);<br>&nbsp;&nbsp;&nbsp; if(err) return(err); */<br>&nbsp;&nbsp;&nbsp; err = rt_sem_v(&amp;sem_desc) ||<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_sem_v(&amp;sem_desc1);&nbsp;&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; return(err);<br>}<br><br>int main (int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; signal(SIGTERM, catch_signal);<br>&nbsp;&nbsp;&nbsp; signal(SIGINT, catch_signal);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<br>&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; err = rt_sem_create(&amp;sem_desc, &quot;PippoBRK_SEM&quot;, 0, S_FIFO) ||<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_sem_create(&amp;sem_desc1,&quot;CruelPippoBRK_SEM&quot;, 0, S_FIFO);<br>&nbsp;&nbsp;&nbsp; if (err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;ERROR: rt_sem_create fail.\n&quot;);<br>
&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; err = rt_task_create(&amp;task_desc,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&quot;Pippo&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;TASK_STKSZ,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;TASK_PRIO,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;TASK_MODE)&nbsp; ||<br>&nbsp;&nbsp;&nbsp; &nbsp; rt_task_create(&amp;task_desc1,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&quot;CruelPippo&quot;,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;TASK_STKSZ,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;TASK_PRIO,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;TASK_MODE); <br>&nbsp;&nbsp;&nbsp; if (!err){<br>&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task_desc,&amp;task_body,NULL);<br>&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task_desc1,&amp;task_body_1,NULL);<br>
&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;ERROR: rt_task_create fail.\n&quot;);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; pause();<br>&nbsp;&nbsp;&nbsp; printf(&quot;MAIN exit\n&quot;);<br>&nbsp;&nbsp;&nbsp; return(err);<br>}<br><br>void catch_signal(int sig)<br>{<br>&nbsp;&nbsp;&nbsp; int err;<br>
&nbsp;&nbsp;&nbsp; err = send_break();<br>&nbsp;&nbsp;&nbsp; if(err)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;Error Sending Break!\n&quot;);<br>&nbsp;&nbsp;&nbsp; return;<br>}<br><br>int cleanup (RT_TASK* tid)<br>{<br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; RT_TASK_INFO info;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; rt_task_inquire(tid, &amp;info);<br>
&nbsp;&nbsp;&nbsp; printf(&quot;rt_task_delete(%s) calling...\n&quot;, <a href="http://info.name">info.name</a>);<br>&nbsp;&nbsp;&nbsp; err = rt_task_delete(tid);<br>&nbsp;&nbsp;&nbsp; if(!err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;rt_task_delete done!\n&quot;);<br>&nbsp;&nbsp;&nbsp; return(err);<br>
}<br><br>static char* unique_name_create(void* tid, const char* name)<br>{<br>&nbsp;&nbsp;&nbsp; static char unique_name[XNOBJECT_NAME_LEN];<br>&nbsp;&nbsp;&nbsp; unsigned int utid;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (strlen(name) + 11 &gt; XNOBJECT_NAME_LEN) <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return(NULL);<br><br>&nbsp;&nbsp;&nbsp; utid = (unsigned int)tid;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; sprintf(unique_name, &quot;0x%8.8x&quot;, utid);<br>&nbsp;&nbsp;&nbsp; strcpy(unique_name + strlen(unique_name), name);<br>&nbsp;&nbsp;&nbsp; return(unique_name);<br>}<br><br>static RT_TASK* task_id_self(void)<br>
{ <br>&nbsp;&nbsp;&nbsp; RT_TASK *tid;<br>&nbsp;&nbsp;&nbsp; unsigned int utid;<br>&nbsp;&nbsp;&nbsp; RT_TASK_INFO info;<br>&nbsp;&nbsp;&nbsp; char* fullname;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; rt_task_inquire(rt_task_self(), &amp;info);<br>&nbsp;&nbsp;&nbsp; fullname = <a href="http://info.name">info.name</a>;<br>
&nbsp;&nbsp;&nbsp; fullname[10] = 0;<br>&nbsp;&nbsp;&nbsp; sscanf(fullname,&quot;0x%x&quot;, &amp;utid);<br><br>&nbsp;&nbsp;&nbsp; tid = (RT_TASK*)utid;<br>&nbsp;&nbsp;&nbsp; return(tid);<br>}<br>/*#########################################################*/<br><br>When I execute this code, Xenomai Kills my process and the shell shows me the following output:<br>
<br>Pippo task RUNNING!<br>CruelPippo task RUNNING!<br>Pippo: exit<br>rt_task_delete(Pippo) calling...<br>I am rt_task_delete user-space calling!<br>task: 0x804b0a8 - opaque2: 0<br>rt_task_delete: XENOMAI_SKINCALL1 calling...<br>
Killed<br><br>As you see I put some printf in Xenomai*/src/skins/native/task.c to trace what happens.<br><br>I put some printk also in ../ksrc/.. task.c&nbsp;  shadow.c and this is dmesg output:<br><br>Xenomai: I AM xnshadow_sys_bind() in shadow.c.<br>
Xenomai: After ppd test in shadow.c.<br>Xenomai: in __rt_task_create(Pippo) --&gt; ph.opaque2 =3086322608.<br>Xenomai: in __rt_task_create(CruelPippo) --&gt; ph.opaque2 =3084864432.<br>Xenomai: in __rt_task_create(0x0804b0a8BRK_RCV) --&gt; ph.opaque2 =3086256592.<br>
Xenomai: in __rt_task_create(0x0804b120BRK_RCV) --&gt; ph.opaque2 =3086232016.<br>Xenomai: I AM rt_task_delete() of task:df621010.<br>Xenomai: After xnpod_asynch_p.<br>Xenomai: After xnlock_get_irqsave.<br>Xenomai: After xeno_h2obj_validate.<br>
Xenomai: After __native_task_safewait.<br>Xenomai: After xnpod_delete_thread.<br>Xenomai: After xnlock_put_irqrestore.<br>Xenomai: rt_task_delete END with error: 0<br>Xenomai: detach_ppd() in shadow.c.<br>Xenomai: native: cleaning up sem &quot;PippoBRK_SEM&quot; (ret=0).<br>
Xenomai: native: cleaning up sem &quot;CruelPippoBRK_SEM&quot; (ret=0).<br><br>Why the opaque2 is 0 in Pippo&#39;s rt_task_delete call? Dmesg shows me 3086322608 in __rt_task_create() of Pippo task.<br>What&#39;s wrong with my code?<br>
Does a better method exist to implemet&nbsp; asyncronous rt_task_delete in Xenomai? <br><br><br>Thanks for help<br><br>Salvatore De Astis<br><br>

------=_Part_2610_13288603.1202920187266--

