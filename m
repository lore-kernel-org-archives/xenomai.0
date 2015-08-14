MIME-Version: 1.0
In-Reply-To: <20150813191157.GG28709@hermes.click-hack.org>
References: <CAKC9m6f5Yc7MZHZQO2MRCf+y2nOM7P1psX4fLTeqgE4tsnv+RA@mail.gmail.com>
 <20150813191157.GG28709@hermes.click-hack.org>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Date: Fri, 14 Aug 2015 13:38:26 -0700
Message-ID: <CAKC9m6cKtcwx_tYvWVnqNrFMxxN5=0azmLcqPwzuN_ZBX1Kh8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] I-pipe's determinism in handling hardware interrupts
 when GIC implements "Security Extensions"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Thu, Aug 13, 2015 at 12:11 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>> On an ARM SoC platform implementing the Security Extensions -
>> 1). How does the I-pipe/Adeos deal with both the interrupt sources in
>> "Normal world" (non-secure interrupt) and "Secure world" (secure
>> interrupt)?
>
> Correct me if I am wrong, I do not know which is which, but I
> believe the Linux code only lives in one of the two worlds. The
> other world is the one of a monitor, or whatever you call it, and
> inaccessible to Linux (that is the aim of "securing the processor").
> So, by definition I-pipe being a modification of Linux and not of
> the monitor can not access the privileged operations.

Based on my limited understanding of the TrustZone, both the hardware
and software resources are partitioned into two worlds: the "Secure
world" for the security subsystem, and the "Normal world" for
everything else.

Yes, the "secure monitor" lives in the secure world. However, for
systems without dedicated secure world OS, the "secure apps" run in
the normal world using the API provided by the secure world. So, in a
sense, Linux system interacts with the secure world directly.
Furthermore, software running on Linux can trigger the secure monitor
by executing the Secure Monitor Call (SMC) instruction. I've seen the
effect of such call on an ARMv8 platform when when running the Xenomai
latency test. I can share the captured ipipe trace if you or anyone
else is interested.

>
>> 2). What would happen if a Xenomai real-time thread is taking on a
>> non-secure interrupt while a secure interrupt with higher priviledge
>> arrives which must be routed to a Linux thread?
>> 3). Since a secure interrupt can take an unbounded amount of time to
>> complete its task, such as downloading firmware, will it break
>> I-pipe's determinism in serving non-secure interrupt on behalf of
>> Xenomai real-time threads?
>
> I am not sure this case can exist. Are not these privileged
> interrupt only handled by the monitor?

For a specific processor core where the secure world executes on, I
believe all interrupts will go through the secure monitor which will
then route secure interrupts and non-secure interrupts to their
respective worlds.

> Anyway, if when this
> interrupt is masked at the interrupt controller level, non
> privileged interrupts can be handled, then there is no problem. If
> such an interrupt has to be handled before any more interrupt can be
> taken, even if masked, then you have a problem.

When TrustZone-aware GIC masks interrupts targeting the secure world,
non-privileged interrupts must wait until the secure/privileged
interrupts are cleared. Yes, looks like we do have a problem.


> If, like I believe,
> such a "privileged interrupt" is handled by the monitor behind
> Linux/I-pipe's back, then yes, it will break determinism.

Do you have any suggestion as to how I-pipe can be improved to work
with ARM's multiple exception levels in order to ensure determinism on
ARMv7 (and ARMv8)?

Here is a link to a white paper published by ARM:
http://infocenter.arm.com/help/topic/com.arm.doc.prdc013242/Critical_Interrupt_Prioritization_PRD04_PRDC_013242_1_0.pdf

Thanks!
Hongfei

