Subject: Re: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4572E7D1.5020103@domain.hid>
References: <4572DB9F.7040505@domain.hid> <1165157023.4952.361.camel@domain.hid>
	<4572E7D1.5020103@domain.hid>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 16:47:35 +0100
Message-Id: <1165160855.4952.415.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2006-12-03 at 16:05 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Sun, 2006-12-03 at 15:13 +0100, Jan Kiszka wrote:
> >> Hi,
> >>
> >> I came across a few things in latest 2.6.19-i386-1.6-01 patch:
> >>
> >> The usage of __ipipe_pipelock in __ipipe_common_info_proc is broken (raw lock used as
> >> Linux lock here), and I do not see any volatile data it could protect anyway. So let's
> >> remove it.
> > 
> > The interrupt status word, and whether any virtual interrupt is
> > allocated or not, are the volatile data protected by this lock on a SMP
> > system. Since this is a common spinlock with no interrupt control
> > required which is only used over the Linux domain (/proc handler), you
> > don't need to go for the _hw() form of it.
> 
> As far as I see, nothing prevents the other users of __ipipe_pipelock to
> be executed over non-root domain (IRQ registration in Xenomai context is
> allowed, no?).
> 

Indeed, this is also the sense of my second reply:
https://mail.gna.org/public/adeos-main/2006-12/msg00004.html

Which means that our problem is more an issue regarding preemption by
interrupts.

> But I have to re-check what data for __ipipe_common_info_proc actually
> can be released (I'm not considering inconsistency a problem here). I
> didn't see anything on first review.
> 
> Still, this kind of merging of _hw with non-_hw spinlock operations is
> fishy in my eyes.
> 

It's not without interrupt control, provided you accept the possible
side-effects regarding kernel preemption, which /proc handlers do. What
would have been really problematic is a mismatch between
spin_lock_irqsave_hw and spinlock_irqsave forms, and what is really a
bug is the current lack of protection wrt interrupt.

> Jan
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



