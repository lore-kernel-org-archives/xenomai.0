Message-ID: <7289437c0802210658w29e21207q74f1cfdf36d6e17c@domain.hid>
Date: Thu, 21 Feb 2008 15:58:11 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3824_13521057.1203605891375"
Subject: [Xenomai-help] Kernel access of bad area with rtdm_event_wait()
	(MPC8347)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_3824_13521057.1203605891375
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I work on a MPC8347 processor and I found out a problem with
rtdm_event_wait(). I reproduce the problem with a simple code :

*driver.c* :
#include <rtdm/rtdm_driver.h>

MODULE_AUTHOR("P.Martignoni");
MODULE_LICENSE("GPL");

#define DEV_FILE_NAME       "DspDev"
#define DRV_NAME            "DspDrv"

#define DEV_FILE_DSP            "dspdev0"

static rtdm_event_t s_ReadEvent;

static int Open(struct rtdm_dev_context    *p_Context,
                rtdm_user_info_t           *p_UserInfo,
                int                        Oflags)
{
    int ret = 0;

    rtdm_event_init(&s_ReadEvent,0);

    // generates an error : Oops : Kernel access of bad area, sig : 11 [#1]
    rtdm_event_wait(&s_ReadEvent);


    return ret;

}

static int Close(struct rtdm_dev_context   *p_Context,
                 rtdm_user_info_t          *p_UserInfo)
{

    rtdm_event_destroy(&s_ReadEvent);

    return 0;
}

/*****************************************************/
/*               Structures rtdm_device              */
/*****************************************************/
static struct rtdm_device t_IdspDevice = {
    struct_version:     RTDM_DEVICE_STRUCT_VER,
    device_flags:       RTDM_NAMED_DEVICE,
    context_size:       0,
    device_name:        DEV_FILE_DSP,

    open_rt:        NULL,
    open_nrt:       Open,

    ops:{
        close_rt:   NULL,
        close_nrt:  Close,
        ioctl_rt:   NULL,
        ioctl_nrt:  NULL,
        read_rt:    NULL,
        read_nrt:   NULL,
        write_rt:   NULL,
        write_rt:   NULL,
        recvmsg_rt: NULL,
        recvmsg_nrt:NULL,
        sendmsg_rt: NULL,
        sendmsg_nrt:NULL,
    },
    device_class:       RTDM_CLASS_EXPERIMENTAL,
    device_sub_class:   222,
    driver_name:        DRV_NAME,
    peripheral_name:    DEV_FILE_NAME,
    provider_name:      "-",
    proc_name:          t_IdspDevice.device_name,
};

/**************************************/
/*          Init Driver               */
/**************************************/
static int ddsp_Init(void)
{

    if(rtdm_dev_register(&t_IdspDevice)!=0)
        rtdm_printk("Enregistrement impossible\n");
    else
        rtdm_printk("Initialisation OK\n");

    return 0;
}

/*************************************/
/*           Exit Driver             */
/*************************************/
static void ddsp_Exit(void)
{

    if(rtdm_dev_unregister(&t_IdspDevice,0))
        rtdm_printk("Desabonnement KO\n");
    else
        rtdm_printk("Desabonnement OK\n");
}

module_init(ddsp_Init);
module_exit(ddsp_Exit);

*App.c* :
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include <sys/mman.h>
#include <native/task.h>

#define DEV_FILE_DSP            "dspdev0"
#define TASK_PRIO             50

static RT_TASK s_TaskTest;

int main(int argc, char * argv[])
{
    int ret = 0;

    mlockall(MCL_CURRENT | MCL_FUTURE);

    // set the currrent task in rt mode
    ret = rt_task_shadow(&s_TaskTest,NULL,1,0);

    rt_dev_open(DEV_FILE_DSP, 0);

    return ret;
}

When I launch this code, I have this error : *Oops : Kernel access of bad
area, sig 11 [#1]

*I notice that if the rtdm_event_wait() is called in a kernel task, there is
no problem.

Have you any idea for my issue ?

Thanks in advance.

------=_Part_3824_13521057.1203605891375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, <br><br>I work on a MPC8347 processor and I found out a problem with rtdm_event_wait(). I reproduce the problem with a simple code : <br><br><u>driver.c</u> : <br>#include &lt;rtdm/rtdm_driver.h&gt;<br><br>MODULE_AUTHOR(&quot;P.Martignoni&quot;);<br>
MODULE_LICENSE(&quot;GPL&quot;);<br><br>#define DEV_FILE_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DspDev&quot;<br>#define DRV_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DspDrv&quot;<br><br>#define DEV_FILE_DSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;dspdev0&quot;<br><br>static rtdm_event_t s_ReadEvent;<br>
<br>static int Open(struct rtdm_dev_context&nbsp;&nbsp;&nbsp; *p_Context, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_user_info_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *p_UserInfo,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Oflags)<br>{&nbsp; <br>&nbsp;&nbsp;&nbsp; int ret = 0;&nbsp;&nbsp; <br><br>&nbsp;&nbsp;&nbsp; rtdm_event_init(&amp;s_ReadEvent,0);<br>
&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; // generates an error : Oops : Kernel access of bad area, sig : 11 [#1]<br>&nbsp;&nbsp;&nbsp; rtdm_event_wait(&amp;s_ReadEvent);<br><br><br>&nbsp;&nbsp;&nbsp; return ret;<br><br>}<br><br>static int Close(struct rtdm_dev_context&nbsp;&nbsp; *p_Context,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_user_info_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *p_UserInfo)<br>{<br><br>&nbsp;&nbsp;&nbsp; rtdm_event_destroy(&amp;s_ReadEvent);<br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>/*****************************************************/<br>/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Structures rtdm_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
/*****************************************************/<br>static struct rtdm_device t_IdspDevice = {<br>&nbsp;&nbsp;&nbsp; struct_version:&nbsp;&nbsp;&nbsp;&nbsp; RTDM_DEVICE_STRUCT_VER,<br>&nbsp;&nbsp;&nbsp; device_flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_NAMED_DEVICE,<br>&nbsp;&nbsp;&nbsp; context_size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
&nbsp;&nbsp;&nbsp; device_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEV_FILE_DSP, <br><br>&nbsp;&nbsp;&nbsp; open_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp; open_nrt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Open,<br><br>&nbsp;&nbsp;&nbsp; ops:{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close_rt:&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close_nrt:&nbsp; Close,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl_rt:&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl_nrt:&nbsp; NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_rt:&nbsp;&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_nrt:&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_rt:&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_rt:&nbsp;&nbsp; NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recvmsg_rt: NULL, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recvmsg_nrt:NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmsg_rt: NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmsg_nrt:NULL,<br>
&nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; device_class:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_CLASS_EXPERIMENTAL,<br>&nbsp;&nbsp;&nbsp; device_sub_class:&nbsp;&nbsp; 222,<br>&nbsp;&nbsp;&nbsp; driver_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRV_NAME,<br>&nbsp;&nbsp;&nbsp; peripheral_name:&nbsp;&nbsp;&nbsp; DEV_FILE_NAME,<br>&nbsp;&nbsp;&nbsp; provider_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;-&quot;,<br>&nbsp;&nbsp;&nbsp; proc_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t_IdspDevice.device_name,<br>
};<br><br>/**************************************/<br>/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Init Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>/**************************************/<br>static int ddsp_Init(void) <br>{<br><br>&nbsp;&nbsp;&nbsp; if(rtdm_dev_register(&amp;t_IdspDevice)!=0) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Enregistrement impossible\n&quot;);<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Initialisation OK\n&quot;);<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>/*************************************/<br>/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Exit Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
/*************************************/<br>static void ddsp_Exit(void) <br>{<br><br>&nbsp;&nbsp;&nbsp; if(rtdm_dev_unregister(&amp;t_IdspDevice,0))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Desabonnement KO\n&quot;);&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Desabonnement OK\n&quot;);<br>
}<br><br>module_init(ddsp_Init);<br>module_exit(ddsp_Exit);<br><br><u>App.c</u> : <br>#include&lt;stdio.h&gt;<br>#include&lt;stdlib.h&gt;<br>#include&lt;string.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>
<br>#define DEV_FILE_DSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;dspdev0&quot;<br>#define TASK_PRIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50<br><br>static RT_TASK s_TaskTest;<br><br>int main(int argc, char * argv[])<br>{<br>&nbsp;&nbsp;&nbsp; int ret = 0;<br><br>&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT | MCL_FUTURE);<br>
&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; // set the currrent task in rt mode<br>&nbsp;&nbsp;&nbsp; ret = rt_task_shadow(&amp;s_TaskTest,NULL,1,0);<br><br>&nbsp;&nbsp;&nbsp; rt_dev_open(DEV_FILE_DSP, 0);<br><br>&nbsp;&nbsp;&nbsp; return ret;<br>}<br><br>When I launch this code, I have this error : <b>Oops : Kernel access of bad area, sig 11 [#1]<br>
<br></b>I notice that if the rtdm_event_wait() is called in a kernel task, there is no problem.<br><br>Have you any idea for my issue ?<br><br>Thanks in advance.<br><br><br>

------=_Part_3824_13521057.1203605891375--

