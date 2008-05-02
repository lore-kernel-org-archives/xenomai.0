MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18459.1750.128875.34243@domain.hid>
Date: Fri, 2 May 2008 14:19:34 +0200
In-Reply-To: <15468836.10944871209713748048.JavaMail.www@domain.hid>
References: <15468836.10944871209713748048.JavaMail.www@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] problem patching xenomai with arm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
Cc: xenomai@xenomai.org

kerhoas.vincent wrote:
 > another detail : my target is a cirrus logic ep9302 ; I've understood that it was possible to put RTAI on it, may I suppose that I can put xenomai too ?

The support for cirrus logic is not part of the I-pipe patch for ARM. If
you look in xenomai mailing list archives, you will find a patch, but I
would advise to only keep the part of this patch specific to the cirrus
logic processor (keeping everything in include/asm-arm/arch-ep93xx and
arch/arm/mach-ep93xx) and use this with a newer patch.

I know that someone recently did the job, maybe he will be kind enough
to send us the result ?

-- 


					    Gilles.

