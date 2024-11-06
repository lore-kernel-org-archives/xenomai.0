Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932A1DC747
	for <xenomai@lists.linux.dev>; Wed,  6 Nov 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888169; cv=none; b=qLxHABg/cJcald6fIUmsOM8DA3HXsPuEOFl0H49/7ieXKAdmCszws19HX1gsHVRr4JLvE7ozIdnOFh7Gp0C0EkYRQlL4FO3EBWswIe+b6f6A9QBmgoZeVd3EKplHd09y3J2JEUr1ixOeIB5960omWGBoyxnuC5eppx6Cm7OKEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888169; c=relaxed/simple;
	bh=JRUOAMKEVPoiQAk5vl5aw+G47qENAMBxaeoKeDsX8FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kE33eL1DFjuURJ5Ib9ZmeJBICshRIyhdnsTaVZ+fJtCA5agxbrn7M3ee292p8K/4vSr9KliD3jL12sUwEyox83MRwgjWuP80FldXnv/UBh4rGHQKXmiP7CsTTQHHQnCPybPdODU+Mc8OyajNA8M+ouWodCpAP27d82lOuRT4qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RT7oXdnd; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RT7oXdnd"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241106083537b2eb6168d70c81ad3a
        for <xenomai@lists.linux.dev>;
        Wed, 06 Nov 2024 09:35:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JRUOAMKEVPoiQAk5vl5aw+G47qENAMBxaeoKeDsX8FY=;
 b=RT7oXdnd2mgQfTdBVutrgzyAbxGjLhVQ3xr0btb4OJw6v+Kozrj257pC5KdyfVFpU98Gac
 f169gI54+DgtzZAWUKihuZf6h46D+2IlrtK47zbZd4GaFW5eZ55hjJUaYNN9PVG22HY9Jfu+
 JThgcsYmzbNn+Q8JO02R2FTLHv2AQGI610jd5p6oamKWur82gIKQrqYmZ1rkRDJ0UxOsV6h+
 ntCN2gGvpn/0bOhrHvv1NhahrQagtThB4hdg7QJRdilDBpAVHHo3rodAyvraO/3XS/SaWm8l
 0U+GR/mdYZ+PFF63G10fClRQtZGuKQm0JzJ9scMMjosbgFwWNsetWkJQ==;
Message-ID: <a4a2b13bf019e1c2b2d1fa8633f984b5e3068161.camel@siemens.com>
Subject: Re: Re: hand up when boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?UTF-8?Q?=E5=AD=99=E6=B6=9B?= <suntaoworks@163.com>
Cc: xenomai@lists.linux.dev
Date: Wed, 06 Nov 2024 09:35:36 +0100
In-Reply-To: <73c9882b.5464.193000a0606.Coremail.suntaoworks@163.com>
References: <10a77915.2e93.192e07bd1d7.Coremail.suntaoworks@163.com>
	 <71139a9c193d776b890f11ebb01ae7a3e9dbd7bb.camel@siemens.com>
	 <73c9882b.5464.193000a0606.Coremail.suntaoworks@163.com>
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

On Wed, 2024-11-06 at 13:54 +0800, =E5=AD=99=E6=B6=9B wrote:
>=20
> Thanks for your reply. I am sorry for making you confused. English is not=
 my mother language.I will try my best to make this question clear. The lin=
ux kernel is supplying by xilinx instead of standard. the source code site =
is : https://github.com/Xilinx/linux-xlnx .The kernel config is also supply=
ing by xilinx.there is no log in console,just like hangs up.I think maybe s=
ome kernel config disabled by mistake=C2=A0
>=20

[Adding back the Xenomai List in CC]

Taken from the attachment:

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set
# end of Serial drivers

There is no serial driver enabled. That explains why there is nothing
on the serial console.

As I don't know that board I can not really help here. Suggestion: Try
to boot up Linux (as provided by the vendor) with serial console
enabled. If that works - and you can follow the boot process on the
console - try enabling Dovetail/Xenomai on top. Step by step.

- Linux
- Linux with Dovetail enabled
- Linux, Dovetail, Xenomai as co-kernel

I'm not sure if patching Dovetail into this vendor kernel will work
out. Let's see...

Best regards,
Florian

>=20
>=20
>=20
>=20
> At 2024-10-31 19:18:55, "Florian Bezdeka" <florian.bezdeka@siemens.com> w=
rote:
> > On Thu, 2024-10-31 at 10:51 +0800, =E5=AD=99=E6=B6=9B wrote:
> > > dear all,I use linux kernel 5.15.36, xenomai 3.2.4, dovetail 5.15.9
> > > for zynq 7020 developing. when I open config_smp, it hands up when=C2=
=A0
> > > kernel boot.It's ok when i close config_smp or close=C2=A0
> > > config_xenomai.zynq 7020 uses arm A9 core,so i patch by=C2=A0
> > > --arch=3Darm.I can't find how to solve it,please help me.Thanks.
> >=20
> > Hi,
> >=20
> > was this mail/text translated with some online tool? I'm not sure if
> > I'm able to parse / understand it correctly.
> >=20
> > Here comes a try:
> >=20
> > Let's start with versions:
> > - Xenomai 3.2.4
> > - Dovetail 5.15.9
> > - Linux 5.15.36
> >=20
> > What are you trying to boot up? Linux or Dovetail?
> >=20
> > > It's OK when I close config_smp
> >=20
> > "close" doesn't make sense here, maybe you mean "disable"? I also
> > assume that you are referring to the kernel configuration option
> > CONFIG_SMP.
> >=20
> > > or config_xenomai
> >=20
> > Another guess: You mean kernel configuration option CONFIG_XENOMAI.
> >=20
> > > zynq 7020 uses arm A9 core
> >=20
> > Seems to be an ARMv7, so 32 bit processor.
> >=20
> >=20
> > Summary:
> > You have problems booting up (Linux and/or Dovetail, still unclear)
> > with CONFIG_SMP and CONFIG_XENOMAI enabled at the same time while all
> > other combinations (especially CONFIG_SMP and !CONFIG_XENOMAI) work?
> >=20
> > We are regularly testing the armv7 support on two machines
> > =C2=A0- The beagle-bone-black (non SMP)
> > =C2=A0- qemu (SMP)
> > so I'm quite sure that the SMP combination works. You might have to
> > find out if there is any difference in your setup / hardware.
> >=20
> > Do you have any additional information available? A boot log taken from
> > a serial console might help to identify problems.
> >=20
> > Best regards,
> > Florian
> >=20
> >=20

