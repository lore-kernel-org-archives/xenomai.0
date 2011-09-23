MIME-Version: 1.0
In-Reply-To: <1316782850.2050.8.camel@domain.hid>
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>
	<1316782850.2050.8.camel@domain.hid>
Date: Fri, 23 Sep 2011 22:21:45 +0200
Message-ID: <CAMJ=MEfe-EKe9V7N3c=udfq=YGz23HhFec9UqvfZ6LtT2R3bjw@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai-forge: SEGFAULT is pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Sep 23, 2011 at 3:00 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Thu, 2011-09-22 at 22:15 +0200, Ronny Meeus wrote:
>> Hello
>>
>> I have created some time ago a test application for the PSOS interface
>> of Xenomai.
>> This is a extensive test that stresses most of the PSOS services we
>> use in our application. You can find it as an attachment.
>> It is running fine on Xenomai 2-5-6.
>> Note that in the test application there is also a benchmarking part.
>> This is currently disabled, I will fix that later.
>>
>> Now I'm investigating a switch to xenomai-forge so I tried to run the
>> same test on this platform.
>
> This is a double cleanup call, due to the incorrect propagation of an
> internal error detected in the task trampoline within the psos emulator.
> In fact, this reveals a more general shortcoming with handling this
> situation for tasks, and this may also reveal an issue with t_delete()
> over the Mercury core.
>
> I can't reproduce the issue here with your test program, but I'm sure
> something is wrong in the emulator anyway, I'm just lucky with the
> timings. Since you are running over the vanilla kernel and maybe x86,
> you could run valgrind to check whether some memory corruption is
> detected.
>
> I'm working on this bug which will bite any emulator based on the
> copperplate interface the same way. I don't see any show stopper to fix
> it, but this needs some thoughts to do this properly.
>
> Btw,
>
> - what is your architecture?
> - what is your glibc version?

Running on a PC (virtual BOX).

This is the information about the lib I use:
meeusr@domain.hid$ ./libc.so.6
GNU C Library (Ubuntu EGLIBC 2.11.1-0ubuntu7.6) stable release version
2.11.1, by Roland McGrath et al.
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.4.3.
Compiled on a Linux >>2.6.24-27-server<< system on 2010-11-17.
Available extensions:
	crypt add-on version 2.1 by Michael Glad and others
	GNU Libidn by Simon Josefsson
	Native POSIX Threads Library by Ulrich Drepper et al
	BIND-8.2.3-T5B
For bug reporting instructions, please see:
<http://www.debian.org/Bugs/>.


The valgrind stuff I will do later.

>>
>> This is the version I'm using (downloaded today):
>>
>> meeusr@domain.hid$ git log | head
>> commit 04b776ed9ff18e197ae43ee552b8e77f42c5e5cb
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date: =A0 Wed Sep 21 21:08:42 2011 +0200
>>
>> =A0 =A0 psos: fix t_ident() with NULL name
>>
>>
>> The configuration I did:
>> ./configure --prefix=3D/home/meeusr/repo/xenomai-forge-install
>> --enable-debug --with-core=3Dmercury
>>
>> After adding the test to the makefile of the lib/psos/testsuite and
>> compiling it, I start it by giving the command:
>> sudo LD_LIBRARY_PATH=3D/home/meeusr/repo/xenomai-forge-install/lib/ gdb =
./rtprint
>>
>> After some time I observe a crash:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0xa7b5d870 (LWP 14707)]
>> 0x00140749 in dtpvh (holder=3D0x80cfc7c) at
>> ../../include/copperplate/private-list.h:59
>> 59 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0holder->prev->next =3D holder-=
>next;
>> (gdb) bt
>> #0 =A00x00140749 in dtpvh (holder=3D0x80cfc7c) at
>> ../../include/copperplate/private-list.h:59
>> #1 =A00x0014079c in pvlist_remove_init (holder=3D0x80cfc7c) at
>> ../../include/copperplate/private-list.h:120
>> #2 =A00x00140e89 in notifier_destroy (nf=3D0x80cfc48) at notifier.c:195
>> #3 =A00x0013fb68 in threadobj_finalize (p=3D0x80cfbb0) at threadobj-merc=
ury.c:161
>> #4 =A00x0014a3ef in __nptl_deallocate_tsd () at pthread_create.c:155
>> #5 =A00x0014a97c in start_thread (arg=3D0xa7b5d870) at pthread_create.c:=
307
>> #6 =A00x00234a4e in clone () at ../sysdeps/unix/sysv/linux/i386/clone.S:=
130
>> (gdb) print *holder
>> $1 =3D {next =3D 0x2, prev =3D 0x200}
>>
>> It looks like the holder structure is getting corrupted and this
>> results in a crash while destroying a task. Please note that this is
>> not the case all the time, e.g. there are already tasks destroyed
>> before.
>> Does anybody has a clue about the problem or how I have to proceed
>> with the investigation?
>>
>> Thanks.
>> Ronny
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>

Ronny

