References: <99BAB48E90E86D42AD41F0BCE3225AEB018DE50813@GRZSMS582.andritz.com>
 <a00a6566-e5f0-9496-f139-beed6d1a1bad@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB018DE508FF@GRZSMS582.andritz.com>
 <2d21cf6a-1ed6-ab61-07d6-188a48ee98de@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB018DE509D8@GRZSMS582.andritz.com>
 <39f43017-33cb-c7e0-67e0-cd824a5bc6c4@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB019FBE4FE8@GRZSMS582.andritz.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cbf3043f-e97b-b902-b888-a6fb60bed656@xenomai.org>
Date: Wed, 20 Dec 2017 19:07:45 +0100
MIME-Version: 1.0
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB019FBE4FE8@GRZSMS582.andritz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Weird behavior during debug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 12/20/2017 06:49 PM, Lange Norbert wrote:
>  >-----Original Message-----
>  >From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
>  >Sent: Dienstag, 19. Dezember 2017 19:57
>  >To: Lange Norbert; Xenomai (xenomai@xenomai.org); Philippe Gerum
>  >Subject: Re: Weird behavior during debug
>  >
>  >EMAIL from a NON-ANDRITZ SOURCE: as a security measure, please exercise
>  >caution with email content and any links or attachments.
>  >
>  >
>  >On 2017-12-19 14:44, Lange Norbert wrote:
>  >>
>  >> Problem persists in ipipe-core-4.9.51-x86-4, ipipe-4.4 kernel crashes at boot
>  >(likely no good support for this SOC).
>  >> Used program is attached, it is being executed twice, once directly via serial
>  >or ssh, once via gdbserver or gdb (tested various combinations).
>  >>
>  >> The directly executed program will stop (supposedly at read), as soon as the
>  >debugged program is halted.
>  >
>  >OK, now I get the point: You need
>  >http://git.xenomai.org/xenomai-
>  >3.git/commit/?id=0d653e6db75f01287f83ddc3a4ba8189f0bd0366,
>  >but that is only in next so far.
> 
> I applies cleanly on the wip/rtnet branch, so I did test it and indeed it fixes the issue.
> 
>  >
>  >What happens in stable (and also in older versions) is that all Xenomai
>  >timers in the system are stopped once one Xenomai application enters a
>  >ptrace state. That is going to vanish in the next version, and we may
>  >consider taking it to stable as well. What do you think, Philippe?
> 
> I don't know the direction where you want to go with the cobalt functionality,
> this change is IMHO badly needed as digging into one process should never affect others.
> However, there still is a difference to Linux behavior, namely that a periodic timerfd will read the
> count of expired events after continuing. The cobalt implementation will just forget about them.
> 
> I suppose this hackaround is necessary so one-shot events aren`t dropped?
> 
>                 /* Hide overruns due to the most recent ptracing session. */
>                 if (xnthread_test_localinfo(waiter, XNHICCUP))
>                         return 0;
> 

This is the core of the fix: force a zero overrun count when queried for
a thread which has just left the ptraced state. This means ignoring all
missed wakeup events that may have occurred while such thread was
stopped by the debugger, and therefore unable to wait for them.

-- 
Philippe.

