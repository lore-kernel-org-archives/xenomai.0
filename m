Message-ID: <4C4EEBE3.9020806@domain.hid>
Date: Tue, 27 Jul 2010 16:23:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1279046702.31665.65.camel@domain.hid>
	<4C3CB655.1020801@domain.hid>	<1279048661.31665.81.camel@domain.hid>
	<1280149567.1856.15.camel@domain.hid>	<4C4D9131.7080504@domain.hid>
	<1280153187.1856.25.camel@domain.hid>	<4C4D97AC.2030609@domain.hid>
	<1280154697.1856.29.camel@domain.hid>	<4C4D9E04.6060407@domain.hid>
	<1280156219.1856.32.camel@domain.hid>	<4C4DA340.4030400@domain.hid>
	<1280187666.1963.34.camel@domain.hid>	<4C4E8A64.1000701@domain.hid>
	<1280239972.1865.7.camel@domain.hid>
In-Reply-To: <1280239972.1865.7.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: flavio.alves@domain.hid
Cc: xenomai@xenomai.org

Flavio Alves wrote:
> Hello,
> 
> I am still having problems with the patch:
> 
> I performed the following procedures
> 
> 1) git clone
> http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
> 2) cd linux-2.6-imx
> 3) git checkout rel_imx_2.6.31_10.02.00
> 4) patch -p0 < ../adeos-ipipe-2.6.31-arm-1.16-01.patch

It should be patch -p1

-- 
					    Gilles.

