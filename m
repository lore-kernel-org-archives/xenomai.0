References: <20210731094934.1799307-1-rpm@xenomai.org>
 <ccfa6190-ac98-7e6d-b7fa-6936c211e75e@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 0/4] Dovetail fixes (v5.13)
In-reply-to: <ccfa6190-ac98-7e6d-b7fa-6936c211e75e@siemens.com>
Date: Tue, 03 Aug 2021 08:53:37 +0200
Message-ID: <87eebb589a.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org


Hi Florian,

Florian Bezdeka via Xenomai <xenomai@xenomai.org> writes:

> Hi Philippe,
>
> On 31.07.21 11:49, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> The usual pain with synchronizing the virtual and real interrupt
>> states. These issues have been detected while porting to v5.14, some
>> are reported by CONFIG_DEBUG_LOCKDEP=y.
>> 
>
> One of our test boards (Intel XEON D) has an issue with the TSC being
> marked unstable because the clocksource watchdog is coming too late.
> Could one of these fixes explain that? Something like missed / dropped
> interrupts / interrupts not being delivered to Linux?
>

I don't think so, these fixes are not supposed to address this kind of
issue. They are merely aimed at keeping the interrupt state reported by
the IRQ flags tracer in sync with lockdep expectations. This series is
not complete yet, more is to come to fully address this matter and more.

Booting with CONFIG_DEBUG_LOCKDEP enabled, CONFIG_EVL/CONFIG_XENOMAI
disabled (i.e. only keeping the IRQ pipeline on) should reveal the
remaining problems. This also revealed a deeper and nastier issue than
de-synced IRQ flag tracing, particularly on ARM/arm64 where we do depend
on RCU read sides when traversing the interrupt pipeline, an unmet
dependency which is currently papered over as a result of having a
high-priority interrupt stage enabled in the kernel
(e.g. EVL/Xenomai). A fix is under test here.

-- 
Philippe.

