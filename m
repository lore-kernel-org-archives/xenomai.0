From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4C4DA340.4030400@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid> <1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid> <1280153187.1856.25.camel@domain.hid>
	<4C4D97AC.2030609@domain.hid> <1280154697.1856.29.camel@domain.hid>
	<4C4D9E04.6060407@domain.hid> <1280156219.1856.32.camel@domain.hid>
	<4C4DA340.4030400@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 20:41:06 -0300
Message-ID: <1280187666.1963.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
Reply-To: flavio.alves@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I finally could get the linux-imx from the Freescale's git site.

As you mentioned in the readme, when the patch is applied to the kernel,
I found errors during the patch. But, it was found errors on the patch,
the remaining operations of the scripts/prepare-kernel.sh script are
stopped.

Should I continue anyway? Does this patch execution problem does not
cause any other problem during the kernel build?

Best regards,

Flavio

On Mon, 2010-07-26 at 17:01 +0200, Gilles Chanteperdrix wrote:
> Flavio Alves wrote:
> > No problem. I believe it should be updated in the README file.
> > 
> > And it would be nice to have the patch for imx51 inside the xenomai
> > package, isn't it? I downloaded from Denx website and is there any other
> > place where this file is saved?
> 
> Yes, it is planned for 2.5.4. I do not know how I messed up, because it
> was supposed to be in 2.5.3 too (it is even in the 2.5.3 announcement).
> 



