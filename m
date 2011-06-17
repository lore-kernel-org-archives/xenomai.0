Message-ID: <4DFB4455.7050809@domain.hid>
Date: Fri, 17 Jun 2011 14:11:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DFB1E0B.1070903@domain.hid> <4DFB3346.6000405@domain.hid>	
	<4DFB346C.6040607@domain.hid> <1308311928.2270.33.camel@domain.hid>
In-Reply-To: <1308311928.2270.33.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] nucleus: Prevent rescheduling while
 in	xntbase_tick
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-06-17 13:58, Philippe Gerum wrote:
> On Fri, 2011-06-17 at 13:03 +0200, Jan Kiszka wrote:
>> On 2011-06-17 12:58, Gilles Chanteperdrix wrote:
>>> On 06/17/2011 11:27 AM, Jan Kiszka wrote:
>>>> Based on code inspection, it looks like a timer handler triggering a
>>>> reschedule in the path xntbase_tick -> xntimer_tick_aperiodic /
>>>> xntimer_tick_periodic_inner -> handler can cause problems, e.g. a
>>>> reschedule before all expired timers were processed. The timer core is
>>>> usually run atomically from an interrupt handler, so better emulate an
>>>> IRQ context inside xntbase_tick by setting XNINIRQ.
>>>
>>> I do not understand this one either: if we are inside
>>> xntimer_tick_aperiodic, XNINIRQ is already set.
>>
>> Not if you come via xntbase_tick, called by the mentioned skins also
>> outside a timer IRQ (at least based on my understanding of that skin
>> APIs). But I might be wrong, I just came across this while checking for
>> potentially invalid cached xnpod_current_sched values.
> 
> That is ok, ui_timer(), tickAnnounce() and tm_tick() are designed by the
> respective RTOS to be called from IRQ context.

Fine. Should we add a XENO_ASSERT to set this in stone and for
documentation purposes?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

