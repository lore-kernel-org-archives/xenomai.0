Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892B1CCEC6
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026976; cv=none; b=MS0/lXqodtx3m7UKsJQpQCd0A/lUzBWNeq2yzphzPP4qe9fgR2Qbj2s81RSU8LZ+ft35B9sSbbh/FwDvac4PiQhBhDizsFQ7aEpootG0LWsaHTtnx0tneSkURaoSRQ+AMPorH/2bkumb54D+VKy6PpFoqtn8xJORWbj/lkmKCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026976; c=relaxed/simple;
	bh=F58PlJ+adskaaXr+pYTCISvyZFqvyk4aMqA+knLvDtA=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=g46mOaGGntjUvBMjVtDVyTzm8KTXOJHeXQ8QshWg9+SiBV73K6cKDItHnCTuSFskF73PrvHNl/Cp3/xDofdg0/xqWVpRmZ6kQ1qqqEcTkhwixWRw0LSHetkkTfdJjdTy2SVGLl2gvRUVPG8ZwHqfGEgL63tAUhBPFdsuchaNhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=ueNmqUjP; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="ueNmqUjP"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 9B38B240003;
	Tue, 19 Nov 2024 14:36:09 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 89D61941B36;
	Tue, 19 Nov 2024 14:36:07 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 6399260146;
	Tue, 19 Nov 2024 15:36:07 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 4AJEa4SG2774918;
	Tue, 19 Nov 2024 15:36:04 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1732026964;
	bh=F58PlJ+adskaaXr+pYTCISvyZFqvyk4aMqA+knLvDtA=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=ueNmqUjPulMe371TdXIrr3wT/6ia+wDi55Anl5CiAwZ6EN+432l86bShwFHsKEKQ7
	 otumvQXRCHaW9qI/W7zLPx494yR2njUAAnZfZOP4LSImiPNnOonTf4t7+gkh71BLB0
	 vDDVbCA+MRYCOHSgUWGgKnz/LDxId2BWaBZvh/Gx+GwWdPhHOGHSVy5l4R/k92/Ak8
	 y8TPRpe5BU+VAvY7BjWVijd4jpJqroCV3AHDteLjn10u6xi94D6xQtFNT2btfc8AHY
	 qWfrS2UyBVfoa0Hd3qX6b4HnKxwRB+pLFpShSouCm3NKAvu/D4CVWyC+9wM8D0UmLZ
	 sxIRLmPZR4Oyw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87v7wjed3w.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.98.110
Date: Tue, 19 Nov 2024 15:36:04 +0100
Cc: "Julien Aube" <julien.aube@smile.fr>, xenomai@xenomai.org
To: "Philippe Gerum" <rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <101a-673ca280-17-7629bb00@147965553>
Subject: =?utf-8?q?Re=3A?= Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("headers rsa verify failed") header.d=thom.fr.eu.org header.s=default header.b=ueNmqUjP;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 212.27.42.5 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Mardi, Novembre 19, 2024 11:23 CET, Philippe Gerum <rpm@xenomai.org>=
 a =C3=A9crit: 
 
> Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:
> 
> > Le Mardi, Novembre 19, 2024 10:26 CET, Julien Aube <julien.aube@smi=
le.fr> a =C3=A9crit: 
> >  
> >> Hello,
> >> 
> >> Reading this exchange it reminds me of a problem I had a few month=
s ago 
> >> on the same platform.
> >> 
> >> Here is the thead :
> >> 
> >> https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e4d42=
29@smile.fr/#r
> >> 
> >> 
> >> Conclusion was that disabling the scutimer(*) on DTS level was eno=
ugh to 
> >> restore the correct usage and I did not found
> >> any bad behaviour after that. The product has passed all the rt-te=
st 
> >> afterward.
> >> 
> >> 
> >> (*)
> >> &scutimer {
> >>  =C2=A0=C2=A0=C2=A0 /* scutimer is forced to disabled since it doe=
s not work with 
> >> Xenomai */
> >>  =C2=A0=C2=A0=C2=A0 status =3D "disabled";
> >> };
> >> 
> >> Maybe i'm completely off the subject, but maybe it's worth having =
a look ?
> >> 
> >> Julien
> >> 
> >> 
> >
> > Thanks. That fixes the problem. I'll dig into that driver to try to=
 fix it and submit a patch then.
> >
> 
> This may help:
> 
> diff --git a/arch/arm/kernel/smp=5Ftwd.c b/arch/arm/kernel/smp=5Ftwd.=
c
> index 8377f1d030c3a..a28f6b7f7eabc 100644
> --- a/arch/arm/kernel/smp=5Ftwd.c
> +++ b/arch/arm/kernel/smp=5Ftwd.c
> @@ -181,7 +181,7 @@ static irqreturn=5Ft twd=5Fhandler(int irq, void =
*dev=5Fid)
>  {
>  	struct clock=5Fevent=5Fdevice *evt =3D dev=5Fid;
>  
> -	if (twd=5Ftimer=5Fack()) {
> +	if (!clockevent=5Fis=5Foob(evt) || twd=5Ftimer=5Fack()) {
>  		clockevents=5Fhandle=5Fevent(evt);
>  		return IRQ=5FHANDLED;
>  	}
> 

No noticeable effect here. I tried to dig a little more into this, but =
I can't find anything.
What I can tell, is that the TWD interrupts triggers on both cores when=
 hung at boot. TWD registers settings seems OK in terms of prescaler an=
d everything. By checking with JTAG debugger, I can see that xnintr=5Fc=
ore=5Fclock=5Fhandler is being called in the TWD service routine (twd=5F=
handler).

I'm trying a little harder, but don't really know from which angle !

Fran=C3=A7ois

> -- 
> Philippe.

