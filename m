Message-ID: <4A939B6A.4050300@domain.hid>
Date: Tue, 25 Aug 2009 10:06:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <142859.29324.qm@domain.hid>
In-Reply-To: <142859.29324.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] arch/arm/kernel/ipipe.c:421: error:
 implicit	declaration of function '__ipipe_mach_irq_mux_p'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Tao <david_xtao@domain.hid>
Cc: Xenomai-help@domain.hid

David Tao wrote:
> Hi,
> 
> I run into a build error when compiling ipipe.c as follows:
> 
>   CC      arch/arm/kernel/ipipe.o
>  arch/arm/kernel/ipipe.c: In function '__ipipe_grab_irq':
> arch/arm/kernel/ipipe.c:421: error: implicit declaration of function
> '__ipipe_mach_irq_mux_p'
> make[1]: *** [arch/arm/kernel/ipipe.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> 
> Kernel: 2.6.26
> Adeos patch:  adeos-ipipe-2.6.26-arm-1.12-00.patch
> Xenomai: 2.4.7, and 2.4.8
> Tool chain: Denx 4.2 for arm
> Target CPU: iMX25

Well it looks like __ipipe_mach_irq_mux_p is not implemented for your
processor. You will find documentation on what it should do on the
I-pipe on ARM guide.

http://www.xenomai.org/index.php/I-pipe:ArmPorting

Normally, this code goes in arch/arm/mach-imx/include/mach/irqs.h, but
the code I see here is not conditional, so should be used if IMX25 is
part of the IMX family. However, I do not see IMX25 in the list of
supported processors. Where did you get support for that processor from?

-- 
                                          Gilles


