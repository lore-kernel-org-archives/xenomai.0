Subject: Re: [Xenomai-help] isolating unwanted mode switch
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200701241152.21747.jweber@domain.hid>
References: <200701231448.35285.jweber@domain.hid>
	<200701231627.51851.jweber@domain.hid>
	<b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
	<200701241152.21747.jweber@domain.hid>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 11:50:17 +0100
Message-Id: <1169722218.5028.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2007-01-24 at 11:52 -0600, Jeff Weber wrote:
> Dmitry:
> 
> On Wednesday 24 January 2007 04:08, Dmitry Adamushko wrote:
> > On 23/01/07, Jeff Weber <jweber@domain.hid> wrote:
> > > Dimitry:
> > > > ...
> > > > exceptions (CPU exceptions, e.g. page faults). I presume, you have
> > > > done mlockall(CURRENT | FUTURE), haven't you?
> > >
> > > Yes.  my Linux application follows this this model:
> > >
> > > main () {
> > >          mlockall(MCL_CURRENT | MCL_FUTURE);
> > >         rt_task_shadow( ... )  // become a realtime thread
> > >
> > >         // for N threads:
> > >                 rt_task_spawn( ... ) // fork off child RT thread
> > > }
> > >
> > > It is one of the child RT threads that encounters the SIGXCPU unwanted
> > > mode switch.  It this the correct way to call mlockall() ?
> >
> > Looks ok. Just to avoid getting into the same trap twice. You don't
> > use system(), fork() or alike beasts in your code, do you?
> No.
> 
> BTW, a primary mode thread in my application encountered the page fault 
> writing to the BSS segment.
> 
> How would my application encounter a page fault after calling
> mlockall(CURRENT | FUTURE) ?
> 

Because Linux initially maps .bss sections to the zero page, which is
COW. Upon first writing to some of the contained data, a page fault is
raised. mlockall() does try to make all mapped pages present, but does
not break COW. That's the current problem we are about to solve in the
next I-pipe patch series.

Spawning a RT thread involves cloning, which is also a source of future
on-demand mappings involving COW pages, and as such, would trigger
subsequent page faults. We usually don't notice them because the COWish
memory is written and committed while the application is still
initializing.

> Perhaps an answer is that mlockall() prevents pages from ever being paged out, 
> but the application may still encounter page faults upon referring to pages 
> that were never paged in when mlockall() was called.  If true, then my 
> application may continue to encounter page faults, and hence switches to 
> seondary mode until all pages in the application are loaded.
> 
> Could you, or any Linux+Xenomai memory paging expert comment on how/when pages 
> for an application are loaded?
> Is it possible to load all the text, bss and "initial" (initial data segment 
> from ELF load image + thread stacks) data pages for an application before 
> calling mlockall() ?

mlockall() will take care of the load image and stack (even if only
initially reserved by the glibc, mlockall() does commit the stack space;
that's why the default 8Mb stack size picked by the glibc is somewhat
exhuberant when your app happens to create a number of threads under
mlockall conditions). Shared libraries are also COWish things, since
there is some fixup to do during the first references.

Gilles is working on a patch that solves a number of on-demand mapping
issues initially observed on ARM and ppc, but generic enough to affect
other archs; I'll merge it into the I-pipe 1.7 series for x86 in a near
future.

> 	thanks,
> 	Jeff
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



