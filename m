Message-ID: <cbe23c50701241055l5efa3f50p768f7d37d2d7cb8@domain.hid>
Date: Wed, 24 Jan 2007 19:55:31 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] isolating unwanted mode switch
In-Reply-To: <200701241152.21747.jweber@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701231448.35285.jweber@domain.hid>
	<200701231627.51851.jweber@domain.hid>
	<b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
	<200701241152.21747.jweber@domain.hid>
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

2007/1/24, Jeff Weber <jweber@domain.hid>:
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

Are your variables all properly initialized, before mlockall ?

>
> How would my application encounter a page fault after calling
> mlockall(CURRENT | FUTURE) ?
>
> Perhaps an answer is that mlockall() prevents pages from ever being paged out,
> but the application may still encounter page faults upon referring to pages
> that were never paged in when mlockall() was called.  If true, then my
> application may continue to encounter page faults, and hence switches to
> seondary mode until all pages in the application are loaded.

I am no Memory Handling expert nor Xenomai expert
but I think you may get a page fault when you require more memory
you used before you call mlockall(CURRENT | FUTURE),
that is growing stack, mmap calls,  malloc etc...

Does you application has some unbounded or not pre-computed memory
requirement (recursive call, malloc/calloc/alloca call etc.., mmap call)?

I may imagine the case where your system is short of memory
then you app requires more memory then you get page fault.

As a simple check, did you verify your mlockall syscall succeed?
I remember an application of mine which did not verify the returned
code and discover later that the call did not succeed :(((


-- 
Erk

