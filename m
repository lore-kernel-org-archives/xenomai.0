Message-ID: <4ACDA7C6.3090004@domain.hid>
Date: Thu, 08 Oct 2009 10:50:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4ACC9BEC.8090200@domain.hid>
In-Reply-To: <4ACC9BEC.8090200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on RD129 (Samsung S3C2410A)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mau <liste@domain.hid>
Cc: Xenomai-help@domain.hid

Mau wrote:
> Dear Sirs,
> I have found this product from a company near me:
> http://www.elpa.it/rd129it.html
> It comes with linux preinstalled.
> The kernel is a vanilla kernel 2.6.30 with the addition of a few kernel
> drivers for unsupported peripherals.
> On board there is a cpu Samsung S3C2410A, flash, ram and few other things.
> I need to investigate the possibility to install xenomai on this thing.
> 
> I want to know if others have used similar boards with same or similar
> processor with success, and how complex can be to make adeos and xenomai
> work on such processor.

This question is answered on xenomai web site. This is FAQ number 2.
http://www.xenomai.org/index.php/FAQs

> 
> The other question is that since we need to apply two patches to the
> vanilla kernel (the original + adeos) is there a preferred order?

Well, if the order matters, it means that there is a conflict, and if
there is a conflict, no matter what order you choose, you will have to
solve it.

However, if I were you, I would choose to apply the I-pipe patch on the
modified kernel sources tree, because it is probably simpler.

-- 
                                          Gilles


