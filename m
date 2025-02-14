Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8B2676D8
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555667; cv=none; b=Ntjb8fFF7mnFkdp6z5d+bW4oug5skygOqhIpIzutWo5p6BojAgmuTgdFuweGqz7j3BcHMs8ItvOWkpDBsZ/s6gYZ7ysbns0LR6cFu1cps0w4YQSkCnvIS/QyXYrGHnTu7kSDLCNIUZ0+Ytzl6ZPcEO0mPZZkTMVDdNlM8PKgjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555667; c=relaxed/simple;
	bh=mW83BS/TSLrxqrcLxxMOQdDnvbPs8Gv+rGfFnz5u6qw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbSsntv90UNSfnU1IdexuS9dTabgJ7w64Sijuej973ys+MaKaaF97breJy9GYHOvpaI1FSqkT/a5ZfoBbS6UNGUQqzA/MC6j1HOGqc7u6GDMaOGiYc37lDlOqqAVDw/WrRde8SekrQTFIMOUXZhXKsgTvFldcDrEW0R5ZrdtCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=G8eALi4J; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="G8eALi4J"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202502141613552c16d8ef3f273599b8
        for <xenomai@lists.linux.dev>;
        Fri, 14 Feb 2025 17:13:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hK+gW6e9pD3wC/AHzOunP1RqlasweGmQBeHqsf1O5KI=;
 b=G8eALi4JgaUZqP4VaNQOw6WkRiKnzM4RvbHifJpfXjfVyuLApWBeq1Hd2T7cQhPtaC8Oow
 bh5oy+H30CUDKfR9kGYudCgbmcU2K4v8Mm2dNqXxOMxwi/5ByOPK7Z5Z++ArbtJrp5WfbYqf
 K+jlV+jlmavauDIz1VTa8lO93E7QX5/PeQ+yUfX3ah20NKy590u4mfoWfRscl3kswiWbARKy
 beY7FaEWpmrTlgwC6q+ftNiyO+0gU8dt1IDVhdf0AyBNkU3QTbYlzBtCQYE0T5IlrAD0G1/C
 0GWMUvptRFYHDpNcBaGg5gV5iDoMz+xWt17YALfGmGl8KrWFH8sfMtZA==;
Message-ID: <7498825b15de24af0759207a57de38493076ec47.camel@siemens.com>
Subject: Re: Problem with moving from Ipipe to dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "marc.straemke" <marc.straemke@eltropuls.de>, xenomai@lists.linux.dev
Date: Fri, 14 Feb 2025 17:13:55 +0100
In-Reply-To: <E1tixlU-000000004ma-2Xgl@smtprelay08.ispgateway.de>
References: <E1tixlU-000000004ma-2Xgl@smtprelay08.ispgateway.de>
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

On Fri, 2025-02-14 at 16:38 +0100, marc.straemke wrote:
> Hello Florian,
>=20
> I had Trouble to boot in kvm but that was just a very short test.=C2=A0
> It seems to happen only at boot time. But very reproducible.=C2=A0
> As soon as I disable the allocator debug option (which is=C2=A0
> curiously enabled in the xenomai images config) it crashes.=C2=A0
> I will try again on qemu on Monday.
> Any idea how to capture a log file on the machine without a serial port?

gdb in combination with the linux gdb scripts might help.

Starting qemu with "-s" enables the gdb stub, you can connect to it
using gdb (as usual). CONFIG_DEBUG_INFO=3Dy might be required, not sure.

$ gdb vmlinux
(gdb) target remote localhost:1234
(gdb) lx-dmesg

lx-dmesg and other utilities can be build with CONFIG_GDB_SCRIPTS=3Dy in
your kernel configuration. There should be some docu somewhere how to
integrate them into gdb.

Florian


>=20
> Marc=C2=A0=C2=A0
>=20
> -------- Urspr=C3=BCngliche Nachricht --------
> Von: Florian Bezdeka <florian.bezdeka@siemens.com>=20
> Datum: 14.02.25  16:35  (GMT+01:00)=20
> An: Marc Str=C3=A4mke <marc.straemke@eltropuls.de>, xenomai@lists.linux.d=
ev=20
> Betreff: Re: Problem with moving from Ipipe to dovetail=20
>=20
> Hi Marc,
>=20
> On Fri, 2025-02-14 at 12:43 +0100, Marc Str=C3=A4mke wrote:
> > Hello Everyone,
> >=20
> > I am trying to move from kernel 5.4.228 with an IPIPE patch to a newer=
=20
> > kernel with dovetail. The config from xenomai-images works, my config=
=20
> > does not.
> >=20
> > The hardware platform is X86_64 on a Beckhoff Made CX20233 industrial P=
C=20
> > (CPUINFO model name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : AMD Ryzen Embedded =
V1202B with Radeon Vega Gfx)
> >=20
> > I tried bisecting the kernel version and basically the problem lies in=
=20
> > the switch to dovetail as far I could find out.
> >=20
> > Then i bisected the configs between my config and the one from=20
> > xenomai-images and got a strange result:
> >=20
> > The config setting which triggers the diff in the kernel configs is=20
> > CONFIG_SLUB_DEBUG_ON=3Dy. With debug on the kernel runs, with debug off=
 it=20
> > hangs.
> >=20
> > Any ideas how this debug setting can cause this issue? How should I=20
> > continue Debugging? I have some mistrust in the "working" kernel becaus=
e=20
> > I cannot really understand how the SLUB debug setting could resolve tha=
t=20
> > issue.
>=20
> Nope, no idea so far. Could be everything...
>=20
> Does your problem also reproduce on qemu/kvm? That might help to
> simplify the debugging process.
>=20
> >=20
> > How would I get more information from the frozen system? I turned up al=
l=20
> > debug settings and get basically no output. The IRQ Pipe torture tests=
=20
> > run ok. The problem only appears if xenomai=C2=A0 is started during boo=
t. The=20
> > failing kernels do boot with xenomai.state=3Dstopped as a parameter.
>=20
> Might be a bug in the IRQ pipeline that shows up as soon as you enable
> an oob stage. A boot log might help to get some more information about
> your system.
>=20
> Is that a boot time failure or something that happens later?
>=20
> Florian
>=20
> >=20
> > Kind Regards
> >=20
> > Marc Str=C3=A4mke
> >=20
>=20

