Message-ID: <434E3171.7000506@domain.hid>
Date: Thu, 13 Oct 2005 12:05:37 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>	<434CFDFF.2090201@domain.hid>
	<434D06C9.3030802@domain.hid> <434D0D2D.4010606@domain.hid>
	<434D2006.1060908@domain.hid>
	<434E1CCB.4010809@domain.hid> <434E24CB.80704@domain.hid>
In-Reply-To: <434E24CB.80704@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: 2.4 vs 2.6 in embedded space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/13/2005 11:11 AM Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> On 10/12/2005 04:39 PM Philippe Gerum wrote:
>> 
>>>Wolfgang Grandegger wrote:
>>>
>>>>We have linux-2.4.14-rc3 running on all AMCC eval boards (see
>>>>http://www.denx.de). But the kernel supported by RTAI/Fusion,
>>>>linuxppc-2.6.10rc3, does not boot on Ebony. The main problem is the
>>>>missing support for U-Boot but there might be others. And it's simply
>>>>not worth the effort to port it, I think.
>>>
>>>Open question: to your opinion, is 2.6 on low-end embedded hw doomed "by design" 
>>>and why, or do you think that part of the reluctance to move to 2.6 is mostly 
>>>explained because 2.4 is just fine and up to the task, IOW it's kind of a "don't 
>>>fix if it ain't broken" perception?
>> 
>> 
>> As Wolfgang (Denk) already pointed out, 2.6 is less attractive on low
>> end systems, because it's bigger, slower, ... This is also true for
>> Xenomai (RTAI/fusion). It's difficult to beat the latency value of the
>> old RTAI/RTHAL under 2.4. You need more CPU power and resources, that's
>> how thing are going. Nevertheless, compared to the realtime preemption
>> patch, Xenomai is _lightweight_ :-).
> 
> I think so too; that's the problem with strictly native real-time support in the 
> kernel: you must end up with some kind of SMPish structure which virtually 
> exhibits an infinite number of processors (one per task basically), so it's not 
> going to help reducing the cpu footprints and the various noisy artefacts 
> implied by the generalized mutex approach (which is otherwise sound, that's no 
> the issue). This is also why there is still space for real-time extensions, 
> provided - I think - they run as symbiotically as possible with Linux, so that 
> we don't end up telling people to ignore they have Linux while running their 
> apps over it.

I agree and I'm really interested to get the benchmark comparison tests
http://www.opersys.com/lrtbf/index.html running on a low-end PowerPC system.

> 
> As far as Xeno is concerned, we should be able to continue to reduce those 
> footprints. From my window, I see two aspects we need to work on:
> - impact of the Adeos pipelining on cache especially for hw with sluggish
> memory bandwidth
> - a better placement of the hot data that are accessed inside the fast interrupt 
> path (mainly those of the scheduler).

That would be nice, indeed. I also understood, that iPIPE is already
lighter than ADEOS.

> Looking at the ppc figures since early 2005 or so, the raw latency has 
> continuously been reduced, i.e. we went from ~120 us on a Freescale's Icecube 
> running the user-space test, to 53 us as measured recently with 0.9.1+r8c4. I 
> did not manage to check again on the Sandpoint (connection problem to the Vlab) 
> which is very representative of the low-end hw issues we could face [and 
> basically made me cry when I first looked at the latency reports], but I suspect 
> that thing might have progressed there too. I've recently ported 0.9.1 over a 
> Mvista kernel (experimental PREEMPT_RT-like stuff + other patches) on a mpc8541, 
> and the figures for user-space are ~22 us worst-cast lat.
> Of course, this is not what one would call a sluggish low-end hw and I agree 
> that a more structured design like Xeno can't beat a flat ISR-based design, but 
> still, in any case, I'm optimistic enough to think that we likely have a margin 
> of improvement there.

When the iPIPE-Patch for PowerPC is available for a recent 2.6 kernel
version, I could run benchmark tests on various PowerPC systems, e.g. on
4xx processors from AMCC, including a rather low-end 405 at 200 MHz.

>> Furthermore I think, that part of the reluctance is also due to
>> "development in progress" including features like the realtime
>> preemption patch, especially on embedded PowerPC systems. People are
>> waiting that things get available and stable.
>> 
> 
> Well, we might all have the same problem here...

Wolfgang.



