Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F56211C
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035853; cv=none; b=swA73IIOYpjHmqHrnBv0Aa3RUB7VQ97L6H3JYXFh2x+ng1JWZe2hDzR0vqovNoOeupVrKErTVGT+aSIRvjLfvuVcI77Lw6C5qNpBaSQ3id0s5saox5wsc0zCb+0wldsBrrpccOhdq0ibsNbh4MQGIkripV0CRGIv+3LFmhqhM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035853; c=relaxed/simple;
	bh=H0/iIyczg8CvVNNTJ40/UOS+83nRm9MZaJXQh9d3mFk=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=PgE6I7luh7lSpcduEzaeTUFDPwL7njJ9z013Lczbnr3GTlhfAZdE78oq5nymqriyCa4pLI2Cb66mP3vL5Mw233UKwZOEg9bS80C+TYLqNAFA2SR+q42s39S2NxEXbAIZa4uPczXYYGrbi46q4ig1JcSs35i8fG9wq+6d0ll395I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=NfyG8Qmq; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="NfyG8Qmq"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 814301A000B;
	Tue, 19 Nov 2024 17:04:08 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B2E20941BB6;
	Tue, 19 Nov 2024 17:04:07 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 9313260142;
	Tue, 19 Nov 2024 18:04:07 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 4AJH41xd2780660;
	Tue, 19 Nov 2024 18:04:06 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1732035846;
	bh=H0/iIyczg8CvVNNTJ40/UOS+83nRm9MZaJXQh9d3mFk=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=NfyG8QmqDGrdYqZBuEFgEGRb1tVvhr4ikp/jEjhApUR9Ygno4Y5NvYQXQGc2Be9x0
	 iB5dY1nzxifRtJi79IbAwzB1qllvtbT2qK5j/ApJ3SWUfsYlTLZPttLEAPjz5y9stj
	 3hG0Ag9ZcZT1lsKW5Q92vlKLbPfGg2cpeFbzleOE4UBe+U4kP72lU8bYBT4TBLOVlj
	 ByMqGkoJIe9ua5PiupJCP68/opf33UWvVouAdo1Wm4fwMsQRQ5AN6U1YgiwKp9NiqJ
	 qazWm/0qcv6xnbFrFAUkliGQmB0bln4+2A/Qz3yo9T6oGKFHE2SIq7yA6UKKv6QZje
	 IMCu8koYbl9Jg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87ed37dx1z.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.98.110
Date: Tue, 19 Nov 2024 18:04:01 +0100
Cc: "Julien Aube" <julien.aube@smile.fr>, xenomai@xenomai.org
To: "Philippe Gerum" <rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1018-673cc500-3d-5b0c8700@226930393>
Subject: =?utf-8?q?Re=3A?= Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("headers rsa verify failed") header.d=thom.fr.eu.org header.s=default header.b=NfyG8Qmq;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Mardi, Novembre 19, 2024 17:10 CET, Philippe Gerum <rpm@xenomai.org>=
 a =C3=A9crit: 
 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >
> >> Le Mardi, Novembre 19, 2024 11:23 CET, Philippe Gerum <rpm@xenomai=
.org> a =C3=A9crit: 
> >>  
> >>> Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:
> >>> 
> >>> > Le Mardi, Novembre 19, 2024 10:26 CET, Julien Aube <julien.aube=
@smile.fr> a =C3=A9crit: 
> >>> >  
> >>> >> Hello,
> >>> >> 
> >>> >> Reading this exchange it reminds me of a problem I had a few m=
onths ago 
> >>> >> on the same platform.
> >>> >> 
> >>> >> Here is the thead :
> >>> >> 
> >>> >> https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e=
4d4229@smile.fr/#r
> >>> >> 
> >>> >> 
> >>> >> Conclusion was that disabling the scutimer(*) on DTS level was=
 enough to 
> >>> >> restore the correct usage and I did not found
> >>> >> any bad behaviour after that. The product has passed all the r=
t-test 
> >>> >> afterward.
> >>> >> 
> >>> >> 
> >>> >> (*)
> >>> >> &scutimer {
> >>> >>  =C2=A0=C2=A0=C2=A0 /* scutimer is forced to disabled since it=
 does not work with 
> >>> >> Xenomai */
> >>> >>  =C2=A0=C2=A0=C2=A0 status =3D "disabled";
> >>> >> };
> >>> >> 
> >>> >> Maybe i'm completely off the subject, but maybe it's worth hav=
ing a look ?
> >>> >> 
> >>> >> Julien
> >>> >> 
> >>> >> 
> >>> >
> >>> > Thanks. That fixes the problem. I'll dig into that driver to tr=
y to fix it and submit a patch then.
> >>> >
> >>> 
> >>> This may help:
> >>> 
> >>> diff --git a/arch/arm/kernel/smp=5Ftwd.c b/arch/arm/kernel/smp=5F=
twd.c
> >>> index 8377f1d030c3a..a28f6b7f7eabc 100644
> >>> --- a/arch/arm/kernel/smp=5Ftwd.c
> >>> +++ b/arch/arm/kernel/smp=5Ftwd.c
> >>> @@ -181,7 +181,7 @@ static irqreturn=5Ft twd=5Fhandler(int irq, v=
oid *dev=5Fid)
> >>>  {
> >>>  	struct clock=5Fevent=5Fdevice *evt =3D dev=5Fid;
> >>>  
> >>> -	if (twd=5Ftimer=5Fack()) {
> >>> +	if (!clockevent=5Fis=5Foob(evt) || twd=5Ftimer=5Fack()) {
> >>>  		clockevents=5Fhandle=5Fevent(evt);
> >>>  		return IRQ=5FHANDLED;
> >>>  	}
> >>> 
> >>
> >> No noticeable effect here. I tried to dig a little more into this,=
 but I can't find anything.
> >> What I can tell, is that the TWD interrupts triggers on both cores=
 when hung at boot. TWD registers settings seems OK in terms of prescal=
er and everything. By checking with JTAG debugger, I can see that xnint=
r=5Fcore=5Fclock=5Fhandler is being called in the TWD service routine (=
twd=5Fhandler).
> >>
> >> I'm trying a little harder, but don't really know from which angle=
 !
> >
> > The issue is as follows:
> >
> > When the proxy tick hijacks the timer to hand over its control to
> > Xenomai, twd=5Fhandler() may be called either from the oob stage up=
on a
> > real tick coming from the hardware, =5Fand=5F from the in-band stag=
e as a
> > consequence of emulating a common kernel tick, see [1] in the "Unde=
r the
> > hood" section.
> >
> > The way twd=5Fhandler() operates ATM causes the hardware to be sent=
 an ack
> > on every invocation, which is wrong wrt the in-band tick emulation,=

> > which is most likely wrecking the logic afterwards.
> >
> > [1] https://v4.xenomai.org/dovetail/porting/timer/#proxy-tick-logic=

> 
> diff --git a/arch/arm/kernel/smp=5Ftwd.c b/arch/arm/kernel/smp=5Ftwd.=
c
> index 8377f1d030c3a..194d3cc7ca2c8 100644
> --- a/arch/arm/kernel/smp=5Ftwd.c
> +++ b/arch/arm/kernel/smp=5Ftwd.c
> @@ -181,7 +181,7 @@ static irqreturn=5Ft twd=5Fhandler(int irq, void =
*dev=5Fid)
>  {
>  	struct clock=5Fevent=5Fdevice *evt =3D dev=5Fid;
>  
> -	if (twd=5Ftimer=5Fack()) {
> +	if ((running=5Finband() && clockevent=5Fis=5Foob(evt)) || twd=5Ftim=
er=5Fack()) {
>  		clockevents=5Fhandle=5Fevent(evt);
>  		return IRQ=5FHANDLED;
>  	}
> 

No noticeable effect here too.
I tried to modify the code on my side to "mimick" the behaviour of glob=
al=5Ftimer without luck.

Fran=C3=A7ois

> -- 
> Philippe.

