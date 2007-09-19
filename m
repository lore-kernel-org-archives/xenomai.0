Message-ID: <1ce16a2c0709191006g207ab27cve6d19e6c6f85301b@domain.hid>
Date: Wed, 19 Sep 2007 19:06:20 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <1ce16a2c0709190643l31348293xc5bdd95c3c0680c7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709190643l31348293xc5bdd95c3c0680c7@domain.hid>
Subject: Re: [Xenomai-help] write to pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

I've managed to get it almost working...
I can write a stream of commands which are sent out on rtser0

But I would like to write periodically out at rtser0 using elements
recieved from my pipe. How do I do that?

My module.c looks like:
#include <native/task.h>
#include <native/pipe.h>
#include <rtdm/rtserial.h>

#define TASK_PRIO   10              /* Highest RT priority */
#define TASK_MODE   T_CPU(0)        /* Bound to CPU #0 */
#define TASK_STKSZ  4096            /* Stack size (in bytes) */

static RT_TASK task_desc;

static RT_PIPE pipe_desc;

int task_period_ns = 1000000000;
int fd = -1;
module_param(task_period_ns,int,0444);
MODULE_PARM_DESC(task_period_ns, "period in ns (default: 1s)");

//PORT SETTINGS
static const struct rtser_config write_config = {
	.config_mask       = RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,
	.baud_rate         = 115200,
	.timestamp_history = RTSER_DEF_TIMESTAMP_HISTORY,
};


static void demo_task(void *cookie)
{
	RT_PIPE_MSG *msgin;
	int err, count;
	fd = rt_dev_open("rtser0", 0);
	err = rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
	
	err = rt_task_set_periodic(NULL, TM_NOW,
				   rt_timer_ns2ticks(task_period_ns));
	if (err) {
		printk("rt_task_set_periodic() failed: code %d\n", err);
		rt_task_suspend(NULL);
	}

	for (count = 0;;) {

		err = rt_task_wait_period(NULL);
	
		if (err) {
			if (err != -ETIMEDOUT) {
				printk("rt_task_wait_period() failed: code %d\n", err);
				rt_task_suspend(NULL);
			}
		continue;
		}
		rt_pipe_alloc(&pipe_desc,0);
		
		rt_pipe_receive(&pipe_desc, &msgin, TM_INFINITE);
		//rt_pipe_write(&pipe_desc, &count, sizeof(count), P_NORMAL);
		err=rt_dev_write(fd, P_MSGPTR(msgin), P_MSGSIZE(msgin));
		rt_pipe_free(&pipe_desc,msgin);
		//err=rt_dev_write(fd, "test\n",5);
		//if (rt_pipe_read(&pipe_desc, &c, sizeof(c), TM_INFINITE) == 1)
		//	++count;
	}
}

int demo_init(void)
{
	int err;

	err = rt_pipe_create(&pipe_desc, "data_pipe", P_MINOR_AUTO, 0);

	if (err) {
		printk("rt_pipe_create() failed: code %d\n", err);
		goto fail;
	}

	err = rt_task_create(&task_desc,
			     "kernel_task",
			     TASK_STKSZ,
			     TASK_PRIO,
			     TASK_MODE);

	if (err) {
		printk("rt_task_create() failed: code %d\n", err);
		goto fail;
	}

	err = rt_task_start(&task_desc, &demo_task, NULL);

	if (err)
		printk("rt_task_start() failed: code %d\n", err);

fail:
	return err;
}

void demo_cleanup(void)
{
	rt_dev_close(fd);
	rt_task_delete(&task_desc);
	rt_pipe_delete(&pipe_desc);
}

module_init(demo_init);
module_exit(demo_cleanup);

MODULE_LICENSE("GPL v2");


/Bachman




On 19/09/2007, Bachman Kharazmi <bahkha@domain.hid> wrote:
> Hi.
> I've successfully got a pipe working with a loadable kernel module
> that rpm attached in previous email.
>
> I can write to /dev/rtp0 by simply 'echo foo > /dev/rtp0'
>
> I do also write to serial in the same task.
> The write section to write to pipe and write on rtser0 in my module.c
> looks like:
> rt_pipe_receive(&pipe_desc, &msgin, TM_INFINITE);
> rt_pipe_alloc(&pipe_desc,P_MSGSIZE(msgin));
> err=rt_dev_write(fd, P_MSGPTR(msgin), P_MSGSIZE(msgin));
> rt_pipe_flush(&pipe_desc,0);
> rt_pipe_free(&pipe_desc,msgin);
>
> What I want to is that I want to write data quickly to the pipe, which
> should buffer the written data to it.
> Then the periodic module.c(kernel module) task should get the data
> from the pipe and write it out every period.
>
> This way I can assure that the is a buffer where the data get stored
> first, and then it's periodically written out. Predictable...
>
> Anyhow my problem at the moment is that when I do write to the device
> file /dev/rtp0 quickly this get messed.
>
> For example my java code which writes int:s 1..100 as quick as
> possible to the devicefile.
>
> If I run that java file all I get out from my kernel module which read
> the pipe is maybe  "\0x00" which means only the first added int.
>
> Of course this is not the behavior I'm looking for. :/
>
> My java test code:
> public class testa {
>
>         private static FileOutputStream fos;
>         public static void main(String[] args) {
>                 try {
>                         fos = new FileOutputStream(new File("/dev/rtp0"));
>                 } catch (Exception e) {
>                 }
>                 for (int i = 0; i < 100; i++) {
>                         try {
>                                 fos.write(i);
>                                 fos.flush();
>                         //      Thread.sleep(500);
>                         } catch (Exception e) {
>                         }
>                 }
>                 try{
>                 fos.close();
>                 }
>                 catch (Exception e){
>                 }
>                 }
>         }
>
> By the way, if I comment in the sleep everything works. Buf I don't
> want to do that of course. I want the rttask(module) in kernelspace to
> pick from a already available buffer.
>
> I'm very grateful for any hints.
> Bachman
>

