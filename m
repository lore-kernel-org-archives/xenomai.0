From: "Mauro S." <mau.salvi@tin.it>
Subject: rt_pipe_read(): timeout does not expire
Message-ID: <25ffc50c-94ab-d09a-fd2c-e2d04f18a185@tin.it>
Date: Sat, 25 Sep 2021 18:20:23 +0200
MIME-Version: 1.0
Content-Language: it-IT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I'm using Xenomai 3.1.1 in cobalt mode, on x84_64.

Please consider the attached simple test code.

When I start the application, I never see the "Pipe task running" printf.

When I close application (ctrl+c), rt_pipe_join() on pipe task hangs.

Analyzing the code with gdb, the timeout in tv structure inside =

rt_pipe_read_timed() is the following

(gdb) thread 13
[Switching to thread 13 (Thread 0x7ffff7189700 (LWP 528))]
#0  0x00007ffff7f89471 in do_recvmsg (fd=3Dfd@entry=3D3, =

msg=3Dmsg@entry=3D0x7ffff7188c40, flags=3Dflags@entry=3D0) at rtdm.c:250
250	rtdm.c: No such file or directory.
(gdb) bt
#0  0x00007ffff7f89471 in do_recvmsg (fd=3Dfd@entry=3D3, =

msg=3Dmsg@entry=3D0x7ffff7188c40, flags=3Dflags@entry=3D0) at rtdm.c:250
#1  0x00007ffff7f89e11 in __cobalt_recvfrom (fd=3D3, =

buf=3Dbuf@entry=3D0x7ffff7188d60, len=3Dlen@entry=3D4, flags=3D0, =

from=3Dfrom@entry=3D0x0,
     fromlen=3Dfromlen@entry=3D0x0) at rtdm.c:343
#2  0x00007ffff7fc38ab in rt_pipe_read_timed (pipe=3D<optimized out>, =

buf=3D0x7ffff7188d60, size=3D4, abs_timeout=3D<optimized out>)
     at pipe.c:423
#3  0x00005555555555c0 in rt_pipe_read (pipe=3D0x555555558150 <MyPipe>, =

buf=3D0x7ffff7188d60, size=3D4, timeout=3D500000)
     at =

/opt/smitec/3.1.5_SDK/sysroots/corei7-64-poky-linux/usr/include/xenomai/alc=
hemy/pipe.h:72
#4  0x00005555555556d4 in MyPipeFun (arg=3D0x0) at test_resume_pipe.c:55
#5  0x00007ffff7fc196a in task_entry (arg=3D0x7ffff732ddc8) at task.c:237
#6  task_entry (arg=3D0x7ffff732ddc8) at task.c:219
#7  0x00007ffff7faaca9 in thread_trampoline =

(arg=3Darg@entry=3D0x7fffffffe9c0) at internal.c:251
#8  0x00007ffff7f8b93e in cobalt_thread_trampoline (p=3D0x7fffffffe820) at =

thread.c:123
#9  0x00007ffff7f58ea4 in start_thread (arg=3D<optimized out>) at =

pthread_create.c:477
#10 0x00007ffff7e7edcf in clone () at =

../sysdeps/unix/sysv/linux/x86_64/clone.S:95
(gdb) frame 2
#2  0x00007ffff7fc38ab in rt_pipe_read_timed (pipe=3D<optimized out>, =

buf=3D0x7ffff7188d60, size=3D4, abs_timeout=3D<optimized out>)
     at pipe.c:423
423	pipe.c: No such file or directory.
(gdb) print tv
$1 =3D {tv_sec =3D 1438, tv_usec =3D 783700}

It seems a value related to uptime (system was up by about 24 minutes, =

1440 seconds, when debugging).

The API documentation says that rt_pipe_read() accepts "a delay =

expressed in clock ticks". In Xenomai code, rt_pipe_read() becomes =

rt_pipe_read_timed(), that accepts "An absolute date expressed in clock =

ticks", with a note saying "abs_timeout is interpreted as a multiple of =

the Alchemy clock resolution" (I dont' understand this latter sentence).

If I'm not wrong, the "absolute date" would be a date expressed in =

seconds after the epoch. Could the alchemy_rel_timeout() call in =

include/alchemy/pipe.h calculate a wrong timeout?
Otherwise, what could be the problem?

Thanks in advance, regards

-- =

Mauro S.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test_resume_pipe.tar.xz
Type: application/x-xz
Size: 1608 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20210925/3605e686/at=
tachment.bin>
