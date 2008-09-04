Message-ID: <48BFA4C1.1040800@domain.hid>
Date: Thu, 04 Sep 2008 11:05:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <op.uguvqlusnuwxn3@domain.hid> <op.ugx5nqgunuwxn3@domain.hid>
In-Reply-To: <op.ugx5nqgunuwxn3@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] spurious interrupt with latest release
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stephane ancelot <sancelot@domain.hid>
Cc: xenomai@xenomai.org

stephane ancelot wrote:
> Hi,
> Finally since I did not understand why this happened and to inhibit any  
> driver writing related problems,I made the following architecture :
> 
> a single 5ms task triggs a PLX 9050 INTCSR software register to activate  
> INTA  (level irq)
> 
> the rtdm interupt handler checks if IT comes from the PLX, disable PLX IT,  
> resets the software register , reenable PLX it,
> and ack irq rtdm
> 
> However at random time , I have always spurious interrupt in this handler.  
> The time it occurs is random .
> 
> attached my kernel config.gz

Hi,

Did you check the differences in masking/acking/unmasking interrupts for
the interrupt controller you use between the I-pipe patch that works and
the I-pipe patch that does not work ?

Regards.

-- 
                                                 Gilles.

