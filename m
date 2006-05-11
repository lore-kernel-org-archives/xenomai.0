From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Errors running sim testsuite for vxWorks
Date: Thu, 11 May 2006 19:56:57 +0200
References: <200605111823.51650.niklaus.giger@domain.hid>
	<17507.27519.455277.534105@domain.hid>
In-Reply-To: <17507.27519.455277.534105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111956.57892.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Donnerstag, 11. Mai 2006 18:51 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Hi
>  >
>  > Running the sim testsuite vxworks (revision 1078) (using the attached
>  > script) I get the following a few failures and memory corruption:
>  >
>  > trestart.c:46, taskSpawn("nop", 19, 0, 32768, nopTask,
>  > 0,0,0,0,0,0,0,0,0,0) != ERROR
>  > *** glibc detected *** malloc(): memory corruption: 0x100bf000 ***
Okay. Calling gdb .libs/trestart gave me the following output:
(gdb) run
Starting 
program: /mnt/data.ng/buildslave/buildbot/quick-sim/build/sim/skins/vxworks/testsuite/.libs/trestart
Xenomai/sim: real-time nucleus v2.2-dev (Engines Of Creation) loaded.
starting VxWorks services.
trestart.c:85, taskSpawn("create", 20, 0, 32768, createTask, 
0,0,0,0,0,0,0,0,0,0) != ERROR
trestart.c:85 TEST passed.
trestart.c:87, semTake(restart_test_end, WAIT_FOREVER) == OK
trestart.c:46, taskSpawn("nop", 19, 0, 32768, nopTask, 0,0,0,0,0,0,0,0,0,0) != 
ERROR
trestart.c:46 TEST passed.
trestart.c:50, taskRestart(0) != ERROR
trestart.c:46, taskSpawn("nop", 19, 0, 32768, nopTask, 0,0,0,0,0,0,0,0,0,0) != 
ERROR
*** glibc detected *** malloc(): memory corruption: 0x100be000 ***

Program received signal SIGABRT, Aborted.
0x0fba77bc in raise () from /lib/tls/libc.so.6
(gdb) info stack
#0  0x0fba77bc in raise () from /lib/tls/libc.so.6
#1  0x0fba92c0 in abort () from /lib/tls/libc.so.6
#2  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#3  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#4  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#5  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#6  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#7  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#8  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#9  0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#10 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#11 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#12 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#13 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#14 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#15 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#16 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
#17 0x0fbe1f60 in __fsetlocking () from /lib/tls/libc.so.6
Previous frame inner to this frame (corrupt stack?)
(gdb)                                                                             

Do you have any ideas? Thanks in advance.

-- 
Niklaus Giger

