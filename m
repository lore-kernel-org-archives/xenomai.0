Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 May 2010 19:18:53 -0500
Message-ID: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
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

I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux 2.6.33.4
on a PowerPC MPC5121.  With small values of sleep ticks passed to
rt_task_sleep, I get various sorts of crashes.  Here is a simple program
using a delay loop that exhibits the behavior.


-----
#include <stdio.h>
#include <errno.h>
#include <native/task.h>
#include <native/timer.h>

int main(int argc, char **argv)
{
   int cnt=3D0;
   while(1)
   {
      int ret;
      if((ret =3D rt_task_sleep(rt_timer_ns2ticks(1000UL)))) {
         errno =3D -ret;
         perror("rt_task_sleep");
      }
      if(cnt++ > 100)
         break;
   }
   return 0;
}

If I increase the tick count, it seems to not occur.  The errors I get
are not quite consistent.  Here are a few examples of the output I get
from the kernel log.

-----

[   22.213774] Xenomai: Switching  to secondary mode after exception
#769 from user-space at 0xff7c7ac (pid 571)
[   22.226494] I-pipe: Detected illicit call from domain 'Xenomai'
[   22.226505] <3>        into a service reserved for domain 'Linux' and
below.

-----

[  216.495518] BUG: scheduling while atomic: gatekeeper/0/155/0x00000002
[  216.501932] Modules linked in:
[  216.504933] Call Trace:
[  216.507414] [c7883ed0] [c0008ba0] show_stack+0x3c/0x160 (unreliable)
[  216.513727] [c7883f00] [c001b338] __schedule_bug+0x6c/0x80
[  216.519211] [c7883f20] [c02792ec] schedule+0x5a8/0x5bc
[  216.524345] [c7883f70] [c00737cc] gatekeeper_thread+0x150/0x194
[  216.530250] [c7883fc0] [c003f250] kthread+0x78/0x7c
[  216.535111] [c7883ff0] [c0012ee8] kernel_thread+0x4c/0x68


I'm not sure if I have something misconfigured or what.  I am upgrading
from Xenomai 2.4.10 on an older kernel and I did not have this same
problem.

Thanks.


