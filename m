MIME-Version: 1.0
In-Reply-To: <20150430181413.GY1993@hermes.click-hack.org>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430161730.GX1993@hermes.click-hack.org>
 <CAKC9m6d-mgdPQpnHPEEUw3VPis+j37jBk1AQ0EEpMQYHLEw6XA@mail.gmail.com>
 <20150430181413.GY1993@hermes.click-hack.org>
Date: Thu, 30 Apr 2015 11:17:46 -0700
Message-ID: <CAKC9m6c_cyNO83ei+Sh0xPyh6DkMfuFZUCNk6Urk8=xvsKMpmQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 11:14 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, Apr 30, 2015 at 11:12:58AM -0700, Hongfei Cheng wrote:
>> On Thu, Apr 30, 2015 at 9:17 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Thu, Apr 30, 2015 at 08:53:10AM -0700, Hongfei Cheng wrote:
>> >> We've been working on porting the I-pipe core to an ARMv8/AArch64
>> >> platform (Qualcomm msm8994).
>> >>
>> >> Taking the advice we received from this forum, our approach has been
>> >> to add and enable the I-pipe core patches on this new architecture one
>> >> (small) step at a time.
>> >>
>> >> The development platform is currently configured and patched as follows:
>> >> 1). Only 1 CPU core is enabled (via kernel command line).
>> >> 2). Interrupt controller, GPIO controller, and platform drivers are
>> >> patched following the porting guide and the existing ipipe-core code,
>> >> along with the relevant discussions on this list.
>> >> 3). I-pipe spinlocks are applied to the instances where we think
>> >> require "ipipe protection", although we are still uncertain if this
>> >> work is complete in our code.
>> >
>> > Each spinlock you turn into an ipipe spinlock bears a risk of creating
>> > large masking sections, so, this is something you should not do a
>> > lot. The porting guide warns about that. This is something
>> > important. Do only this when it is really needed, and not before
>> > having examined every section where this spinlock is used by Linux
>> > to see if it has no chance of creating a large masking section. If
>> > it does, you will have to find other workarounds.
>> >
>> >> 4). High resolution counter is not yet supported as we're exploring
>> >> different way(s) to implement TSC.
>> >> 5). CPU_FREQ and CPU_IDLE are *not yet* disabled, mainly due to the
>> >> dependency of big.LITTLE architecture vendor-specific code.
>> >
>> > This is bad. Probably a source of troubles. Disable them.
>> >
>> >>
>> >> Below is what we've observed so far:
>> >> 1). Hardware timer appears to be running properly with
>> >> arch_timer_ack() being called regularly and reliably.
>> >> 2). I-pipe is indeed grabbing the interrupt (through examining the call stack).
>> >> 3). The kernel startup process comes to a screeching halt when probing
>> >> certain platform drivers, such as ipa or pcie. No kernel oops is
>> >> shown. In this kernel state, the *only* task being scheduled is the
>> >> watchdog process.
>> >>
>> >> I believe there are "holes", to borrow the term from Gilles, in the
>> >> platform drivers. However the few platform drivers which call
>> >> generic_handle_irq have all been replaced with
>> >> ipipe_handle_demuxed_irq.
>> >
>> > This looks wrong. Only when the irq is demuxed should you use
>> > ipipe_handle_demuxed_irq. If the parent irq is a plain Linux irq,
>> > there is no reason to replace generic_handle_irq with
>> > ipipe_handle_demuxed_irq. In the GPIO case, the demux function is
>> > run as an interrupt ack callback, so it runs "ahead of the
>> > pipeline", and is not executed in Linux domain so can not use
>> > generic_handle_irq.
>> >
>> >>
>> >> My questions are:
>> >> 1). Has anyone encountered similar experience while porting I-pipe
>> >> core?
>> >
>> > Porting the I-pipe code to a new ARM board has always been full of
>> > surprises for me, it has always required to understand some new
>> > problems, and avoid them. I have always found the I-pipe tracer to
>> > be a great help in that case. Of course, enabling the I-pipe debug
>> > options is a must, also (though it can create double faults
>> > conditions when something goes really wrong).
>> >
>> >
>> >> 2). Could such behavior be the result of missing or incorrectly
>> >> applied I-pipe spinlocks?
>> >
>> > No
>> >
>> >>
>> >> I'll put the kernel config, patched code, and startup logs in the
>> >> cloud and post the link here.
>> >
>> > I do not think it is necessary.
>> >
>> > --
>> >                                             Gilles.
>>
>> Thank you, Gilles, for your always prompt and insightful response.
>> We'll re-examine the problematic places in the code, based on your
>> input and comments.
>>
>> By the way, Gilles, have you been able to squeeze supporting
>> I-pipe/Xenomai on ARMv8/HiKey-board into your busy schedule?
>
> Not yet, but this should not be long now.
>
> --
>                                             Gilles.

That's great to know!

