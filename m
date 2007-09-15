From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1ce16a2c0709151255r52e63d66s7d626390c9d97f97@domain.hid>
References: <1ce16a2c0709151255r52e63d66s7d626390c9d97f97@domain.hid>
Content-Type: multipart/mixed; boundary="=-OIy876jXVXUFeW7vaD0q"
Date: Sun, 16 Sep 2007 00:10:09 +0200
Message-Id: <1189894209.25006.193.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] pipe example
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org


--=-OIy876jXVXUFeW7vaD0q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2007-09-15 at 21:55 +0200, Bachman Kharazmi wrote:
> Hi Philippe,
> 
> I'm testing the snippet example code from:
> http://svn.gna.org/viewcvs/xenomai/trunk/ksrc/skins/native/snippets/pipe.c?rev=525&view=markup
> without touching the code at all.

Redirected to xenomai-help. Please always use the mailing list for such
questions.

> 
> But there seem to be issues during compile :/
> sandbox:/home/bkw/code/driver_v5# make
> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -L/usr/xenomai/lib -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
> /usr/xenomai/lib  simpledriver_v5.c   -o simpledriver_v5
> simpledriver_v5.c:47: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before 'task_desc'
> simpledriver_v5.c: In function 'task_body':
> simpledriver_v5.c:51: error: 'RT_PIPE_MSG' undeclared (first use in
> this function)
> simpledriver_v5.c:51: error: (Each undeclared identifier is reported only once
> simpledriver_v5.c:51: error: for each function it appears in.)
> simpledriver_v5.c:51: error: 'msgout' undeclared (first use in this function)
> simpledriver_v5.c:51: error: 'msgin' undeclared (first use in this function)
> simpledriver_v5.c:69: warning: passing argument 1 of 'strcpy' makes
> pointer from integer without a cast
> simpledriver_v5.c:74: error: 'msg' undeclared (first use in this function)
> simpledriver_v5.c: At top level:
> simpledriver_v5.c:81: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before 'init_module'
> simpledriver_v5.c: In function 'cleanup_module':
> simpledriver_v5.c:106: error: 'task_desc' undeclared (first use in
> this function)
> make: *** [simpledriver_v5] Error 1
> 
> Is the purpose that the example code should be more or less compilable?
> 

No, as you can see, it looks like a boilerplate, basically because...it
is a boilerplate.

Here is a compilable one, made of two separate items: a kernel module,
and a userland program, both communicating through a message pipe.
Finding what this example does and how to compile it is left to your
interpretation.


> thanks,
> Bachman
-- 
Philippe.


--=-OIy876jXVXUFeW7vaD0q
Content-Disposition: attachment; filename=rwpipe.c
Content-Type: text/x-csrc; name=rwpipe.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <native/task.h>

int main (int argc, char *argv[])
{
	int fd, count;
	char c = 'x';

	fd = open("/proc/xenomai/registry/native/pipes/data_pipe", O_RDWR);
    
	if (fd < 0) {
		perror("open");
		return 1;
	}

	while (read(fd,&count,sizeof(count)) == sizeof(count)) {
		printf("Count: %d\n", count);
		write(fd,&c,sizeof(c));
	}

	close(fd);

	return 0;
}

--=-OIy876jXVXUFeW7vaD0q
Content-Disposition: attachment; filename=module.c
Content-Type: text/x-csrc; name=module.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 */

#include <native/task.h>
#include <native/pipe.h>

#define TASK_PRIO   99              /* Highest RT priority */
#define TASK_MODE   T_CPU(0)        /* Bound to CPU #0 */
#define TASK_STKSZ  4096            /* Stack size (in bytes) */

static RT_TASK task_desc;

static RT_PIPE pipe_desc;

int task_period_ns = 1000000000;
module_param(task_period_ns,int,0444);
MODULE_PARM_DESC(task_period_ns, "period in ns (default: 1s)");

static void demo_task(void *cookie)
{
	int err, count;
	char c;

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

		rt_pipe_write(&pipe_desc, &count, sizeof(count), P_NORMAL);

		if (rt_pipe_read(&pipe_desc, &c, sizeof(c), TM_INFINITE) == 1)
			++count;
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
	rt_task_delete(&task_desc);
	rt_pipe_delete(&pipe_desc);
}

module_init(demo_init);
module_exit(demo_cleanup);

MODULE_LICENSE("GPL v2");

--=-OIy876jXVXUFeW7vaD0q--


