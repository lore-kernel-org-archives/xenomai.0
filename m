Message-ID: <4718670D.6000008@domain.hid>
Date: Fri, 19 Oct 2007 10:13:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4717D8AC.8000900@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0999445@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0999445@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] LTTng for Xenomai - next round
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

ROSSIER Daniel wrote:
>> -----Original Message-----
>> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
>> Sent: vendredi, 19. octobre 2007 00:06
>> To: xenomai-core
>> Cc: ROSSIER Daniel
>> Subject: LTTng for Xenomai - next round
>>
>> Hi,
>>
>> LTTng is becoming interesting again: Mathieu uploaded a back-port to
>> 2.6.23.1 yesterday which is already implementing the scheme that is
>> intended to be submitted upstream.
>>
>> What changed for us?
>>
>>  - We now have a recent patch basis for the kernel again.
>>
>>  - The instrumentation process was significantly simplified: No more
>>    facility registration, no more probe modules, no more XML file
>>    hacking - it's all derived from the trace points now! Some example:
>>
>>    trace_mark(kernel_timer_itimer_expired, "pid %d", sig->tsk->pid);
>>               ^----^ ^------------------^   ^----^
>>              facility     trace point    argument name
>>                name          name          and type
>>
>> I rebased the patches over I-pipe for i386 (see attached patches and
>> extended series description), and I also started to rework the Xenomai
>> patch. The diffstat of the latter is fairly telling:
>>
>>  include/nucleus/ltt.h   |  111 +---------------------------
>>  ksrc/nucleus/Config.in  |    9 --
>>  ksrc/nucleus/Kconfig    |   36 ---------
>>  ksrc/nucleus/Makefile   |    3
>>  ksrc/nucleus/intr.c     |   19 ++--
>>  ksrc/nucleus/ltt.c      |  186
> ---------------------------------------
>> ---------
>>  ksrc/nucleus/module.c   |    7 -
>>  ksrc/nucleus/pod.c      |  102 ++++++++++++++++----------
>>  ksrc/nucleus/shadow.c   |   43 +++++++----
>>  ksrc/nucleus/synch.c    |   19 +++-
>>  ksrc/nucleus/timebase.c |    6 -
>>  11 files changed, 125 insertions(+), 416 deletions(-)
>>
>> You see, no more ltt.c, i.e. no more probe module!
>>
>> At this point, we are already able to use the services of "lttv -m
>> textDump" or lttv-gui to display traces from Xenomai kernels as event
>> lists. Yes, I tried this, and it works! (Hint: Don't forget to ltt-
>> armall your trace points before trying to collect data...)
>>
>> Yet to be done:
>>
>>  - Finish the xnltt_log_event refactoring (half done, pod.c is missing
>>    yet - with ~30 trace point)
>>
>>  - Port and update the Xenomai extension over latest lttv.
>>
>> Well, I'm not looking for work, I'm looking for workers :). Anyone
>> interested and available to help with the open topics? Daniel...?
> 
> Sounds very good :-) I will see if we can contribute. Jean-Philippe is
> working on a comparison between Xenomai and RTOS-32 for 
> a x86 target system (diploma work) and is currently about to install the
> pretty old version (2.6.17) of xenoltt.

Please do comparisons based on recent versions!

> I will see with him if it makes
> sense to migrate to the latest version, at this point of his work.

The largest chunk is surely the lttv plugin. Fortunately,
synchronisation between plugin and instrumentation should be far simpler
now. Still, lttv remains a kind of big "beast"... ;)

Regarding the instrumentation: My latest Xenomai patch changed the
marker arguments even more away from your original patch. Not looking at
the plugin for this, I may have removed useful information. Please let
us know what you would like to see in the trace points so that this part
can quickly stabilise, maybe even go into the next Xenomai release.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

