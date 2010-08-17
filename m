From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6A8332.5050308@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6A8194.80008@domain.hid> <1282048491.5255.92.camel@domain.hid>
	<4C6A8332.5050308@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 17 Aug 2010 14:54:23 +0200
Message-Id: <1282049663.5255.99.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 2010-08-17 at 14:40 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > On Tue, 2010-08-17 at 14:33 +0200, Gilles Chanteperdrix wrote:
> >> Krzysztof Błaszkowski wrote:
> >>> Hello,
> >>>
> >>> I found recently that large application uses to segfault before fork()
> >>> leaves its glibc wrapper.
> >>>
> >>> I included here a test suite which can be easily used to verify what
> >>> goes wrong. It may be necessary to adjust makefile to compile the code.
> >>> So, the console is missing output from line #89. We can see instead a
> >>> message that getpid couldn't be linked which is 1st sign of memory
> >>> corruption.
> >>>
> >>> i used to think that this issue could be related to not unbinding heap
> >>> before fork() but it turned out that it is enough to link userspace with
> >>> xenomai libraries.
> >>>
> >>> I wonder if this is known issue and if there is any fix, does 2.5.4 work
> >>> same ? or maybe there is something wrong with the kernel i use (or adeos
> >>> patch)
> >>>
> >>> Another question is why rt_task_create() is marked deprecated in native
> >>> skin. Does it mean that native skin is going to be removed from source
> >>> tree ?
> >> The libc on the system you run the test is not the same as the one of
> >> the compiler. Please re-run the test when using the same libc on the
> >> test board as on the machine where you are compiling.
> > 
> > 
> > I reckon you missed the clue. On the other hand: how can you explain
> > that main process even started ? and only child failed ?
> > 
> > and indeed i compile code on one box but run on another anyway both
> > rootfs'es are "bit equal".
> 
> No. As witnessed by the message:
> ./xeno-shmem-fork: relocation error: ./xeno-shmem-fork: symbol getpid,
> version GLIBC_2.0 not defined in file libc.so.6 with link time reference


have you seen that main process started  ? and linker didn't complain
about wrong symbol version. This happened only in child process after
line 88, have you seen output from line 89 ?

furthermore you can find commented out line in makefile which compiles
userland without linking with xenomai libraries. 

this executable works as expected.

> 
> The run-time glibc is not the same as the compile-time glibc. The glibc
> are mostly ABI compatible, but maybe not the fork wrapper, so, to rule
> this out, please re-run the test with the correct glibc.
> 

this is from libc on box i compile code:
GNU C Library stable release version 2.9 (20081117), by Roland McGrath
et al.
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Configured for i686-suse-linux.
Compiled by GNU CC version 4.3.2 [gcc-4_3-branch revision 141291].
Compiled on a Linux 2.6.27 system on 2008-12-03.
Available extensions:
	crypt add-on version 2.1 by Michael Glad and others
	GNU Libidn by Simon Josefsson
	NoVersion patch for broken glibc 2.0 binaries
	Native POSIX Threads Library by Ulrich Drepper et al
	BIND-8.2.3-T5B
For bug reporting instructions, please see:
<http://www.gnu.org/software/libc/bugs.html>.
CHroot linux-e9um:/lib # 



and this is from target box:
atest:/lib # ./libc-2.9.so
GNU C Library stable release version 2.9 (20081117), by Roland McGrath
et al.
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Configured for i686-suse-linux.
Compiled by GNU CC version 4.3.2 [gcc-4_3-branch revision 141291].
Compiled on a Linux 2.6.27 system on 2008-12-03.
Available extensions:
	crypt add-on version 2.1 by Michael Glad and others
	GNU Libidn by Simon Josefsson
	NoVersion patch for broken glibc 2.0 binaries
	Native POSIX Threads Library by Ulrich Drepper et al
	BIND-8.2.3-T5B
For bug reporting instructions, please see:
<http://www.gnu.org/software/libc/bugs.html>.
atest:/lib #  



these libcs are same and i wonder whats wrong with you. 
How many times do i need to make you sure that these libcs are binary
same ?







-- 
Krzysztof Blaszkowski


