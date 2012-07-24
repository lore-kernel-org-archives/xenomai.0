MIME-Version: 1.0
Date: Tue, 24 Jul 2012 16:16:34 +0300
Message-ID: <CADFJ0SqtXayf5pBXPc_DDakb84FPus94AHFRZ9rVdOg+HrpwSA@mail.gmail.com>
From: Eralp Bayraktar <bayraktar.eralp@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Running Xenomai on Intel Atom z510p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have an embedded system which's root is on my machine as nfs directory. I
couldn't do a cross-compile so to eliminate problems I am compiling my
kernel and xenomai on the embedded Atom machine.

Here is my kernel configuration http://pastebin.com/w9uRyUPm

I am using xenomai 2.6.0, and the machine boots properly. After booting I
went to xenomai directory and runned ./configure and *make install,* after
that I also had to run the command *mknod -m 666 /dev/rtheap c 10 254.*

Here is the output of *dmesg | grep -i I-pipe
*
I-pipe 2.8-04: pipeline enabled.
I-pipe: Domain Xenomai registered.

And here is the output of *dmesg | grep -i Xenomai*

Xenomai: hal/i386 started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.

But when I try to run sigdebug or trivialperiodic computer hangs and I need
to restart it. Cursor goes one line below and blinks there, accepting no
input.

I am able to compile and run this

*#include  <rtdk.h>
int main(int argc, char* argv[])
{
  rt_print_auto_init(1);
  rt_printf("start task\n");
}*

This prints start task and exits, I am not sure if this gives any insight
about xenomai though.

When I try to run xeno-test, it again hangs like this
http://imageshack.us/photo/my-images/840/img0011uk.jpg/

What should I do to prevent that hanging?
