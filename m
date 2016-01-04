MIME-Version: 1.0
In-Reply-To: <CAH_b-23_3pNhgsH9hRetYNNvuZzppc7CytKn-qyvi266C4-DJQ@mail.gmail.com>
References: <CAH_b-2247JEWnm-M2XxT-T7cshajE799Np1XkEZo2HeWmFa3Tg@mail.gmail.com>
 <CAEb=mKfDbaWc2UfcLrs8Yudo=bZQgpueAvpN0_TghA3UE1sTtw@mail.gmail.com>
 <CAH_b-23_3pNhgsH9hRetYNNvuZzppc7CytKn-qyvi266C4-DJQ@mail.gmail.com>
Date: Mon, 4 Jan 2016 10:22:53 +0800
Message-ID: <CAH_b-22QNb_JiYb6cdKaw90HHcKNkr-kVhGCwsqun5NxeALnfg@mail.gmail.com>
From: jj subot <suprbot2015@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Fwd: ERROR:rt_task_create failed: Operation not permitted
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---------- Forwarded message ----------
From: jj subot <suprbot2015@gmail.com>
Date: 2016-01-04 10:16 GMT+08:00
Subject: Re: [Xenomai] ERROR:rt_task_create failed: Operation not permitted
To: Marco V=C3=A1rzea <marcovarzea.ce@gmail.com>


Hi Marco,

Oh, yes, I have pass this. But actually, there is a problem. When i tried
to run latency test as a regular user with this step:
  write it into sysfs (echo "<gid>" >
/sys/module/xenomai/parameters/allowed_group
I got a error:
   0"000.000| WARNING: [main] cannot open RTDM device
/dev/rtdm/memdev-private: Permission denied
   0"000.000| WARNING: [main] cannot map private umm area: Permission denie=
d
   0"000.000| BUG in init_bind(): [main] (CONFIG_DEVTMPFS_MOUNT not
enabled?)
I check that I have enable the CONFIG_DEVTMPFS_MOUNT config. Then I change
the owner of /dev/rtdm:
   sudo chmod user:user /dev/rtdm/*
And then I can run latency test as a regular user~
But the above problem is still exist, even i run it as a root, i got the
same error info:
Failed to create task: Operation not permitted.


2015-12-31 19:42 GMT+08:00 Marco V=C3=A1rzea <marcovarzea.ce@gmail.com>:

> Hi,
>
> Are you running your application has root? If not you should take a look
> at the following:
>
> http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-use=
r/
>
> Best Regards
> Marco V=C3=A1rzea
>
> 2015-12-31 8:01 GMT+00:00 jj subot <suprbot2015@gmail.com>:
>
>> Hi,
>>
>> Happy new year!
>>
>> I'm a newbie to xenomai and linux, so Help!
>>
>> I  build the xenomai environment on raspberry 2:
>>
>> xenomai 3+ raspbian linux 3.18.20
>>
>> and then i build my test programe, i just try to create a rt task like
>> this:
>>
>>
>> main.cpp:
>>
>>
>> /***********************************************************************=
*****/
>> #include <errno.h>
>> #include <signal.h>
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdbool.h>
>> #include <math.h>
>>
>> #include <rtdm/rtdm.h>
>> #include <alchemy/sem.h>
>> #include <alchemy/mutex.h>
>> #include <alchemy/timer.h>
>>
>> //cobalt
>> #include <sys/mman.h>
>> #include <unistd.h>
>>
>> //trank
>> #include <trank/native/task.h>
>> #include <trank/rtdk.h>
>>
>> #include <pthread.h>
>>
>> RT_TASK my_task;
>>
>> static int run =3D 1;
>>
>>
>> /***********************************************************************=
*****/
>>
>> void my_task_proc(void *arg)
>> {
>>    rt_task_set_periodic(NULL, TM_NOW, 1000000*10); // ns  10ms
>>
>>    while(run);
>> }
>>
>>
>>
>> /***********************************************************************=
*****
>>  * Signal handler
>>
>>  ***********************************************************************=
****/
>>
>> void signal_handler(int sig)
>> {
>>     run =3D 0;
>> }
>>
>>
>>
>> /***********************************************************************=
*****
>>  * Main function
>>
>>  ***********************************************************************=
****/
>>
>> int main(int argc, char *argv[])
>> {
>>     int ret;
>>
>>     /* Perform auto-init of rt_print buffers if the task doesn't do so *=
/
>>     rt_print_auto_init(1);
>>
>>     signal(SIGTERM, signal_handler);
>>     signal(SIGINT, signal_handler);
>>
>>     mlockall(MCL_CURRENT | MCL_FUTURE);
>>
>>     ret =3D rt_task_create(&my_task, "my_task", 0, 80, T_FPU);
>>     if (ret < 0) {
>>         fprintf(stderr, "Failed to create task: %s\n", strerror(-ret));
>>         return -1;
>>     }
>>
>>     printf("Starting my_task...\n");
>>     ret =3D rt_task_start(&my_task, &my_task_proc, NULL);
>>     if (ret < 0) {
>>         fprintf(stderr, "Failed to start task: %s\n", strerror(-ret));
>>         return -1;
>>     }
>>
>>     while (run) {
>>         sched_yield();
>>     }
>>
>>     printf("Deleting realtime task...\n");
>>     rt_task_delete(&my_task);
>>
>>     return 0;
>> }
>>
>>
>> /***********************************************************************=
*****/
>>
>> CmakeLists=EF=BC=9A
>>
>> INCLUDE_DIRECTORIES(/usr/xenomai/include /usr/xenomai/include/xenomai
>> /usr/xenomai/include/cobalt /opt/etherlab/include)
>> LINK_DIRECTORIES(/usr/xenomai/lib)
>> ADD_EXECUTABLE(ecat_t1 main.cpp)
>> TARGET_LINK_LIBRARIES(ecat_t1 rt cobalt copperplate alchemy trank pthrea=
d)
>>
>> When i run it,
>> Failed to create task: Operation not permitted
>> WHY!
>> HELP~
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://xenomai.org/mailman/listinfo/xenomai
>>
>
>
