Message-ID: <7289437c0804030734g7c2fea2h9ba93c1e89e8b699@domain.hid>
Date: Thu, 3 Apr 2008 16:34:47 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <2ff1a98a0804030642i79cf9d98uce4034295d3e2d4d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1886_10451397.1207233287778"
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
	<2ff1a98a0804030642i79cf9d98uce4034295d3e2d4d@domain.hid>
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
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

------=_Part_1886_10451397.1207233287778
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Mixing up RTDM and native API usage, though technically feasible, isn't a
good idea anyway. Better have a look at Hannes' example, >and if that one or
your own version still doesn't work, post more details (Xenomai version,
target architecture, test code, etc.).

I found an example in Native-API-Tour.pdf which do this. I try to follow it
and it doesn't work.

I work on an MPC8347 with linux-2.6.23 and xenomai-2.4.0.

Here is my code :

*In kernel space* : I create a memory heap in init()
----------------------------------------------------------------------------------------------------------------------------------------------
#include <rtdm/rtdm_driver.h>

static struct rtdm_device t_MEMDevice = {
    struct_version:     RTDM_DEVICE_STRUCT_VER,
    device_flags:       RTDM_NAMED_DEVICE,
    context_size:       0,
    device_name:        DEV_FILE_MEMORY,

    open_rt:        NULL,
    open_nrt:       dmem_Open,

    ops:{
        close_rt:   NULL,
        close_nrt:  dmem_Close,
        ioctl_rt:   dmem_Ioctl,
        ioctl_nrt:  dmem_Ioctl,
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
    proc_name:          t_MEMDevice.device_name,
};

static int dmem_Init(void)
{
        RT_HEAP Heap;
        int ret =0;
        void *p_HeapMem = NULL;

        if((ret = rt_heap_create(&Heap, "HeapTest", 2048, H_MAPPABLE |
H_SINGLE)))
        {
           rtdm_printk("Impossible de creer l'espace memoire Heap : ret =
%d\n", ret);
        }

        ret = rt_heap_alloc(&Heap, 0, TM_INFINITE, &p_HeapMem);

        rtdm_printk("**DRIVER p_HeapMem %x \n", p_HeapMem);

        if(ret != 0)
          rtdm_printk("RETOUR ALLOC ret %d\n",ret);


    if(rtdm_dev_register(&t_MEMDevice)!=0)
        rtdm_printk("Enregistrement impossible du device MEMORY\n");
    else
        rtdm_printk("Initialisation OK\n");

    return 0;
}

static void dmem_Exit(void)
{
    if(rtdm_dev_unregister(&t_MEMDevice,0))
        rtdm_printk("Desabonnement KO\n");
    else
        rtdm_printk("Desabonnement OK\n");
}

module_init(dmem_Init);
module_exit(dmem_Exit);
----------------------------------------------------------------------------------------------------------------------------------

I see in /proc/xenomai/registry/native/heaps the *HeapTest  *I create. And I
see that :

* type=kernel:size=3017801728:used=1

In User space :* I want to bind the heap
--------------------------------------------------------------------------------------------------------------------------------
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/heap.h>

#define TASK_PRIO             50

static RT_TASK s_TaskTest;

static void taskTest(void *cookie)
{
    void *p_HeapMem = NULL;
    int i=0;
    int ret=0;
    RT_HEAP Heap;

    ret = rt_heap_bind(&Heap, "HeapTest", TM_INFINITE);
    printf("ret heap_bind %d\n", ret);

    rt_heap_alloc(&Heap, 0, TM_INFINITE, &p_HeapMem);

    printf("p_HeapMem %x \n", p_HeapMem);

}

int main(int argc, char * argv[])
{
    int ret = 0;

    mlockall(MCL_CURRENT | MCL_FUTURE);

      // creation de la tache temps reel TaskTest
    if((ret = rt_task_create(&s_TaskTest, "TaskTest", 0, TASK_PRIO,
T_JOINABLE))){
        fprintf(stderr,"failed to create TaskTest, code %d\n",ret);
        return ret;
    }
    // demarrage de la tache temps reel TaskTest
    if((ret = rt_task_start(&s_TaskTest, &taskTest, (void *)1))){
        fprintf(stderr,"failed to start TaskTest, code %d\n",ret);
        return ret;
    }

    rt_task_join(&s_TaskTest);

    return ret;
}


When I put NONBLOCK, I have the error -11 and when I put TM_INFINITE, it
runs and doesn't stop.

Best Regards,
Perrine


On Thu, Apr 3, 2008 at 3:42 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Thu, Apr 3, 2008 at 12:00 PM, Bosko Radivojevic
> <bosko.radivojevic@domain.hid> wrote:
> > Why don't you try rt_heap_* functions? Quick example:
> >
> >  Kernel space:
> >
> >  RT_HEAP heap_desc;
> >  void *shared;
> >
> >  rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
> >  rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
> >  [.. cleanup ..]
> >  rt_heap_delete (&heap_desc);
> >  User space:
> >
> >  RT_HEAP heap_desc;
> >  void *shared;
> >
> >  rt_heap_bind (&heap_desc, "MySHM", TM_NONBLOCK);
> >  rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
> >  [..cleanup..]
> >  rt_heap_unbind (&heap_desc);
> >
> >  ============================================
> >
> >  Hope this helps :)
>
> This is a bad example. A good example would check the return values of
> the services called.
>
> --
>  Gilles
>

------=_Part_1886_10451397.1207233287778
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&gt;Mixing up RTDM and native API usage, though technically feasible, isn&#39;t
a good idea anyway. Better have a look at Hannes&#39; example, &gt;and if that
one or your own version still doesn&#39;t work, post more details (Xenomai
version, target architecture, test code, etc.).<br><br>I found an example in <span class="a">Native-API-Tour.pdf</span> which do this. I try to follow it and it doesn&#39;t work.<br><br>I work on an MPC8347 with linux-2.6.23 and xenomai-2.4.0.<br>
<br>Here is my code : <br><br><b>In kernel space</b> : I create a memory heap in init()<br>----------------------------------------------------------------------------------------------------------------------------------------------<br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">#include &lt;rtdm/rtdm_driver.h&gt;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static struct rtdm_device t_MEMDevice = {</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; struct_version:&nbsp;&nbsp;&nbsp;&nbsp; RTDM_DEVICE_STRUCT_VER,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_NAMED_DEVICE,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; context_size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEV_FILE_MEMORY, </span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; open_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; open_nrt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmem_Open,</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ops:{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close_rt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close_nrt:&nbsp; dmem_Close,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl_rt:&nbsp;&nbsp; dmem_Ioctl,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl_nrt:&nbsp; dmem_Ioctl,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_rt:&nbsp;&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_nrt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_rt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_rt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recvmsg_rt: NULL, </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recvmsg_nrt:NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmsg_rt: NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmsg_nrt:NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; },</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_class:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_CLASS_EXPERIMENTAL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_sub_class:&nbsp;&nbsp; 222,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; driver_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRV_NAME,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; peripheral_name:&nbsp;&nbsp;&nbsp; DEV_FILE_NAME,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; provider_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;-&quot;,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; proc_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t_MEMDevice.device_name,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">};</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static int dmem_Init(void) </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{&nbsp;&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; RT_HEAP Heap;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; int ret =0;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; void *p_HeapMem = NULL;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if((ret = rt_heap_create(&amp;Heap, &quot;HeapTest&quot;, 2048, H_MAPPABLE | H_SINGLE)))</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Impossible de creer l&#39;espace memoire Heap : ret = %d\n&quot;, ret);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } </span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_heap_alloc(&amp;Heap, 0, TM_INFINITE, &amp;p_HeapMem);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rtdm_printk(&quot;**DRIVER p_HeapMem %x \n&quot;, p_HeapMem);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(ret != 0)</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; rtdm_printk(&quot;RETOUR ALLOC ret %d\n&quot;,ret);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if(rtdm_dev_register(&amp;t_MEMDevice)!=0) </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Enregistrement impossible du device MEMORY\n&quot;);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; else</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Initialisation OK\n&quot;);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return 0;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static void dmem_Exit(void) </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if(rtdm_dev_unregister(&amp;t_MEMDevice,0))</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Desabonnement KO\n&quot;);&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; else</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Desabonnement OK\n&quot;);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">module_init(dmem_Init);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">module_exit(dmem_Exit);</span><br style="font-family: courier new,monospace;">----------------------------------------------------------------------------------------------------------------------------------<br>
<br>I see in /proc/xenomai/registry/native/heaps the <i>HeapTest&nbsp; </i>I create. And I see that : <br><br><b>&nbsp;type=kernel:size=3017801728:used=1<br><br>In User space :</b> I want to bind the heap<br>--------------------------------------------------------------------------------------------------------------------------------<br>
<span style="font-family: courier new,monospace;">#include&lt;stdio.h&gt;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">#include&lt;stdlib.h&gt;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">#include&lt;string.h&gt;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">#include &lt;sys/mman.h&gt;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">#include &lt;native/task.h&gt;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">#include &lt;native/heap.h&gt;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">#define TASK_PRIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">static RT_TASK s_TaskTest;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static void taskTest(void *cookie)</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; void *p_HeapMem = NULL;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int i=0;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret=0;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; RT_HEAP Heap;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ret = rt_heap_bind(&amp;Heap, &quot;HeapTest&quot;, TM_INFINITE);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; printf(&quot;ret heap_bind %d\n&quot;, ret);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; rt_heap_alloc(&amp;Heap, 0, TM_INFINITE, &amp;p_HeapMem);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; printf(&quot;p_HeapMem %x \n&quot;, p_HeapMem);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">int main(int argc, char * argv[])</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret = 0;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT | MCL_FUTURE);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp; &nbsp;&nbsp;&nbsp; // creation de la tache temps reel TaskTest&nbsp;&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if((ret = rt_task_create(&amp;s_TaskTest, &quot;TaskTest&quot;, 0, TASK_PRIO, T_JOINABLE))){</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr,&quot;failed to create TaskTest, code %d\n&quot;,ret);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; }</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; // demarrage de la tache temps reel TaskTest</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if((ret = rt_task_start(&amp;s_TaskTest, &amp;taskTest, (void *)1))){</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr,&quot;failed to start TaskTest, code %d\n&quot;,ret);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; }</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; rt_task_join(&amp;s_TaskTest);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">}</span><br><br><br>When I put NONBLOCK, I have the error -11 and when I put TM_INFINITE, it runs and doesn&#39;t stop.<br>
<br>Best Regards, <br>Perrine<br><br><br><div class="gmail_quote">On Thu, Apr 3, 2008 at 3:42 PM, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Thu, Apr 3, 2008 at 12:00 PM, Bosko Radivojevic<br>
&lt;<a href="mailto:bosko.radivojevic@domain.hid">bosko.radivojevic@domain.hid</a>&gt; wrote:<br>
</div><div><div></div><div class="Wj3C7c">&gt; Why don&#39;t you try rt_heap_* functions? Quick example:<br>
&gt;<br>
&gt; &nbsp;Kernel space:<br>
&gt;<br>
&gt; &nbsp;RT_HEAP heap_desc;<br>
&gt; &nbsp;void *shared;<br>
&gt;<br>
&gt; &nbsp;rt_heap_create (&amp;heap_desc, &quot;MySHM&quot;, 2048, H_SHARED);<br>
&gt; &nbsp;rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
&gt; &nbsp;[.. cleanup ..]<br>
&gt; &nbsp;rt_heap_delete (&amp;heap_desc);<br>
&gt; &nbsp;User space:<br>
&gt;<br>
&gt; &nbsp;RT_HEAP heap_desc;<br>
&gt; &nbsp;void *shared;<br>
&gt;<br>
&gt; &nbsp;rt_heap_bind (&amp;heap_desc, &quot;MySHM&quot;, TM_NONBLOCK);<br>
&gt; &nbsp;rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
&gt; &nbsp;[..cleanup..]<br>
&gt; &nbsp;rt_heap_unbind (&amp;heap_desc);<br>
&gt;<br>
&gt; &nbsp;============================================<br>
&gt;<br>
&gt; &nbsp;Hope this helps :)<br>
<br>
</div></div>This is a bad example. A good example would check the return values of<br>
the services called.<br>
<br>
--<br>
<font color="#888888">&nbsp;Gilles<br>
</font></blockquote></div><br>

------=_Part_1886_10451397.1207233287778--

