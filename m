Message-ID: <559BCDA9.3010205@web.de>
Date: Tue, 07 Jul 2015 15:01:29 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <558579E2.9070507@web.de> <559B9B77.3020409@xenomai.org>
 <559BCBDB.7080208@xenomai.org>
In-Reply-To: <559BCBDB.7080208@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Mayday issues again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-07-07 14:53, Philippe Gerum wrote:
> On 07/07/2015 11:27 AM, Philippe Gerum wrote:
>>
>> - we want the target thread to relax from a safe and sane location. What
>> about the IRQ context which signals the mayday event preempting, e.g.
>> xnthread_relax() prologue, or any kernel code supposed to run in primary
>> mode only? We would have xnthread_relax() stacking over that context,
>> this wouldn't be pretty. Redirecting the target thread by fixing up the
>> interrupt frame gives such guarantee, by making sure that it will relax
>> on a regular user->kernel syscall transition asap, which is inherently s=
afe.
>>
> =

> Actually, the code currently prevents mayday traps over non-user callers
> to skip foreign stack contexts such as Xenomai 2.x kthreads, so this bad
> scenario would not happen anyway. Besides, without such elimination the
> indirect call mechanism would not fix the unsafe preemption issue
> either. So, the remaining problem is with blackfin and its peculiar
> requirement about rescheduling, which is a barrier to a generic mayday
> handling.

Yes, that is the assumption I was building upon. And, BTW, faults do
happen over kernel contexts as well and cause relaxing then:
copy_to/from_user. So that has to work already.

But Blackfin was my concern as well, and you confirmed it. But how does
Linux address the need for rescheduling on IRQ return - which should be
similar to what we need for relaxing?

> =

>> I tested the patch on ARM. Enabling IPIPE_DEBUG_INTERNAL there reveals a
>> bug with the mayday handler now turning hw IRQs on, as a result of
>> relaxing over the low level IRQ trampoline, which makes some I-pipe call
>> in the irq_handler boilerplate code unhappy. The very same issue is
>> looming on x86, with an unprotected call to __ipipe_root_p from
>> __ipipe_handle_irq(). Disabling IRQs before leaving the mayday handler
>> is required at the very least.
>>
> =

> Looking further, ARM is affected because it does not invoke
> __ipipe_call_mayday() for triggering the mayday trap, but still uses the
> open-coded method. This routine preserves the current hw state across
> the trap, which should make x86 safe in the end.
> =


ARM is not yet properly tested, just a quick smoke test. I will
eventually look into this.

Another reason I'm trying to overcome the mayday trampoline is that it
prevents properly synchronized stopping and resuming of RT threads for
debugging purposes. I'm trying to address this requirement with a
userspace trap/irq return notifier, similar to what Linux has
(implemented on x86-only so far) but capable of hardening the context
before returning.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150707/9c1cd90f/at=
tachment.sig>
