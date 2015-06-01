MIME-Version: 1.0
In-Reply-To: <20150601174937.GB30861@hermes.click-hack.org>
References: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
 <20150513180613.GE3759@hermes.click-hack.org>
 <CAKC9m6edtqma0t4ddUpqker1Ofx5YDyV6TUXNY3EAZnxyDu2vQ@mail.gmail.com>
 <20150518173654.GC10686@hermes.click-hack.org>
 <CAKC9m6d025dA-8hZ=tRS86+RP9jomraT9MKvBBDdiBNo9DUmwQ@mail.gmail.com>
 <20150519183909.GH10686@hermes.click-hack.org>
 <CAKC9m6e3=O2jhAQ124Mv4+7kEHpkqFFD4THpTgTa=0zWbCJNAA@mail.gmail.com>
 <20150530141255.GA25493@hermes.click-hack.org>
 <CAKC9m6c9dmfSeRgL8fZt0t2ct27+-bnshTuz9p=pFW1oSQxEyg@mail.gmail.com>
 <20150601174937.GB30861@hermes.click-hack.org>
Date: Mon, 1 Jun 2015 12:48:44 -0700
Message-ID: <CAKC9m6eVhmjgoG0cx5WC=GG8GkCnZkKZsKOk53eSqhD=4N9GxA@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai]
	=?utf-8?b?SVJRIGZsb3cgaGFuZGxlcjog4oCcaGFuZGxlX2VkZ2Vf?=
	=?utf-8?b?aXJx4oCdIHZzIOKAnGhhbmRsZV9sZXZlbF9pcnHigJ0=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Jun 1, 2015 at 10:49 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>> What surprised me is that, with a Linux spinlock in the loop, the
>> platform driver is probed successfully and the system boots just fine
>> with I-pipe and Xenomai enabled. We can even run the latency test with
>> reasonable results.
>>
>> What are the obvious signs to look for when:
>> 1). a Linux spinlock is mistakenly used in place of an ipipe
>> spinlock?
>
> a Linux spinlock, when it disables interrupts, does not disable
> them for real, so the risk is to be preempted by a real-time
> activity which tries to take the same spinlock, and so you get a
> deadlock. Of course, you will not observe anything as long as it
> does not happen. But it can happen, and this is enough to want and
> avoid it.

Makes sense to me. Thanks for the clarification.

>> 2). an ipipe spinlock is mistakenly used in place of a Linux spinlock?
>
> If the section protected by the ipipe spinlock does things which
> last for long, or ends up calling Linux functions, the risk is to
> create large masking sections for the real time activity.

Also makes sense.

>>
>> >> 2). Is there any risk if gic_arch_extn.irq_hold() and
>> >> gic_arch_extn.irq_release() are set as NULL (in the platform driver)?
>> >
>> > There should be no reason to define this archiecture hold and
>> > release. Using the mask and unmask ones should be sufficient.
>>
>> When gic_arch_extn is defined by the platform driver, without making
>> the changes in gic_hold_irq() and gic_release_irq(), we'd get the
>> following incorrect call stack, which you previously confirmed.
>> The
>
> No, I did not confirm that this call stack was wrong. There is
> nothing wrong in gic_hold_irq calling msm_mpm_disable_irq.

Looks like I misinterpreted the comment you made on May 19.
--------
>> Here is a partial call stack:
>> <peripheral-driver-irq-mask>+0xc/0x18
>> gic_hold_irq+0xb8/0x134
>> __ipipe_ack_fasteoi_irq+0x14/0x20
>> __ipipe_dispatch_irq+0x90/0x2a8
>> __ipipe_grab_irq+0x5c/0x74
>>
>> Does this call stack look correct to you?
>
> No, this call stack does not look correct. gic_hold_irq should only
> mask the irq at interrupt controller level, not call back anything
> related to peripheral driver itself.
>
> Also, if an irq does not use handle_fasteoi_irq, gic_hold_irq should
> not be invoked.
~~~~~

> Now if msm_mpm_disable_irq calls some linux functions such as
> taking a spinlock or calling scheduler related function,
> now that is wrong.

I agree.

>> platform driver also fails during system bootup.
>>
>> msm_mpm_disable_irq+0xc/0x18
>> gic_hold_irq+0xb8/0x134
>> __ipipe_ack_fasteoi_irq+0x14/0x20
>> __ipipe_dispatch_irq+0x90/0x2a8
>> __ipipe_grab_irq+0x5c/0x74
>>
>> By the way, what are the purposes of gic_hold_irq() and gic_release_irq()?
>
> See the I-pipe porting guide for ARM.
>
> Note that you could have found the answers to the questions in this
> mail by understanding how things work. So, it would perhaps be
> better for you to understand how the patch works, rather than
> jumping head on in a port.

I've been going through the porting guide for ARM SoC several times. I
also carefully studied the I-pipe core patch code. However the only
two references I've found about gic_hold_irq() and gic_release_irq()
in the "flow handler" section don't answer my questions. I'd
appreciate if you can point me to any document or code which describes
or demonstrates the usage of these two callbacks added by I-pipe.

Thanks,
Hongfei

