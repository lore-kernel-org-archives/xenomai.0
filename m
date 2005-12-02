Message-ID: <4390AF3B.1030402@domain.hid>
Date: Fri, 02 Dec 2005 21:31:55 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020102020900060106040000"
Subject: [Xenomai-help] Xeno 2.0 - rt_pipe issue
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

This is a multi-part message in MIME format.
--------------020102020900060106040000
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi all!

Find attached a simple, quick hack of a kernel-user pipe.
(Xeno 2.0 / 2.6.13.4 with the adeos patch)
Sometimes it works, but sometimes just garbage comes out
of the pipe:

muon:/home/xenomai/pipe# ./user
read from pipe: HELLO
read from pipe: JODEL
written string 'World' - see kernel log
muon:/home/xenomai/pipe# ./user
read from pipe: Tµ¿¨qá·Kô·ñó·
read from pipe: Tµ¿¨qá·Kô·ñó·
written string 'World' - see kernel log

I even had a hard lockup. Nothing in the kernel log.

It works perfectly with only one rt_pipe_send in the kernel
module, so most likely I'm missing something with pipe-usage.
We have a saying here in Austria, if someone doesn't see
something obvious to others:
"One is standing on the pipe" ... oh how true ;-)

Thanks for any hints!

Best regards,
Hannes.

--------------020102020900060106040000
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="Makefile"

b2JqLW0JOj0gcGlwZS5vCgpLRElSCTo9IC9saWIvbW9kdWxlcy8kKHNoZWxsIHVuYW1lIC1y
KS9idWlsZApQV0QJCTo9ICQoc2hlbGwgcHdkKQpFWFRSQV9DRkxBR1MgOj0gLUkvdXNyL3Jl
YWx0aW1lL2luY2x1ZGUgLUkvdXNyL2luY2x1ZGUvCgpkZWZhdWx0OgoJJChNQUtFKSAtQyAk
KEtESVIpIFNVQkRJUlM9JChQV0QpIG1vZHVsZXMKCWdjYyAtbyB1c2VyIHVzZXIuYyAtSS91
c3IvcmVhbHRpbWUvaW5jbHVkZQoKCg==
--------------020102020900060106040000
Content-Type: text/x-csrc;
 name="pipe.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pipe.c"

#include <linux/module.h>
#include <native/task.h>
#include <native/pipe.h>

#define PIPE_MINOR 0

#define TASK_PRIO  2               /* Highest RT priority */
#define TASK_MODE  T_FPU|T_CPU(0)  /* Uses FPU, bound to CPU #0 */
#define TASK_STKSZ 4096            /* Stack size (in bytes) */

RT_TASK task_desc;
RT_PIPE pipe_desc;

void task_body (void *cookie) {
    RT_PIPE_MSG *msgout, *msgin;
    int len = sizeof("HELLO");
    msgout = rt_pipe_alloc(len);
    if (msgout) {
		strcpy( P_MSGPTR(msgout), "HELLO");
		if (rt_pipe_send(&pipe_desc, msgout, len, 0) != len) {
			rt_pipe_free(msgout);
		}
      msgout = rt_pipe_alloc(len);
      strcpy( P_MSGPTR(msgout), "JODEL");
      if (rt_pipe_send(&pipe_desc, msgout, len, 0) != len) {
         rt_pipe_free(msgout);
      }
		rt_pipe_receive(&pipe_desc, &msgin, TM_INFINITE);
		printk("received msg> %s, size=%d\n",P_MSGPTR(msgin),P_MSGSIZE(msgin));
		rt_pipe_free(msgin);
	} else {
		printk("ERROR: rt_pipe_alloc\n");
	}
}

int __init init_module (void) {
	int err;
	err = rt_pipe_create(&pipe_desc, "pipetest", PIPE_MINOR);
	if (!err) {
		err = rt_task_create(&task_desc, "MyTaskName", TASK_STKSZ, TASK_PRIO, TASK_MODE);
		if (!err) {
			rt_task_start(&task_desc, &task_body, NULL);
		} else {
			printk("ERROR: cannot create task\n");
			return 0;
		}
	} else {
		printk("ERROR: cannot create pipe\n");
	}
	printk("INIT DONE\n");
	return 0;
}

void __exit cleanup_module (void) {
    rt_pipe_delete(&pipe_desc);
    rt_task_delete(&task_desc);
    printk("CLEANUP DONE\n");
}

MODULE_LICENSE("GPL");



--------------020102020900060106040000
Content-Type: text/x-csrc;
 name="user.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="user.c"

#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <native/pipe.h>

#define PIPE_MINOR 0

int pipe_fd;

int main (int argc, char *argv[]) {
	char devname[32], buf[32];
	sprintf(devname, "/dev/rtp%d", PIPE_MINOR);
	pipe_fd = open(devname, O_RDWR);
    
	if (pipe_fd < 0) {
		printf("cannot open pipe %s\n", devname);
		exit(1);
	}

	read(pipe_fd, buf, sizeof(buf));
	printf("read from pipe: %s\n", buf);
   read(pipe_fd, buf, sizeof(buf));
   printf("read from pipe: %s\n", buf);
	
	write(pipe_fd, "World", sizeof("World"));
	printf("written string 'World' - see kernel log\n");
	
	close(pipe_fd);
}


--------------020102020900060106040000--

