MIME-Version: 1.0
In-Reply-To: <CAH_b-2247JEWnm-M2XxT-T7cshajE799Np1XkEZo2HeWmFa3Tg@mail.gmail.com>
References: <CAH_b-2247JEWnm-M2XxT-T7cshajE799Np1XkEZo2HeWmFa3Tg@mail.gmail.com>
Date: Thu, 31 Dec 2015 11:42:51 +0000
Message-ID: <CAEb=mKfDbaWc2UfcLrs8Yudo=bZQgpueAvpN0_TghA3UE1sTtw@mail.gmail.com>
From: =?UTF-8?Q?Marco_V=C3=A1rzea?= <marcovarzea.ce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ERROR:rt_task_create failed: Operation not permitted
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jj subot <suprbot2015@gmail.com>
Cc: xenomai@xenomai.org

Hi,

Are you running your application has root? If not you should take a look at
the following:

http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/

Best Regards
Marco V=C3=A1rzea

2015-12-31 8:01 GMT+00:00 jj subot <suprbot2015@gmail.com>:

> Hi,
>
> Happy new year!
>
> I'm a newbie to xenomai and linux, so Help!
>
> I  build the xenomai environment on raspberry 2:
>
> xenomai 3+ raspbian linux 3.18.20
>
> and then i build my test programe, i just try to create a rt task like
> this:
>
>
> main.cpp:
>
>
> /************************************************************************=
****/
> #include <errno.h>
> #include <signal.h>
> #include <stdio.h>
> #include <string.h>
> #include <stdbool.h>
> #include <math.h>
>
> #include <rtdm/rtdm.h>
> #include <alchemy/sem.h>
> #include <alchemy/mutex.h>
> #include <alchemy/timer.h>
>
> //cobalt
> #include <sys/mman.h>
> #include <unistd.h>
>
> //trank
> #include <trank/native/task.h>
> #include <trank/rtdk.h>
>
> #include <pthread.h>
>
> RT_TASK my_task;
>
> static int run =3D 1;
>
>
> /************************************************************************=
****/
>
> void my_task_proc(void *arg)
> {
>    rt_task_set_periodic(NULL, TM_NOW, 1000000*10); // ns  10ms
>
>    while(run);
> }
>
>
>
> /************************************************************************=
****
>  * Signal handler
>
>  ************************************************************************=
***/
>
> void signal_handler(int sig)
> {
>     run =3D 0;
> }
>
>
>
> /************************************************************************=
****
>  * Main function
>
>  ************************************************************************=
***/
>
> int main(int argc, char *argv[])
> {
>     int ret;
>
>     /* Perform auto-init of rt_print buffers if the task doesn't do so */
>     rt_print_auto_init(1);
>
>     signal(SIGTERM, signal_handler);
>     signal(SIGINT, signal_handler);
>
>     mlockall(MCL_CURRENT | MCL_FUTURE);
>
>     ret =3D rt_task_create(&my_task, "my_task", 0, 80, T_FPU);
>     if (ret < 0) {
>         fprintf(stderr, "Failed to create task: %s\n", strerror(-ret));
>         return -1;
>     }
>
>     printf("Starting my_task...\n");
>     ret =3D rt_task_start(&my_task, &my_task_proc, NULL);
>     if (ret < 0) {
>         fprintf(stderr, "Failed to start task: %s\n", strerror(-ret));
>         return -1;
>     }
>
>     while (run) {
>         sched_yield();
>     }
>
>     printf("Deleting realtime task...\n");
>     rt_task_delete(&my_task);
>
>     return 0;
> }
>
>
> /************************************************************************=
****/
>
> CmakeLists=EF=BC=9A
>
> INCLUDE_DIRECTORIES(/usr/xenomai/include /usr/xenomai/include/xenomai
> /usr/xenomai/include/cobalt /opt/etherlab/include)
> LINK_DIRECTORIES(/usr/xenomai/lib)
> ADD_EXECUTABLE(ecat_t1 main.cpp)
> TARGET_LINK_LIBRARIES(ecat_t1 rt cobalt copperplate alchemy trank pthread=
)
>
> When i run it,
> Failed to create task: Operation not permitted
> WHY!
> HELP~
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
