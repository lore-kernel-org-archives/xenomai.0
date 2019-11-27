Subject: Re: Request: offer CLOCK_HOST_MONOTONIC for systemwide tracing
References: <VI1PR05MB59174B701138FA0BF37AB250F6440@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1455128f-2b97-62c7-7e11-7278686715bb@siemens.com>
Date: Wed, 27 Nov 2019 18:06:27 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59174B701138FA0BF37AB250F6440@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>
Cc: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>

On 27.11.19 17:20, Lange Norbert via Xenomai wrote:
> Hello,
> 
> Systemwide traces would require the same clock, so Linux processes use CLOCK_MONOTONIC (they normally do by default),
> Kernel traces should do so too (ktime_get_mono_fast_ns).
> Xenomai Processes/Thread have no reliable to produce matching traces. The idea would be to
> configure the tracing frameworks to use the new CLOCK_HOST_MONOTONIC for those.

Do we know what makes the two monotonic clock deviate? Does Linux apply 
the frequency modifications of the realtime clock on the monotonic one 
as well?

> As concrete example, Lttng would use a clock plugin (only) for Xenomai.
> 
> I looked at the kernel sources if I can add this myself quickly, but seems to be involve
> some stuff like kevents which I know nothing about (killing the “quickly” part at the very least).
> 
> The request would be that
> - Similar to CLOCK_HOST_REALTIME, a CLOCK_HOST_MONOTONIC would result in timestamps that a very close to the plain Linux CLOCK_MONOTONIC.
> - This should happen without syscalls and be very efficient
> - In respect to being able to attach preloaded tracer dso’s (like tracing malloc/free), the call should work correctly before cobalt is initialized (could be worked around, but still..)
> 
> Other alternatives (most not realistic):
> 
> Calling the linux vdso functions might result in deadlocks [1].
> 
> A “safe” variant like ktime_get_mono_fast_ns is not accessible per syscall or userspace vDSO.
> 
> The normal xenomai CLOCK_MONOTONIC is not skew corrected to REALTIME
> 
> CLOCK_MONOTONIC_RAW perhaps might be easily convertible between domains, but likely
> problematic on several CPUs (unstable TSC, not in sync between CPUs)

We do not support such CPUs with Xenomai (and they get rarer these days).

> 
> As a sidenote, recent Kernels (5.3?) have a cleaned up and unified vDSO framework,
> Potentially could grab stuff from there.

If we go for hardening the kernel's gtod data updates, I guess we could 
also switch to that as source. I now wonder why that path wasn't 
considered back then, or why it wasn't possible.

Thinking longer term, synchronizing the two clock sets not just for 
tracing would likely be beneficial - PTP/TSN...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

