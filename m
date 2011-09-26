From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAMJ=MEdckFQM2S0M2aL9L3BypDUuZ8ws5x24=3dTJnGckYHr9Q@mail.gmail.com>
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>
	<1317034193.2174.9.camel@domain.hid>
	<CAMJ=MEdckFQM2S0M2aL9L3BypDUuZ8ws5x24=3dTJnGckYHr9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 22:57:40 +0200
Message-ID: <1317070660.11112.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, 2011-09-26 at 22:02 +0200, Ronny Meeus wrote:
> On Mon, Sep 26, 2011 at 12:49 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Thu, 2011-09-22 at 22:15 +0200, Ronny Meeus wrote:
> >> Hello
> >>
> >> I have created some time ago a test application for the PSOS interface
> >> of Xenomai.
> >> This is a extensive test that stresses most of the PSOS services we
> >> use in our application. You can find it as an attachment.
> >> It is running fine on Xenomai 2-5-6.
> >
> > Nope, actually it does not, at all. It can't work in any 2.x series by
> > design actually, and we have the very same synchronization issue which
> > has just been fixed in -forge. We just happen to be lucky with timings,
> > likely due to the additional interactions we have with the dual kernel.
> 
> See my previous reply.
> We had a mechanism to make tasknames unique.

The task name issue is not related to the current synchronization bug in
all 2.x series for creating pSOS tasks. Regardless of their names, pSOS
tasks in 2.x are potentially at risk if  t_delete() is issued for them
while emerging in the task trampoline code.

> 
> >
> >> Note that in the test application there is also a benchmarking part.
> >> This is currently disabled, I will fix that later.
> >>
> >> Now I'm investigating a switch to xenomai-forge so I tried to run the
> >> same test on this platform.
> >>
> >> This is the version I'm using (downloaded today):
> >>
> >> meeusr@domain.hid$ git log | head
> >> commit 04b776ed9ff18e197ae43ee552b8e77f42c5e5cb
> >> Author: Philippe Gerum <rpm@xenomai.org>
> >> Date:   Wed Sep 21 21:08:42 2011 +0200
> >>
> >>     psos: fix t_ident() with NULL name
> >>
> >>
> >> The configuration I did:
> >> ./configure --prefix=/home/meeusr/repo/xenomai-forge-install
> >> --enable-debug --with-core=mercury
> >>
> >> After adding the test to the makefile of the lib/psos/testsuite and
> >> compiling it, I start it by giving the command:
> >> sudo LD_LIBRARY_PATH=/home/meeusr/repo/xenomai-forge-install/lib/ gdb ./rtprint
> >>
> >> After some time I observe a crash:
> >>
> >> Program received signal SIGSEGV, Segmentation fault.
> >> [Switching to Thread 0xa7b5d870 (LWP 14707)]
> >> 0x00140749 in dtpvh (holder=0x80cfc7c) at
> >> ../../include/copperplate/private-list.h:59
> >> 59                    holder->prev->next = holder->next;
> >> (gdb) bt
> >> #0  0x00140749 in dtpvh (holder=0x80cfc7c) at
> >> ../../include/copperplate/private-list.h:59
> >> #1  0x0014079c in pvlist_remove_init (holder=0x80cfc7c) at
> >> ../../include/copperplate/private-list.h:120
> >> #2  0x00140e89 in notifier_destroy (nf=0x80cfc48) at notifier.c:195
> >> #3  0x0013fb68 in threadobj_finalize (p=0x80cfbb0) at threadobj-mercury.c:161
> >> #4  0x0014a3ef in __nptl_deallocate_tsd () at pthread_create.c:155
> >> #5  0x0014a97c in start_thread (arg=0xa7b5d870) at pthread_create.c:307
> >> #6  0x00234a4e in clone () at ../sysdeps/unix/sysv/linux/i386/clone.S:130
> >> (gdb) print *holder
> >> $1 = {next = 0x2, prev = 0x200}
> >>
> >> It looks like the holder structure is getting corrupted and this
> >> results in a crash while destroying a task. Please note that this is
> >> not the case all the time, e.g. there are already tasks destroyed
> >> before.
> >> Does anybody has a clue about the problem or how I have to proceed
> >> with the investigation?
> >>
> >> Thanks.
> >> Ronny
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >
> > --
> > Philippe.
> >
> >
> >

-- 
Philippe.



