MIME-Version: 1.0
In-Reply-To: <55CF75CA.1010505@xenomai.org>
References: <55CF75CA.1010505@xenomai.org>
Date: Sun, 16 Aug 2015 19:18:01 +0530
Message-ID: <CAC-NLwxQnTo7xg5YmUYUqepnQbvgRiUXakRwqf+6b4VMMrDF9A@mail.gmail.com>
From: ashwin damle <ashwindamle@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [RELEASE] Xenomai 3.0-rc7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

Thought of reporting. I tried using the RC7. Can compile well, however,
while running the demo programs say xddp-label and others, I get an error

*0"000.000| BUG in low_init(): [main] ABI mismatch: required r15, provided
r13*

I am running as a privileged user (sudo ./xddp-label). I am using Linux
debian, 3.16.0-4, 64 bit.

Everything works well with RC4.

Thanks.
Ashwin


On 15 August 2015 at 22:54, Philippe Gerum <rpm@xenomai.org> wrote:

>
> This release fixes a couple of serious issues affecting the Alchemy and
> VxWorks APIs (Cobalt, and Mercury with --enable-pshared), other changes
> are mostly about polishing and dealing with a few minor bugs.
>
> People setting a custom shared heap size using --mem-pool-size should
> have a look at the updated documentation:
>
> http://xenomai.org/2015/05/application-setup-and-init/#Standard_Xenomai_command_line_options
>
> http://xenomai.org/downloads/xenomai/testing/latest/
>
> Short log follows:
>
> Jan Kiszka (2):
>       kernel/cobalt: Add reason to gorelax trace point
>       cobalt/arm: Detect software breakpoints
>
> Jorge Ramirez-Ortiz (4):
>       utils/analogy: fix debug message
>       lib/analogy: validate size of calibration file
>       lib/analogy: check for errors in the calibration file
>       drivers/analogy: release pci region if mapping failed
>
> Philippe Gerum (26):
>       cobalt/posix/sem: fix spurious wakeup on aborted wait
>       lib/smokey: fix warning printout
>       boilerplate: add EPROTO to translated errors
>       testsuite/smokey: fail if out of quota
>       cobalt/sched: add start, stop SCHED_TP config operations
>       cobalt: bump ABI revision level
>       testsuite/smokey: fail if out of TP schedule
>       testsuite/latency: disable -t1/2 over Mercury
>       copperplate/regd: do timed wait for anon connection
>       lib/cobalt: export cobalt_thread_mode()
>       lib/cobalt: fix private event state accessor
>       lib/cobalt/heapobj: pshared: allow group access to heap
>       copperplate/semobj: add uninit cleanup helper
>       copperplate/eventobj: add uninit cleanup helper
>       alchemy/event: prevent double-free on error path
>       alchemy/sem: prevent double-free on error path
>       vxworks/memPartLib: fix invalid status from addToPool
>       vxworks/memPartLib: do not account for failed alloc
>       copperplate/heapobj-pshared: fix and sanitize extent management
>       boilerplate/ancillaries: add routine to parse mem size
>       copperplate/init: disambiguate --mem-pool-size argument
>       copperplate/heapobj-pshared: change rounding of page mapping array
> size
>       cobalt/sh: drop support for the SH4 architecture
>       cobalt/nios2: drop support for the NIOS2 architecture
>       doc: prebuild
>       cobalt/arm: upgrade I-pipe support
>
> --
> Philippe.
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
