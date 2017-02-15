References: <CALD0yU4tbmu_XbmvBoSySn76g8Cq0LW3qO+u=iavp4qj8ouXCQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5fb9e066-12c3-7d0b-b36e-01cf506e6082@xenomai.org>
Date: Wed, 15 Feb 2017 15:29:03 +0100
MIME-Version: 1.0
In-Reply-To: <CALD0yU4tbmu_XbmvBoSySn76g8Cq0LW3qO+u=iavp4qj8ouXCQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Understanding Domain Switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: AG M <agm6274@gmail.com>, xenomai@xenomai.org

On 02/15/2017 12:49 AM, AG M wrote:
> Hi,
>

[snip]

> I have simple program (using POSIX skin) and I'm trying to figure out
> when my program switches from primary (Xenomai) to secondary domain
> (Linux)
> *****
>  - How do I know if my program is running in primary or secondary
> mode? I never get the SIGXCPU signal. Other signals like SIGINT work.

Your demo loop won't switch to secondary mode since clock_nanosleep() is
implemented by Xenomai as a real-time compatible service. Besides, using
an explicit constant instead of PTHREAD_WARNSW is a bad idea; such value
may change with the ABI across major Xenomai releases.

> If I run the same example using the native skin, it works (using this:
> http://svn.gna.org/svn/xenomai/trunk/examples/native/sigxcpu.c)
> 

Caution, this is very, very outdated code from an abandoned server (10+
years). You may want to refer to git.xenomai.org instead.

> - I get the return value of ret pthread_setschedparam(pth,SCHED_FIFO,
> &sparam); as 16 which is EBUSY. Any idea why? My goal is to run the
> program in the highest priority if it transfers over to the secondary
> domain.
>

pth is uninit memory in your example, so this code can't work. If you
have symbol wrapping enabled, Xenomai's version of
pthread_setschedparam() will be picked, affecting the scheduling policy
of the Xenomai co-kernel. If you need the regular Linux policy to be
changed, then call the glibc service via __real_pthread_setschedparam()
instead.

> - I'm also trying to figure out using /proc/xenomai/stat. This program
> shows up as two processes and I see CSW and MSW have non zero values
> and sometimes change. I know that it means a context switch but does
> the mean its in the Linux domain?
> 

MSW counts primary -> secondary transitions, i.e. from rt to Linux.

> - If the program can be seen in Linux (meaning it gets a PID through
> the Linux kernel), does it mean its running in secondary mode?
> 

No, this is unrelated. A Xenomai thread running in primary mode appears
as sleeping for the Linux kernel.

> I'm running Xenomai 2.6.3 and ipipe 3.
> Any help is appreciated. Thanks!
> 

Xenomai 2.6.x reached EOL a year ago. Xenomai 3 is maintained.

-- 
Philippe.

