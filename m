References: <CAMQ-e4_L=X+8Nn5R+LnsEgtz4ZRgz8KaN48qhV-4vFCwpkFt5A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5719E9A4.5050701@xenomai.org>
Date: Fri, 22 Apr 2016 11:06:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAMQ-e4_L=X+8Nn5R+LnsEgtz4ZRgz8KaN48qhV-4vFCwpkFt5A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Assertion failed on "test posix_clock" on some
 executions of xeno-test.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrea <andrea.schiappacasse@camelotbio.com>, Xenomai@xenomai.org

On 04/22/2016 10:51 AM, Andrea wrote:
> Hello,
>
> I'm currently using Xenomai 3.0.2, under kernel 4.1.8  with i-pipe patch.
> I just noticed that I'm experiencing an error on some run of xeno-test.
>
> The reported error is:
> *posix-clock.c:420, assertion failed: diff < 1000000000*
> */usr/xenomai/bin/smokey: test posix_clock failed: Invalid argument*
>
> The specific function where the assert is issued in posix-clock.c is
> "clock_decrease_after_periodic_timer_first_tick(void)"
>
> On multiple executions it is not reproducible, I am wondering if anybody
> could hint me to the source of the problem on my system.
>

This test is highly time-dependent. Try running the autotuner 
(/usr/xenomai/bin/autotune) for calibrating the core timer with respect 
to system latencies prior to running the tests (aka "timer gravity" 
settings).


-- 
Philippe.

