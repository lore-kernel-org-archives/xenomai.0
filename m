Message-ID: <4A92B2F9.6080601@domain.hid>
Date: Mon, 24 Aug 2009 17:34:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200908241838362961884@domain.hid>
In-Reply-To: <200908241838362961884@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel doesn't boot ,
 after add the xenomai-2.4.8 patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wangxiyu8237 <wangxiyu8237@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

wangxiyu8237 wrote:
> hello  :
>    
> I'm porting xenomai to SAMSUMG s3c2410 processor (on SMDK2410) as per
> porting guidelines. In the first phase, applied
> adeos-ipipe-2.6.26-arm-1.12-00 patch found in xenomai-2.4.8 to kernel
> 2.6.26.8 and have implemented required machine specific code.  add a
> driver of CS8900, 

It looks like you have reinvented the wheel:
- the linux kernel already has a driver for the cs89x0 ethernet interface;
- Xenomai already has support for the s3c chips.

> kernel booted but with a problem , kernel doesn't boot VFS and ipconfig. 

Well, your I-pipe support is probably buggy. Did you check whether the
hardware timer is still ticking when the kernel stops? I am afraid if
you want to write your own I-pipe support you will have to debug it...

-- 
                                          Gilles


