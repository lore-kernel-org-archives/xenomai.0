Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433656;
	b=SnG2hZMnEwvywrZ2CCQaoi+yCdDlR3NSk9ZZtLDSLZoUCdlHHDOPJ8VDXmHA/B4mndbB
	 EoZ74UUWNIx1Ar22S6h1f2Vrau3mGXEsmLCxFtLsa6YZ5+3xlCjbztrExoqqNRCemZNPZ
	 RTxKqFeBJf3LWyRRm65ZeIQ61ls+DH6RJJTY761lg5zo3NexQ8xHiA68BwEx6RC5CIWPB
	 7aXbruG40SDgcxpi+hSrxVjNDA3RrRf3Fc8hUI6MgtffBBHb2UIUf/LVt44okUcP7XiXo
	 /VO9rWr/gzqnDL5nud6YU25yJLF1Xt/gXePLKpgaE0LhY+PC0Lbazs/xfP6OwGXhwHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433656;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=8S4/lY38BJBMX319Y1BGhaxowUtbcYu+Xzrzecb6hpE=;
	b=jSSG+jcCBc/4LdiB/CQwpxxh4KwEm1exeezfKQKPSEAZn4TJOLIcXJ4XptF/DfAXVSY6
	 mLvW2LW93n7EAAE/VcSveleivHveE37K7a9VusnL12l7P8w8derK1sWVfbNIg8ZArHg4Z
	 CVE3hzpxcQrdhxpMcyEqy9tBIjjHbXda/gkzRt+9AToveK+spuWo6+wtQKcWkEYbtYTIo
	 t7jAw2PuC45kt+PbMZgrCE4aorqDGM4HwFJe00bAochCF+wUTcI3dSl2pEJeFJBpQezvF
	 FLziKmw15Pz7RRDY0BQjleP06fgMfFz4C0UGEpAm+Nv4UJ1jBgGtvpQYQtLoT6tUjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=FQdt0Tz7;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4E606A324
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 21:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E4E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=FQdt0Tz7
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261111214724b54ff4bae10002072d
        for <xenomai@lists.linux.dev>;
        Wed, 11 Nov 2026 22:47:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8S4/lY38BJBMX319Y1BGhaxowUtbcYu+Xzrzecb6hpE=;
 b=FQdt0Tz779wAhcGH61RKzFqnj9Ey/YDRpi+NmCqPDEAYfxmeI7i+96rMQ8oPmTs+sf1Tj1
 ggz4TqunbeOQUf2dRSzgsjcoWrjSHPfRGIyILF3rHoMVLnZLdJavp0io5VxTA8EaZA1tokZf
 aC/ImzUBC0/mpJ8Vv5ygziP4lmvRaJUBhsRovBEDvBaEEwphibWyHvgWRy/NBFA7yiitNcuD
 mogIJKi0jBqoJJSr+o/tvS01NbjpnqDIdxaKBiVx6+UIrcEItoK01QibcCUWeMVE788s4CGv
 keP0s0q5vo9IiJ4J6A/xic6oixzOBP17uBcfJJxR4xXjoKXCi3WylR4w==;
Message-ID: <df7cb91395df478c36022cd72f22dde93cc63ab7.camel@siemens.com>
Subject: Re: [dovetail 7.3][PATCH] arm: dovetail: Deduplicate dovetail fault
 stubs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Wed, 11 Nov 2026 22:47:24 +0100
In-Reply-To: <ca829aa7-2caf-493e-be78-e5a97e624e0e@siemens.com>
References: <ca829aa7-2caf-493e-be78-e5a97e624e0e@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-11-11 at 17:31 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> BTW, the backport of these to <7.3 went wrong, or 7.3 was fixed up=20
> without fixing older kernels.

I fixed that up during the 7.3 forward port. But: I cannot send
backports for something that has not been released yet.

In addition, if i get this right, this is just a cosmetic change. This
is one of the files that has to be regularly rebased. We try to do that
with pure additions / removals, to keep the process simple.

That may require some minimal code duplication from time to time. This
seems to be the case here.


>=20
>  arch/arm/include/asm/trap_entry.h | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/tra=
p_entry.h
> index 2af401098cec4..a332f90d8843d 100644
> --- a/arch/arm/include/asm/trap_entry.h
> +++ b/arch/arm/include/asm/trap_entry.h
> @@ -5,8 +5,7 @@
>  #include <asm/dovetail.h>
>  #include <asm/trace/exceptions.h>
> =20
> -#ifdef CONFIG_MMU
> -#ifdef CONFIG_IRQ_PIPELINE
> +#if defined(CONFIG_MMU) && defined(CONFIG_IRQ_PIPELINE)
> =20
>  #include <linux/irqstage.h>
> =20
> @@ -55,7 +54,7 @@ static inline void dovetail_fault_exit(int exception, s=
truct pt_regs *regs,
>  =09hard_local_irq_restore(flags);
>  }
> =20
> -#else /* !CONFIG_IRQ_PIPELINE */
> +#else /* !CONFIG_MMU || !CONFIG_IRQ_PIPELINE */
> =20
>  static inline unsigned long dovetail_fault_entry(int exception,
>  =09=09=09=09=09=09 struct pt_regs *regs)
> @@ -72,24 +71,6 @@ static inline void dovetail_fault_exit(int exception, =
struct pt_regs *regs,
>  =09(void)regs;
>  =09(void)combo;
>  }
> -#endif /* !CONFIG_IRQ_PIPELINE */
> -
> -#else /* CONFIG_MMU */
> -static inline unsigned long dovetail_fault_entry(int exception,
> -=09=09=09=09=09=09 struct pt_regs *regs)
> -{
> -=09(void)(exception);
> -=09(void)(regs);
> -=09return 0;
> -}
> -
> -static inline void dovetail_fault_exit(int exception, struct pt_regs *re=
gs,
> -=09=09=09=09       unsigned long combo)
> -{
> -=09(void)exception;
> -=09(void)regs;
> -=09(void)combo;
> -}
> -#endif /* !CONFIG_MMU */
> +#endif /* !CONFIG_MMU || !CONFIG_IRQ_PIPELINE */
> =20
>  #endif
> --=20
> 2.47.3
