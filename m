Message-ID: <4BE0B79D.6070105@domain.hid>
Date: Wed, 05 May 2010 02:11:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>	
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid>	
	<4B759DF9.9040800@domain.hid>
	<4B759F35.3050704@domain.hid>	
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>	
	<4B770554.3080809@domain.hid>	
	<8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>	
	<8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>	
	<4B799016.2040305@domain.hid>	
	<8b216e9e1002151034n362f83afwfd6b9355ec071540@domain.hid>
	<8b216e9e1003020729t58db73fdv88d9927695baae75@domain.hid>
	<4B8D2F9D.3050500@domain.hid>
In-Reply-To: <4B8D2F9D.3050500@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Gilles Chanteperdrix wrote:
> No, will try and get a Xenomai-patched 2.6.30 running on IGEP real soon
> now... However, ARM I-pipe patches for something more recent than 2.6.30
> should come soon, so, will not try really hard.
> 

Hi Felipe,

I finally had time to run Xenomai on IGEP. It almost worked out of the
box (just had spurious irqs caused by the twl4030-irq driver using the
I2C drive, a workaround being to disable the I2C irq line when writing
to the I2C controller registers). If will be in the
adeos-ipipe-2.6.33-arm-1.16-01 patch, for which you may have seen the
pull request if you are subscribed to the adeos mailing list. And this
patch will be part of the upcoming Xenomai 2.5.3 release, available real
soon too (I mean today or tomorrow, no kidding).

I am of course interested in your feedback.

Thanks in advance.
Regards.

-- 
					    Gilles.

