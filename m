Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07413524B4
	for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973376; cv=none; b=FTwSL844pX3z7XA1Ox/Oaa7DiUDUz7amUevU9i8rJlxUBQ+hJt2L47DzihlE4ek/jJ2FD+zTfVUWyNrFhUjs1jy0TMzgg6dN50psdIPjCKJQ2vgH8AQD5Q1cIEURUvBd/rCcpUxYdVSQxC4667DkNz2zR6V/tQwOKMCoeerY2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973376; c=relaxed/simple;
	bh=I8LgaC3Asn6ttY7r16aL9WwbQZgJnPbN9NTQV/jbiPo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/Lrf6fHgf8NiG47X3EHFewRgU/sGF+QlGL5rfEOVBYle2dRshOK0ZtJYvJWxgladd9edgAdrMiCrsH2pkzPNaRLcE3srSzi1D/nY3uBMtllQwqtdHdtwuB9CcCaggO9b4DLXFEce6n4WhEBxKzjNXczvFZKFqCQBRDw+YConNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SqyYrVBA; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SqyYrVBA"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240910130238d63e099d87090b4119
        for <xenomai@lists.linux.dev>;
        Tue, 10 Sep 2024 15:02:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=I8LgaC3Asn6ttY7r16aL9WwbQZgJnPbN9NTQV/jbiPo=;
 b=SqyYrVBA9bj/oJhpakmoVFJPaTAS2muptO5tRuBkZrJtDNMICA7U4lFEX1B4l9CLBHT0/e
 cGwkiv0sKadcLvNjANHB7T6liNLvX+3LFT/ZF1FbpBfFilHio7swWbBRhLC/1xFErmF+dTi9
 TzoStNZa6Mox1y7DZKKpDiiU9K9AIXUH9XQjYkSMoX05WbnSQq9XuvIK8FGQwRF+OwXO1SJE
 qSch/h7Inqy4RoH4aS8dftYSyA85o7MOlW+TkERQnCN6btgINsA7MG4OSIoo5cmpI7iNBcTy
 rLB5qUj509Xae3E0YV41oSlr2k4weDm3T/TalaH477qlAx63BUvuA04A==;
Message-ID: <f9515fad85ed3e0df9197936f27db63b41050436.camel@siemens.com>
Subject: Re: Compilation error kernel Xenomai3 for x86 32 bits
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Date: Tue, 10 Sep 2024 15:02:37 +0200
In-Reply-To: <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
References: 
	<AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
	 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
	 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
	 <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com>
	 <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2024-09-10 at 12:46 +0000, LE-DOUARAIN Marc wrote:
> > >=20
> > > > > I=E2=80=99ve tried to compile linux-dovetail-v5.10.214-dovetail1 =
github=20
> > > > > repository for Xenomai 3.2.5 (from a Debian12.6=C2=A0i386), and i=
t failed on theses errors=C2=A0:
> > > > > (the same with Xenomai 3.2.4)
> > >=20
> > > > I think the main point here is that we do no longer support 32 bit =
kernels. We still support the compat case, so 32 bit applications running o=
n a 64 bit kernel. Might that be an option for you?
> > > > Should work as long as your board supports is 64 bit.
> > >=20
> > > We are working step by step to update OS with an old base hardware (I=
SA bus) as transitional for now, and will use a 32 bits CPU "Vortex86DX3".
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > > > =C2=A0
> > > > > I=E2=80=99ve used the command =C2=AB=C2=A0/prepare-kernel.sh --li=
nux=3D########/linux-dovetail-v5.10.214-dovetail1 --arch=3Di386=C2=A0=C2=BB=
 before configuring kernel.
> > > > > Not better with linux-dovetail-v6.6.23-dovetail2.
> > >=20
> > > > Haven't touched the prepare-kernel script for a while. Seems we sho=
uld bail out and complain loudly when trying to use --arch=3Di386.
> > >=20
> > > If I can understand that for the =E2=80=9Cnew=E2=80=9D Xenomai 4, 32 =
bits is excluded,=20
> > > it's perhaps a pity that Xenomai 3 can't continue to be used, especia=
lly if there's not much to be done to fix it and make it work on 32 bits.
> >=20
> > 32-bit x86 kernels are practically history since almost a decade, indep=
endent of Xenomai. 32-bit applications on 64-bit kernels are still supporte=
d (even with Intel upcoming cuts), but only few people were testing 32-bit-=
only x86 kernels that long ago. Probably almost no one is doing it in this =
decade anymore. Distros have dropped 32-bit, and CPUs that lack 64-bit supp=
ort can be counted with one hand - if not even a single finger.
> Although rare these days, some distros 32 bits are still available, like =
the classic Debian ! =F0=9F=98=89

Be careful. Not all packages in Debian still work for i{3,4,5}86.

Example: sudo and strongswan.

Some packages - as the ones above - have some security / hardening
features enabled that require a i686 CPU.

Running those packages will trigger a illegal instruction exception.

>=20
> > > Is the error, on Xenomai side, or moreover kernel patched ?
> > > Which kernel / Xenomai latest versions were running on 32 bits for su=
re, or at what time ?
>=20
> > I would not say that Xenomai 3 is definitely dead on i386 but no one lo=
oked at it in a very long while. It could theoretically still work with ipi=
pe-4.4.y-cip, but anything newer dropped it. While we are still carrying i3=
86 in that kernel, we didn't test it for many years now. Also note that thi=
s kernel is now getting closer to its EOL.
>=20
> I could effectively go back to ipipe for this transition stage on our cur=
rent hardware.
> The latest ipipe kernels seems to be available here : https://source.denx=
.de/Xenomai/
> but what is the difference between repositories ipipe and ipipe-x86 ?
> What was the last known Xenomai version 3.x really used and tested with i=
pipe?

Xenomai 3.2.x (stable branch) is regularly CI tested with Linux 4.19
and 5.4 (both ipipe based). Again 64 bit kernels only.=20

>=20
> Thanks to you again,
> Best regards.
> Marc.
>=20
>=20
>=20

