From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] isolating unwanted mode switch
Date: Wed, 24 Jan 2007 11:52:21 -0600
References: <200701231448.35285.jweber@domain.hid>
	<200701231627.51851.jweber@domain.hid>
	<b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
In-Reply-To: <b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701241152.21747.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dmitry:

On Wednesday 24 January 2007 04:08, Dmitry Adamushko wrote:
> On 23/01/07, Jeff Weber <jweber@domain.hid> wrote:
> > Dimitry:
> > > ...
> > > exceptions (CPU exceptions, e.g. page faults). I presume, you have
> > > done mlockall(CURRENT | FUTURE), haven't you?
> >
> > Yes.  my Linux application follows this this model:
> >
> > main () {
> >          mlockall(MCL_CURRENT | MCL_FUTURE);
> >         rt_task_shadow( ... )  // become a realtime thread
> >
> >         // for N threads:
> >                 rt_task_spawn( ... ) // fork off child RT thread
> > }
> >
> > It is one of the child RT threads that encounters the SIGXCPU unwanted
> > mode switch.  It this the correct way to call mlockall() ?
>
> Looks ok. Just to avoid getting into the same trap twice. You don't
> use system(), fork() or alike beasts in your code, do you?
No.

BTW, a primary mode thread in my application encountered the page fault 
writing to the BSS segment.

How would my application encounter a page fault after calling
mlockall(CURRENT | FUTURE) ?

Perhaps an answer is that mlockall() prevents pages from ever being paged out, 
but the application may still encounter page faults upon referring to pages 
that were never paged in when mlockall() was called.  If true, then my 
application may continue to encounter page faults, and hence switches to 
seondary mode until all pages in the application are loaded.

Could you, or any Linux+Xenomai memory paging expert comment on how/when pages 
for an application are loaded?

Is it possible to load all the text, bss and "initial" (initial data segment 
from ELF load image + thread stacks) data pages for an application before 
calling mlockall() ?

	thanks,
	Jeff

