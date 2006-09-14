Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
Content-Type: multipart/alternative; boundary=Apple-Mail-28--445806384
From: ckreider <ckreider@domain.hid>
Date: Thu, 14 Sep 2006 12:06:59 -0400
Subject: [Xenomai-help] inscrutable pipes
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


--Apple-Mail-28--445806384
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Proud though I am, it is time to ask for help.  I have used pipes  
with RTLinux but want to use Xenomai this time.  I can't get pipes  
working.

(as an aside, I saw on here where if you do make install, it will  
create the necessary /dev/rtp* entries.  I work on a development host  
and do not compile on the target, so I do not run make install.  I  
finally found the mknod magic in a message on this list)

I am using Xenomai 2.2.1 with a 2.6.17.8 kernel.

I finally took Captain's example and added the missing function  
parameters, but it did not work.  Then I tried an example from a  
message here, which appears to be derived from Captain's example.   
Again, I had to add missing function parameters, and again it did not  
work.  I compared the examples to  ksrc/skins/native/snippets/pipe.c,  
and they look correct, except that the snippet is missing some  
function parameters also.

First the results:

try1:
insmod pipe.ko, ./user

kernel: rt_pipe_alloc starting
kernel: rt_pipe_alloc done - no errors
kernel: rt_pipe_send starting
kernel: rt_pipe_send done - no errors
kernel: rt_pipe_receive starting
kernel: INIT DONE - no errors

"user" is sleeping in read

try2:
insmod pipe.ko, cat /dev/rtp0

kernel: rt_pipe_alloc starting
kernel: rt_pipe_alloc done - no errors
kernel: rt_pipe_send starting
kernel: rt_pipe_send done - no errors
kernel: rt_pipe_receive starting
kernel: INIT DONE - no errors

cat hangs waiting for input

try3:
insmod pipe.ko, echo "World" >/dev/rtp0

kernel: rt_pipe_alloc starting
kernel: rt_pipe_alloc done - no errors
kernel: rt_pipe_send starting
kernel: rt_pipe_send done - no errors
kernel: rt_pipe_receive starting
kernel: INIT DONE - no errors
kernel: received msg> World
kernel: , size=6
kernel: rt_pipe_receive done

Obviously I got the right major/minor for /dev/rtp* as the rt task  
reads my echo.  Neither "user" or "cat" read anything from the rt task.

The code:

==== user.c ====
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <native/pipe.h>

#define PIPE_MINOR 0

int pipe_fd;

int main (int argc, char *argv[])
         {
         char devname[32], buf[32];
         sprintf(devname, "/dev/rtp%d", PIPE_MINOR);
         pipe_fd = open(devname, O_RDWR);

         if (pipe_fd < 0)
                 {
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


==== pipe.c ====
#include <linux/module.h>
#include <native/task.h>
#include <native/pipe.h>

#define PIPE_MINOR 0

#define TASK_PRIO  2               /* Highest RT priority */
#define TASK_MODE  T_FPU|T_CPU(0)  /* Uses FPU, bound to CPU #0 */
#define TASK_STKSZ 4096            /* Stack size (in bytes) */

RT_TASK task_desc;
RT_PIPE pipe_desc;

void task_body (void *cookie)
         {
         RT_PIPE_MSG * msgout, *msgin;
         int len = sizeof("HELLO");
         printk("rt_pipe_alloc starting\n");
         msgout = rt_pipe_alloc(&pipe_desc, len);
         if (msgout)
                 {
                 printk("rt_pipe_alloc done - no errors\n");
                 strcpy(P_MSGPTR(msgout), "HELLO");
                 printk("rt_pipe_send starting\n");
                 if (rt_pipe_send(&pipe_desc, msgout, len, 0) != len)
                         {
                         rt_pipe_free(&pipe_desc, msgout);
                         }
                 printk("rt_pipe_send done - no errors\n");
                 printk("rt_pipe_receive starting\n");
                 rt_pipe_receive(&pipe_desc, &msgin, TM_INFINITE);
                 printk("received msg> %s, size=%d\n", P_MSGPTR 
(msgin), P_MSGSIZE
                         (msgin));
                 printk("rt_pipe_receive done\n");
                 rt_pipe_free(&pipe_desc, msgin);
                 }
         else
                 {
                 printk("ERROR: rt_pipe_alloc\n");
                 }
         }

int __init init_module (void)
         {
         int err;
         err = rt_pipe_create(&pipe_desc, "pipetest", PIPE_MINOR, 0);
         if (!err)
                 {
                 err = rt_task_create(&task_desc, "MyTaskName",  
TASK_STKSZ,
                         TASK_PRIO, TASK_MODE);
                 if (!err)
                         {
                         rt_task_start(&task_desc, &task_body, NULL);
                         }
                 else
                         {
                         printk("ERROR: cannot create task\n");
                         return 0;
                         }
                 }
         else
                 {
                 printk("ERROR: cannot create pipe\n");
                 return 0;
                 }
         printk("INIT DONE - no errors\n");
         return 0;
         }

void __exit cleanup_module (void) {
     rt_pipe_delete(&pipe_desc);
     rt_task_delete(&task_desc);
     printk("CLEANUP DONE\n");
}

MODULE_LICENSE("GPL");



---
Carl Kreider
ckreider@domain.hid




--Apple-Mail-28--445806384
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV>Proud though I am, it is =
time to ask for help.=A0 I have used pipes with RTLinux but want to use =
Xenomai this time.=A0 I can't get pipes working.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>(as an aside, I saw on here =
where if you do make install, it will create the necessary /dev/rtp* =
entries.=A0 I work on a development host and do not compile on the =
target, so I do not run make install.=A0 I finally found the mknod magic =
in a message on this list)</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I am using Xenomai 2.2.1 =
with a 2.6.17.8 kernel.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I finally took Captain's =
example and added the missing function parameters, but it did not work.=A0=
 Then I tried an example from a message here, which appears to be =
derived from Captain's example.=A0 Again, I had to add missing function =
parameters, and again it did not work.=A0 I compared the examples to=A0 =
ksrc/skins/native/snippets/pipe.c, and they look correct, except that =
the snippet is missing some function parameters also.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>First the =
results:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>try1:</DIV><DIV>insmod =
pipe.ko, ./user</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>kernel: rt_pipe_alloc =
starting</DIV><DIV>kernel: rt_pipe_alloc done - no =
errors</DIV><DIV>kernel: rt_pipe_send starting</DIV><DIV>kernel: =
rt_pipe_send done - no errors</DIV><DIV>kernel: rt_pipe_receive =
starting</DIV><DIV>kernel: INIT DONE - no errors</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>"user" is sleeping in =
read</DIV><DIV>=A0</DIV><DIV>try2:</DIV><DIV>insmod pipe.ko, cat =
/dev/rtp0</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>kernel: rt_pipe_alloc =
starting</DIV><DIV>kernel: rt_pipe_alloc done - no =
errors</DIV><DIV>kernel: rt_pipe_send starting</DIV><DIV>kernel: =
rt_pipe_send done - no errors</DIV><DIV>kernel: rt_pipe_receive =
starting</DIV><DIV>kernel: INIT DONE - no errors</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>cat hangs waiting for =
input</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>try3:</DIV><DIV>insmod =
pipe.ko, echo "World" &gt;/dev/rtp0</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>kernel: rt_pipe_alloc =
starting</DIV><DIV>kernel: rt_pipe_alloc done - no =
errors</DIV><DIV>kernel: rt_pipe_send starting</DIV><DIV>kernel: =
rt_pipe_send done - no errors</DIV><DIV>kernel: rt_pipe_receive =
starting</DIV><DIV>kernel: INIT DONE - no errors</DIV><DIV>kernel: =
received msg&gt; World</DIV><DIV>kernel: , size=3D6</DIV><DIV>kernel: =
rt_pipe_receive done</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Obviously I got the right =
major/minor for /dev/rtp* as the rt task reads my echo.=A0 Neither =
"user" or "cat" read anything from the rt task.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>The code:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>=3D=3D=3D=3D user.c =
=3D=3D=3D=3D</DIV><DIV>#include &lt;sys/types.h&gt;</DIV><DIV>#include =
&lt;fcntl.h&gt;</DIV><DIV>#include &lt;string.h&gt;</DIV><DIV>#include =
&lt;stdio.h&gt;</DIV><DIV>#include &lt;native/pipe.h&gt;</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>#define PIPE_MINOR =
0</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>int =
pipe_fd;</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>int =
main (int argc, char *argv[])</DIV><DIV>=A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =
=A0 =A0 =A0 char devname[32], buf[32];</DIV><DIV>=A0 =A0 =A0 =A0 =
sprintf(devname, "/dev/rtp%d", PIPE_MINOR);</DIV><DIV>=A0 =A0 =A0 =A0 =
pipe_fd =3D open(devname, O_RDWR);</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>=A0 =A0 =A0 =A0 if (pipe_fd =
&lt; 0)</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 printf("cannot open pipe %s\n", =
devname);</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);</DIV><DIV>=A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>=A0 =A0 =A0 =A0 =
read(pipe_fd, buf, sizeof(buf));</DIV><DIV>=A0 =A0 =A0 =A0 printf("read =
from pipe: %s\n", buf);</DIV><DIV>=A0 =A0 =A0 =A0 read(pipe_fd, buf, =
sizeof(buf));</DIV><DIV>=A0 =A0 =A0 =A0 printf("read from pipe: %s\n", =
buf);</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>=A0 =A0 =
=A0 =A0 write(pipe_fd, "World", sizeof("World"));</DIV><DIV>=A0 =A0 =A0 =
=A0 printf("written string 'World' - see kernel log\n");</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>=A0 =A0 =A0 =A0 =
close(pipe_fd);</DIV><DIV>=A0 =A0 =A0 =A0 }</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>=3D=3D=3D=3D pipe.c =
=3D=3D=3D=3D</DIV><DIV>#include =
&lt;linux/module.h&gt;</DIV><DIV>#include =
&lt;native/task.h&gt;</DIV><DIV>#include =
&lt;native/pipe.h&gt;</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>#define PIPE_MINOR =
0</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>#define =
TASK_PRIO=A0 2=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 /* Highest RT priority =
*/</DIV><DIV>#define TASK_MODE=A0 T_FPU|T_CPU(0)=A0 /* Uses FPU, bound =
to CPU #0 */</DIV><DIV>#define TASK_STKSZ 4096=A0 =A0 =A0 =A0 =A0 =A0 /* =
Stack size (in bytes) */</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>RT_TASK =
task_desc;</DIV><DIV>RT_PIPE pipe_desc;</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>void task_body (void =
*cookie)</DIV><DIV>=A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =A0 =A0 =A0 =
RT_PIPE_MSG * msgout, *msgin;</DIV><DIV>=A0 =A0 =A0 =A0 int len =3D =
sizeof("HELLO");</DIV><DIV>=A0 =A0 =A0 =A0 printk("rt_pipe_alloc =
starting\n");</DIV><DIV>=A0 =A0 =A0 =A0 msgout =3D =
rt_pipe_alloc(&amp;pipe_desc, len);</DIV><DIV>=A0 =A0 =A0 =A0 if =
(msgout)</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 printk("rt_pipe_alloc done - no =
errors\n");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
strcpy(P_MSGPTR(msgout), "HELLO");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 printk("rt_pipe_send starting\n");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (rt_pipe_send(&amp;pipe_desc, msgout, len, 0) !=3D =
len)</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
{</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
rt_pipe_free(&amp;pipe_desc, msgout);</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 }</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
printk("rt_pipe_send done - no errors\n");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 printk("rt_pipe_receive starting\n");</DIV><DIV>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 rt_pipe_receive(&amp;pipe_desc, &amp;msgin, =
TM_INFINITE);</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("received =
msg&gt; %s, size=3D%d\n", P_MSGPTR(msgin), P_MSGSIZE</DIV><DIV>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (msgin));</DIV><DIV>=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 printk("rt_pipe_receive done\n");</DIV><DIV>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 rt_pipe_free(&amp;pipe_desc, msgin);</DIV><DIV>=A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 }</DIV><DIV>=A0 =A0 =A0 =A0 else</DIV><DIV>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
printk("ERROR: rt_pipe_alloc\n");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 }</DIV><DIV>=A0 =A0 =A0 =A0 }</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>int __init init_module =
(void)</DIV><DIV>=A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =A0 =A0 =A0 int =
err;</DIV><DIV>=A0 =A0 =A0 =A0 err =3D rt_pipe_create(&amp;pipe_desc, =
"pipetest", PIPE_MINOR, 0);</DIV><DIV>=A0 =A0 =A0 =A0 if =
(!err)</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {</DIV><DIV>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 err =3D rt_task_create(&amp;task_desc, "MyTaskName", =
TASK_STKSZ, </DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
TASK_PRIO, TASK_MODE);</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(!err)</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
{</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
rt_task_start(&amp;task_desc, &amp;task_body, NULL);</DIV><DIV>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 else</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
{</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
printk("ERROR: cannot create task\n");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 return 0;</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 }</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
}</DIV><DIV>=A0 =A0 =A0 =A0 else</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 {</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("ERROR: cannot =
create pipe\n");</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;</DIV><DIV>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }</DIV><DIV>=A0 =A0 =A0 =A0 =
printk("INIT DONE - no errors\n");</DIV><DIV>=A0 =A0 =A0 =A0 return =
0;</DIV><DIV>=A0 =A0 =A0 =A0 }</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>void __exit cleanup_module =
(void) {</DIV><DIV>=A0 =A0 rt_pipe_delete(&amp;pipe_desc);</DIV><DIV>=A0 =
=A0 rt_task_delete(&amp;task_desc);</DIV><DIV>=A0 =A0 printk("CLEANUP =
DONE\n");</DIV><DIV>}</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>MODULE_LICENSE("GPL");</DIV><=
DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BR><DIV> <SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>---</DIV><DIV>Carl Kreider</DIV><DIV><A =
href=3D"mailto:ckreider@domain.hid">ckreider@domain.hid</A></DIV><DIV><B=
R class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN> =
</DIV><BR></BODY></HTML>=

--Apple-Mail-28--445806384--

