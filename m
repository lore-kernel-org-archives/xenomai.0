Message-ID: <50CE60FA.90502@gmail.com>
Date: Mon, 17 Dec 2012 01:02:02 +0100
From: hauptmech <hauptmech@gmail.com>
MIME-Version: 1.0
References: <50CB2610.6010905@gmail.com> <50CBA44C.5090402@xenomai.org>
	<50CC634B.3020307@xenomai.org> <50CDCF87.2010207@gmail.com>
	<50CDD690.8050802@xenomai.org>
In-Reply-To: <50CDD690.8050802@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How does the adeos and xenomai project stay
 synchronized with the linux kernel project?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 12/16/2012 03:11 PM, Gilles Chanteperdrix wrote:
> On 12/16/2012 02:41 PM, hauptmech wrote:
>
>> I'm coming to the documentation with relatively fresh eyes. If you give
>> me a user on the wiki I'm happy to do a little gardening. Things like
>> the [getting started] page which is useful but not linked to anymore.
>> Perhaps a buffer page between the wiki and the git page with a little
>> description of the repos and how they fit into the development workflow
>> (where a link to denx could go).
>
> The "getting started" page is unfinished (contains empty paragraphs),
> and outdated (contains dead links and references to things like the
> simulator which is currently not really usable) at the same time. I do
> not believe we have the resources to maintain such a page up-to-date.
Do you mind if your list of documentation wants goes into the wiki (at 
the taskmarket I guess)?

>
>  From my point of view, what we need is:
> - up to date manual pages of the binaries in xenomai distribution, in
> the xenomai sources, we can start from the current manual pages, but
> some of them are outdated and we should convert them to asciidoc so that
> more people can work on them, and we can put the html versions on the
> web site (with automatic update, as currently happens for the API
> documentation and README.INSTALL/TROUBLESHOOTING)
Do the asciidoc man page sources go in doc/asciidoc or doc/man?

I'm a bit shaky with automake/Makefile scripts, if someone can shim 
Makefile.am with the code to call 'a2x -f manpage $SOURCEFILE' in the 
right location then I don't mind converting them. An example...

CLOCKTEST(1)
============
:doctype: manpage

NAME
----
clocktest - Xenomai Clock Test

SYNOPSIS
--------
*clocktest* ['OPTIONS']

DESCRIPTION
-----------
*clocktest* is part of the Xenomai test suite and tests the Clock. For each
CPU, it repeatedly prints a time offset (compared to the reference
gettimeofday()), a drift value, the number of warps and the maximum warp in
microseconds.

For this program to work, you need to run a suitable Xenomai enabled kernel
with the respective module (xeno_posix).

OPTIONS
-------
*-C <clock_id>*::
     clock to be tested, default=0 (CLOCK_REALTIME=0, CLOCK_MONOTONIC=1, 
CLOCK_HOST_REALTIME=42)

*-T <test_duration_seconds>*::
     default=0 (Never stop, ^C to end)

*-D*::
     print extra diagnostics for CLOCK_HOST_REALTIME

AUTHOR
------

*clocktest* was written by Jan Kiszka <jan.kiszka@web.de>. This man page
was written by Roland Stigge <stigge@antcom.de>.

> - some thematic pages on the wiki such as:
> . calibrating your system with xeno-test
> . influence of the various Linux kernel options on latencies on at least
> the arm and x86 platforms
> - and hyperlinks, for instance at the end of README.INSTALL point to the
> "calibrating your system" page, and in this page, have an hyperlink to
> the xeno-test and latency test manual pages, in the page "porting the
> I-pipe-core patch to a new ARM board", mention the tools that can be
> used to debug the various issues, and have an hyperlink to their manual
> page.
> - a user guide, the "porting posix applications to xenomai" page, was my
> attempt of a user-guide, but it has a very specialized goal, whereas
> part of the information it contains is general to anyone writing posix
> applications for xenomai, and evern applications in general.
> - something we have talked about but has long gone forgotten, have some
> kind of database of the latency results sortable by a mix of measurement
> type, load type, kernel versions, configuration options, processors or SOCs.
>


