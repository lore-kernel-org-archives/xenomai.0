Message-ID: <4C7232E6.8070709@domain.hid>
Date: Mon, 23 Aug 2010 10:35:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>
In-Reply-To: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai patch for AT91ARM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: xenomai@xenomai.org

Prakash A S wrote:
> Dear All,
>          Now I am working on AT91RM9200 based processor ARM board with Linux
> 2.6.20 kernel and also planing to port Xenomai on this board. I preferred
> xenomai-2.4.0. Because it has adeos-ipipe patch for 2.6.20 kernel. However I
> found that there is an separate ipipe patch available for AT91 processor in
> xenomai-2.3.2. Do I need any similar patch for xenomai-2.4.0 or
> adeos-ipipe-2.6.20-arm-1.802.patch is enough?.
> 
> I beleive the steps will be like,
> linux-2.6.20+2.6.20-at91.patch.gz+adeos-ipipe-2.6.20-arm-1.802.patch

You did it again: as documented in ksrc/arch/arm/patches/README,
what Xenomai version you pick is largely irrelevant to what I-pipe patch
you want to use, so, you can probably use the I-pipe patch for 2.6.20
with Xenomai 2.5.4.

All releases of a Xenomai branch are backward compatible, so, if you
want to pick something in the any branch, pick the latest (2.4.10 for
2.4 branch, 2.5.4 for 2.5 branch). Also note that all I-pipe patches up
to, but not including, 2.6.28-1.12-05, are buggy, so, if you want to use
2.6.20, you will have to apply the patch attached to this mail:

https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html

As for the initial question, I do not remember that far in the past.
But, at some point in the past, the I-pipe patch started being able to
be applied with and without the AT91 patch, I do not remember if
2.6.20-1.8-02 was in this case.

-- 
					    Gilles.

