Message-ID: <4EB14AEC.1080203@domain.hid>
Date: Wed, 02 Nov 2011 14:51:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EB14817.7010108@domain.hid>
In-Reply-To: <4EB14817.7010108@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] iMX25 problem with gpio and xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 11/02/2011 02:39 PM, Roberto Bielli wrote:
> Hi,
> 
> i'm doing the porting of xenomai version 2.5.6 on imx25 board and i'm 
> looking to start from imx27.
> I have some problem with gpio. It seems there are spurious interrupts.
> I would know what xenomai want to know about interrupts (i see 
> ipipe_handle_irq_cond in gpio handler, is it needed ?) and registry save 
> (spin_lock_irqsave .... in mxc_gpio_set etc...)

Please start from
http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.38.8-arm-1.18-03.patch

And tell us if you have problems with this patch.

-- 
                                                                Gilles.

