From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1178281223.29093.83.camel@domain.hid>
References: <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
	<1178281223.29093.83.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 05 May 2007 19:21:33 +0200
Message-Id: <1178385693.2406.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-05-04 at 14:20 +0200, Philippe Gerum wrote:
> On Fri, 2007-05-04 at 10:20 +0200, M. Koehrer wrote:
> > Hi Jan,
> > 
> > o.k., now I understand Philippes patch.
> > However, at one point, I am not quite sure if this is correct:
> > Within __ipipe_handle_irq()
> > the patch adds
> > #ifdef CONFIG_X86_LOCAL_APIC
> >                {
> >                        unsigned vector = irq + FIRST_EXTERNAL_VECTOR;
> >                        if (vector >= FIRST_SYSTEM_VECTOR)
> >                                irq = ipipe_apic_vector_irq(vector);
> >                }
> > #endif
> > I do not understand the if (vector >= ..) statement.
> > When I am at this point, the irq value is always the vector and never an irq.
> 
> No, the trampoline code in entry.S passes us an irq actually. But there
> is indeed a vector:irq mapping issue with IRQ numbers greater than 206,
> which still badly conflict with system IRQs (MSI causes high numbered
> IRQs to be allocated). I'm working on a patch. More later.
> 

Does this patch improve things?

http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.20-i386-1.8-00.patch

-- 
Philippe.



