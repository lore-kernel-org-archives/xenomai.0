Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 15:18:21 +0200
Message-Id: <1156943901.4323.47.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Tue, 2006-08-29 at 22:34 +0200, Dmitry Adamushko wrote:
> 
> On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>         Dmitry Adamushko wrote:
>         
>         I think the additional costs of maintaining an error counter
>         are almost
>         negligible. The test is in the unlikely path, and the first
>         condition
>         already keeps us away from touching the counter.
> 
> But it's updated (unhandled = 0) any time the ISR(s) report something
> different from XN_ISR_NONE.  Hence, it's at the beginning of the
> xnintr_t structure, hopefully, at the same cache line with other
> highly-used members (i.e. isr, cookie and hits).
>  
> 
>         The benefit of not
>         kicking out IRQ lines on spurious IRQs is obvious (think of
>         EMC issues, 
>         though one should better solve them on the board...).
> 
> Yep, that's why I'm asking whether we really need it or no. If a
> scenario when "spurious" interrupts indeed happen from time to time
> and a minor number of them (consequently) is not something completely
> unacceptable, then we might keep this "unhandled" counter. Here I
> don't have enough practical experience/evidence and may only rely on
> the linux way (damn, now I understand why they advised people not to
> read windows kernel code :)
>  

People deploying Xenomai-based software in the field would hate us for
not being accomodating enough with their buggy hardware, so let's
properly handle the fact that our ISRs might properly unhandle their
IRQs.

> 
>         BTW, is there a difference between unlikely(a && b) and
>         unlikely(a) && 
>         unlikely(b) that we should care about here?
> 
> I had it also in mind and grepped use cases of "unlikely" in kernel/
> directory. There are a number of unlikely (a op. b) but none of
> unlikely(a) op. unlikely (b).
> 
> Out of curiosity, one may disassemble code for both cases. My feeling
> though, unlikely(a && b) is at least not worse (cpu and compiler-wise)
> but don't want to speculate as I'm quite uneducated bozo here :)
> 

Since likely/unlikely are hints given to the compiler for optimizing
branches, you might want to give it all the information you have at hand
immediately, to augment your chances to have it do the right thing [just
in case the optimizer has no more short-term memory than a red fish...]

Patch looks ok.

> 
> 
>         
>         Jan
>         
> 
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



