Message-ID: <4C4E8A64.1000701@domain.hid>
Date: Tue, 27 Jul 2010 09:27:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1279046702.31665.65.camel@domain.hid>
	<4C3CB655.1020801@domain.hid>	<1279048661.31665.81.camel@domain.hid>
	<1280149567.1856.15.camel@domain.hid>	<4C4D9131.7080504@domain.hid>
	<1280153187.1856.25.camel@domain.hid>	<4C4D97AC.2030609@domain.hid>
	<1280154697.1856.29.camel@domain.hid>	<4C4D9E04.6060407@domain.hid>
	<1280156219.1856.32.camel@domain.hid>	<4C4DA340.4030400@domain.hid>
	<1280187666.1963.34.camel@domain.hid>
In-Reply-To: <1280187666.1963.34.camel@domain.hid>
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
> I finally could get the linux-imx from the Freescale's git site.
> 
> As you mentioned in the readme, when the patch is applied to the kernel,
> I found errors during the patch.

There should not be errors, there should be only one reject.

 But, it was found errors on the patch,
> the remaining operations of the scripts/prepare-kernel.sh script are
> stopped.
> 
> Should I continue anyway? Does this patch execution problem does not
> cause any other problem during the kernel build?

You have to apply the patch by hand, then run the prepare-kernel.sh script.

-- 
					    Gilles.

