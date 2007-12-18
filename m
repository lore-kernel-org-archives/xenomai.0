Message-ID: <35d9c6ed0712180445j76063b97h7ffb397f312860bb@domain.hid>
Date: Tue, 18 Dec 2007 20:45:23 +0800
From: "sarra risto" <sarra.risto@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12057_221490.1197981923307"
Subject: [Xenomai-help] rt_intr_create=-38
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

------=_Part_12057_221490.1197981923307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
In http://www.captain.at/xenomai-parallel-port-interrupt.php, there is a
example about capturing the parallel port interrupt. I have a great interest
in it, so I just want to have a try, but when I compile the code, I found a
error:
start
rt_intr_create=-38
error while rt_task_wait_period, code -110
0 interrupts occured
0 interrupts occured
0 interrupts occured
0 interrupts occured
0 interrupts occured
0 interrupts occured
0 interrupts occured
0 interrupts occured
0 interrupts occured
cleanup
end

it seems it is because the return value of rt_intr_create() API  is not
correct, besides, there is a notice that you should make the

CONFIG_XENO_OPT_NATIVE_INTR=y otherwise it fails with ENOSYS (38)

I met this problem firstly, but I recompile the kernel and xenomai
again,  but I still met the above errors , does somebody can disscuss
with me? Thank you for your attention!

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <fcntl.h>

#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/pipe.h>

#define STACK_SIZE 8192
#define STD_PRIO 1
#define STD_PRIORITY 1
#define HIGH_PRIORITY 99
#define MID_PRIORITY 50
#define BASEPORT 0x378
#define PARPORTINT 7
#define PIPE_MINOR 0

RT_TASK print_task_ptr;
RT_TASK square_task_ptr;
RT_TASK interrupt_task_ptr;
RT_INTR intr_desc; //set rt_intr task
RT_PIPE mypipe;//set rt_pipe task
int int_count = 0;
int end = 0;
int test;

RTIME task_period_ns =   1000000000llu;
RTIME print_period_ns =  1000000000llu;
RTIME square_period_ns =  300000000llu;

void interrupt_task(void *cookie) {
        int err = 0;
        int error;
error = rt_pipe_create(&mypipe, "intpipe", PIPE_MINOR, 0);
while (!end) {
                err = rt_intr_wait(&intr_desc, TM_INFINITE);
                printf("err = %d\n", err);
                if (err > 0) {
                        int_count++;
                printf("int_count = %d\n", int_count);
                        rt_pipe_write(&mypipe, &int_count,
sizeof(int_count), P_NORMAL);
                } else {
}
                rt_intr_enable (&intr_desc);
        }
        rt_pipe_delete(&mypipe);
}
void print_task(void *cookie) {
        unsigned long overrun;
        int ret;
        ret = rt_task_set_periodic(NULL, TM_NOW,
rt_timer_ns2ticks(print_period_ns));
        if (ret) {
                printf("error while set periodic, code %d\n",ret);
return;
        }
        while (!end) {
                ret = rt_task_wait_period(&overrun);
                if (ret) {
                        printf("error while rt_task_wait_period, code
%d\n",ret);
                        return;
                }
                printf("%d interrupts occured\n", int_count);
                fflush(NULL);
        }
}
void squaretask(void *cookie) {
        unsigned long overrun;
        int ret = rt_task_set_periodic(NULL, TM_NOW,
rt_timer_ns2ticks(square_period_ns));
        if (ret) {
                printf("error while set periodic, code %d\n",ret);
                return;
        }
        ret = rt_task_wait_period(&overrun);
return;
        }
        while (!end) {
                ret = rt_task_wait_period(&overrun);
                if (ret) {
                        printf("error while rt_task_wait_period, code
%d\n",ret);
                        return;
                }
                printf("%d interrupts occured\n", int_count);
                fflush(NULL);
        }
}
void squaretask(void *cookie) {
        unsigned long overrun;
        int ret = rt_task_set_periodic(NULL, TM_NOW,
rt_timer_ns2ticks(square_period_ns));
        if (ret) {
                printf("error while set periodic, code %d\n",ret);
                return;
        }
        ret = rt_task_wait_period(&overrun);
        if (ret) {
printf("error while rt_task_wait_period, code %d\n",ret);
                return;
        }
        while (!end) {
                outb_p(0xff, BASEPORT);
                ret = rt_task_wait_period(&overrun);
                if (ret) {
                        printf("error while rt_task_wait_period, code
%d\n",ret);
                        return;
                }
                outb_p(0x00, BASEPORT);
                ret = rt_task_wait_period(&overrun);
                if (ret) {
                        printf("error while rt_task_wait_period, code
%d\n",ret);
                        return;
                }
        }
}
void clean_exit(int dummy) {
        printf("cleanup\n");
 printf("error while rt_task_wait_period, code %d\n",ret);
                return;
        }
        while (!end) {
                outb_p(0xff, BASEPORT);
                ret = rt_task_wait_period(&overrun);
                if (ret) {
                        printf("error while rt_task_wait_period, code
%d\n",ret);
                        return;
                }
                outb_p(0x00, BASEPORT);
                ret = rt_task_wait_period(&overrun);
                if (ret) {
                        printf("error while rt_task_wait_period, code
%d\n",ret);
                        return;
                }
        }
}
void clean_exit(int dummy) {
        printf("cleanup\n");
       rt_task_delete(&print_task_ptr);
        rt_task_delete(&square_task_ptr);
        rt_task_delete(&interrupt_task_ptr);
        rt_intr_delete(&intr_desc);
        rt_pipe_delete(&mypipe);
        printf("end\n");
}

int main(int argc, char *argv[]) {
        int err, fd;
        printf("start\n");
        signal(SIGTERM, clean_exit);
        signal(SIGINT, clean_exit);
if (iopl(3)) {
        printf("iopl err\n");
        exit(1);
}
        outb_p(0x10, BASEPORT + 2);
       // err = rt_intr_create(&intr_desc, "parint", PARPORTINT ,I_NOAUTOENA);
        mlockall(MCL_CURRENT | MCL_FUTURE);
        err = rt_intr_create(&intr_desc, "parint", PARPORTINT, I_NOAUTOENA);



if (err) {
                printf("rt_intr_create = %d\n", err);
                return 0;
        }
        rt_intr_enable(&intr_desc);

        err = rt_task_spawn(&square_task_ptr, "Square", STACK_SIZE, STD_PRIO, 0,
                         &squaretask, NULL);
        if (err) {
                printf("error rt_task_spawn\n");
                return 0;
        }

        err = rt_task_spawn(&interrupt_task_ptr, "Int", STACK_SIZE, STD_PRIO, 0,
                              &interrupt_task, NULL);
        if (err) {
                printf("error rt_task_spawn 2\n");
                return 0;
        }

        err = rt_task_spawn(&print_task_ptr, "Printer", STACK_SIZE,
STD_PRIO, 0,&print_task, NULL);
        if (err) {
                printf("error rt_task_spawn 3\n");
                return 0;
        }
        fd = open("/dev/rtp0", O_RDONLY);
        while (!end) {
                err = read(fd, &test, sizeof(test));
                if (err == -1) {
                        printf("read error\n");
                } else {
                        printf("Read from pipe: %d\n", test);
        }
}
        fflush(NULL);
        return 0;
}

------=_Part_12057_221490.1197981923307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br>In <a href="http://www.captain.at/xenomai-parallel-port-interrupt.php">http://www.captain.at/xenomai-parallel-port-interrupt.php</a>, there is a example about <span class="mcon">capturing the parallel port interrupt. I have a great interest in it, so I just want to have a try, but when I compile the code, I found a error:
<br>start<br>rt_intr_create=-38<br>error while rt_task_wait_period, code -110<br>0 interrupts occured<br>0 interrupts occured<br>0 interrupts occured<br>0 interrupts occured<br>0 interrupts occured<br>0 interrupts occured
<br>0 interrupts occured<br>0 interrupts occured<br>0 interrupts occured<br>cleanup<br>end<br><br>it seems it is because the return value of rt_intr_create() API&nbsp; is not correct, besides, there is a notice that you should make the 
</span><span class="mcon"><pre>CONFIG_XENO_OPT_NATIVE_INTR=y otherwise it fails with ENOSYS (38)<br><br>I met this problem firstly, but I recompile the kernel and xenomai again,  but I still met the above errors , does somebody can disscuss with me? Thank you for your attention!
<br><br>#include &lt;stdio.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;string.h&gt;<br>#include &lt;signal.h&gt;<br>#include &lt;sys/time.h&gt;<br>#include &lt;sys/io.h&gt;<br>#include &lt;sys/mman.h&gt;
<br>#include &lt;sys/types.h&gt;<br>#include &lt;sys/ioctl.h&gt;<br>#include &lt;fcntl.h&gt;<br><br>#include &lt;native/task.h&gt;<br>#include &lt;native/queue.h&gt;<br>#include &lt;native/intr.h&gt;<br>#include &lt;native/pipe.h&gt;
<br><br>#define STACK_SIZE 8192<br>#define STD_PRIO 1<br>#define STD_PRIORITY 1<br>#define HIGH_PRIORITY 99<br>#define MID_PRIORITY 50<br>#define BASEPORT 0x378<br>#define PARPORTINT 7<br>#define PIPE_MINOR 0<br><br>RT_TASK print_task_ptr;
<br>RT_TASK square_task_ptr;<br>RT_TASK interrupt_task_ptr;<br>RT_INTR intr_desc; //set rt_intr task<br>RT_PIPE mypipe;//set rt_pipe task<br>int int_count = 0;<br>int end = 0;<br>int test;<br><br>RTIME task_period_ns =   1000000000llu;
<br>RTIME print_period_ns =  1000000000llu;<br>RTIME square_period_ns =  300000000llu;<br><br>void interrupt_task(void *cookie) {<br>        int err = 0;<br>        int error;<br>error = rt_pipe_create(&amp;mypipe, &quot;intpipe&quot;, PIPE_MINOR, 0);
<br>while (!end) {<br>                err = rt_intr_wait(&amp;intr_desc, TM_INFINITE);<br>                printf(&quot;err = %d\n&quot;, err);<br>                if (err &gt; 0) {<br>                        int_count++;<br>
                printf(&quot;int_count = %d\n&quot;, int_count);<br>                        rt_pipe_write(&amp;mypipe, &amp;int_count, sizeof(int_count), P_NORMAL);<br>                } else {<br>}<br>                rt_intr_enable (&amp;intr_desc);
<br>        }<br>        rt_pipe_delete(&amp;mypipe);<br>}<br>void print_task(void *cookie) {<br>        unsigned long overrun;<br>        int ret;<br>        ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(print_period_ns));
<br>        if (ret) {<br>                printf(&quot;error while set periodic, code %d\n&quot;,ret);<br>return;<br>        }<br>        while (!end) {<br>                ret = rt_task_wait_period(&amp;overrun);<br>                if (ret) {
<br>                        printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);<br>                        return;<br>                }<br>                printf(&quot;%d interrupts occured\n&quot;, int_count);
<br>                fflush(NULL);<br>        }<br>}<br>void squaretask(void *cookie) {<br>        unsigned long overrun;<br>        int ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(square_period_ns));<br>        if (ret) {
<br>                printf(&quot;error while set periodic, code %d\n&quot;,ret);<br>                return;<br>        }<br>        ret = rt_task_wait_period(&amp;overrun);<br>return;<br>        }<br>        while (!end) {
<br>                ret = rt_task_wait_period(&amp;overrun);<br>                if (ret) {<br>                        printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);<br>                        return;<br>
                }<br>                printf(&quot;%d interrupts occured\n&quot;, int_count);<br>                fflush(NULL);<br>        }<br>}<br>void squaretask(void *cookie) {<br>        unsigned long overrun;<br>        int ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(square_period_ns));
<br>        if (ret) {<br>                printf(&quot;error while set periodic, code %d\n&quot;,ret);<br>                return;<br>        }<br>        ret = rt_task_wait_period(&amp;overrun);<br>        if (ret) {<br>printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);
<br>                return;<br>        }<br>        while (!end) {<br>                outb_p(0xff, BASEPORT);<br>                ret = rt_task_wait_period(&amp;overrun);<br>                if (ret) {<br>                        printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);
<br>                        return;<br>                }<br>                outb_p(0x00, BASEPORT);<br>                ret = rt_task_wait_period(&amp;overrun);<br>                if (ret) {<br>                        printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);
<br>                        return;<br>                }<br>        }<br>}<br>void clean_exit(int dummy) {<br>        printf(&quot;cleanup\n&quot;);<br> printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);<br>
                return;<br>        }<br>        while (!end) {<br>                outb_p(0xff, BASEPORT);<br>                ret = rt_task_wait_period(&amp;overrun);<br>                if (ret) {<br>                        printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);
<br>                        return;<br>                }<br>                outb_p(0x00, BASEPORT);<br>                ret = rt_task_wait_period(&amp;overrun);<br>                if (ret) {<br>                        printf(&quot;error while rt_task_wait_period, code %d\n&quot;,ret);
<br>                        return;<br>                }<br>        }<br>}<br>void clean_exit(int dummy) {<br>        printf(&quot;cleanup\n&quot;);<br>       rt_task_delete(&amp;print_task_ptr);<br>        rt_task_delete(&amp;square_task_ptr);
<br>        rt_task_delete(&amp;interrupt_task_ptr);<br>        rt_intr_delete(&amp;intr_desc);<br>        rt_pipe_delete(&amp;mypipe);<br>        printf(&quot;end\n&quot;);<br>}<br><br>int main(int argc, char *argv[]) {<br>
        int err, fd;<br>        printf(&quot;start\n&quot;);<br>        signal(SIGTERM, clean_exit);<br>        signal(SIGINT, clean_exit);<br>if (iopl(3)) {<br>        printf(&quot;iopl err\n&quot;);<br>        exit(1);<br>
}<br>        outb_p(0x10, BASEPORT + 2);<br>       // err = rt_intr_create(&amp;intr_desc, &quot;parint&quot;, PARPORTINT ,I_NOAUTOENA);<br>        mlockall(MCL_CURRENT | MCL_FUTURE);<br>        err = rt_intr_create(&amp;intr_desc, &quot;parint&quot;, PARPORTINT, I_NOAUTOENA);
<br><br><br><br>if (err) {<br>                printf(&quot;rt_intr_create = %d\n&quot;, err);<br>                return 0;<br>        }<br>        rt_intr_enable(&amp;intr_desc);<br><br>        err = rt_task_spawn(&amp;square_task_ptr, &quot;Square&quot;, STACK_SIZE, STD_PRIO, 0,
<br>                         &amp;squaretask, NULL);<br>        if (err) {<br>                printf(&quot;error rt_task_spawn\n&quot;);<br>                return 0;<br>        }<br><br>        err = rt_task_spawn(&amp;interrupt_task_ptr, &quot;Int&quot;, STACK_SIZE, STD_PRIO, 0,
<br>                              &amp;interrupt_task, NULL);<br>        if (err) {<br>                printf(&quot;error rt_task_spawn 2\n&quot;);<br>                return 0;<br>        }<br><br>        err = rt_task_spawn(&amp;print_task_ptr, &quot;Printer&quot;, STACK_SIZE, STD_PRIO, 0,&amp;print_task, NULL);
<br>        if (err) {<br>                printf(&quot;error rt_task_spawn 3\n&quot;);<br>                return 0;<br>        }<br>        fd = open(&quot;/dev/rtp0&quot;, O_RDONLY);<br>        while (!end) {<br>                err = read(fd, &amp;test, sizeof(test));
<br>                if (err == -1) {<br>                        printf(&quot;read error\n&quot;);<br>                } else {<br>                        printf(&quot;Read from pipe: %d\n&quot;, test);<br>        }<br>}<br>
        fflush(NULL);<br>        return 0;<br>}<br><br><br><br><br><br><br>       <br><br><br></pre></span>

------=_Part_12057_221490.1197981923307--

