Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E81881E
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937116; cv=none; b=U77YwVma5E7rHTKp1bcmoTL1viwwd8CMsqdJymjCaXhyDeV50sC8c8caceXAVy/F8r5KIAHZjgVorXZKo4MAWabdpkLLEBFqVkzAQUbIx4gUrvPaKPZU26UaqRApPOgPGfHI+bj/TtYNcxugm9oxCTgWagftqrsCGheLaFBESow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937116; c=relaxed/simple;
	bh=ivUmjUqmOOA+x23bQrvNt69RW5cYTU0ayI6FgJMRVA4=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=RnxzBBMHJwFi6/VZypxfdaFsLVm0a3tOpNZRxPESRdqGD0s8BMe8uP/RXV4LM46G++Dq1gHvtG/2awSC81P+q8Yp+wWeOddyoMIATcVkGPxvrlRNA4uu7LdNKIjYRlYs/goxi7VoQ04a1ESKscvaWBAyRPYnpYbb8kzY8Fz3GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=h2ZXgYD1; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="h2ZXgYD1"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 9E5481A0002;
	Mon, 18 Nov 2024 13:38:31 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id BAAA9D8110E;
	Mon, 18 Nov 2024 13:38:29 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 1577C60132;
	Mon, 18 Nov 2024 14:38:28 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 4AIDcR1T2724120;
	Mon, 18 Nov 2024 14:38:27 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1731937108;
	bh=ivUmjUqmOOA+x23bQrvNt69RW5cYTU0ayI6FgJMRVA4=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=h2ZXgYD1hLClgCnXLhmc5+84BPVJt+Uy8HnKCLmLoWRZ2+E63FdbQNVohasoMPVp0
	 UxGxsKNaVYPEHEud0DcKGVU5g1Vo1siYjgLiFf/TEGNI88pUQMg3o6mGWQFCJQ3W+H
	 4fIqgEAurBOFK1wMuTcA8As5DBexLl6Qwqo8OjOwxQXPvTS+L1byNMe+sQzOI3Qrkd
	 3g2/oOafZkOJSsRfOki7l4FsJrP2FrsDI5mrhq5uycKp3tmYnUKUa6WxIZYy5k8ywS
	 Fa6e+WXB0QXMx9lqGEOvyerF5WYDQEd3Zfgs7iMcdsYwy74LDbeCmadolqlXVPCKzg
	 mdBtGcvLnI6Ug==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <d06c39a750dd474769035062c2db7591cec9adb3.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.98.110
Date: Mon, 18 Nov 2024 14:38:27 +0100
Cc: "Philippe Gerum" <rpm@xenomai.org>, "Jan Kiszka" <jan.kiszka@siemens.com>,
        xenomai@xenomai.org,
        =?utf-8?q?=E5=AD=99=E6=B6=9B?= <suntaoworks@163.com>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1017-673b4380-33-2c5d8800@259496932>
Subject: =?utf-8?q?Re=3A?= Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("headers rsa verify failed") header.d=thom.fr.eu.org header.s=default header.b=h2ZXgYD1;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org;
	dmarc=none

Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit: 
 
> 
> [ Updated CC list to merge both mail threads ]
> 
> On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > 
> > > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.b=
ezdeka@siemens.com> a =C3=A9crit: 
> > > =C2=A0 
> > > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
> > > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka=
@siemens.com> a =C3=A9crit: 
> > > > > =C2=A0
> > > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > running on an Arm v7 cortex A9 platform, I'm trying to sw=
itch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dove=
tail).
> > > > > > > 
> > > > > > > I can successfully boot my system with linux 5.15 + CONFI=
G=5FDOVETAIL, but as soon as I enable Xenomai (CONFIG=5FXENOMAI), I got=
 stuck at boot in a do=5Fidle loop. Did I miss anything ?
> > > > > > > 
> > > > > > > Attached is my config.
> > > > > > 
> > > > > > Can you factor out from it what the SoC is, if you patched =
the kernel
> > > > > > for it (in the past and now), if you had to adopt Dovetail =
etc.?
> > > > > > 
> > > > > > Jan
> > > > > 
> > > > > The SoC is Xilinx zynq 7000. I have custom patches for custom=
 FPGA peripherals (which most of them have been successfully ported to =
5.15).
> > > > 
> > > > We had a similar report for the zynq 7020 a couple of days ago.=

> > > > See [1].
> > > > 
> > > > What happens if you disable CONFIG=5FSMP? (Not that this should=
 be the
> > > > final solution, but it might help to track the issue down...)
> > > > 
> > > > Florian
> > > > 
> > > 
> > > Disabling config SMP makes my system boot again.
> > > How can I help working this out ?
> > > 
> > > Fran=C3=A7ois
> > > 
> > 
> > This looks like an issue with the proxy tick device. First thing is=
 to
> > disable CONFIG=5FXENOMAI, enabling CONFIG=5FIRQ=5FPIPELINE=5FTORTUR=
E=5FTEST. If
> > the kernel still hangs, we may have a hint about the reason
> > why. Alternatively, you could keep CONFIG=5FXENOMAI in, booting the=
 kernel
> > with "xenomai.state=3Dstopped". If no hang occurs at boot anymore, =
there
> > may be an issue with proxying the timer device on this SoC.
> > 
> > [1] https://v4.xenomai.org/dovetail/porting/timer/
> > [2] https://v4.xenomai.org/dovetail/porting/devnotes/#check-that-th=
e-pipeline-torture-tests-pass
> > 

Plus, I have both ARM global timer and architected timer (I can't seem =
to be able to disable it) activated in config
Kernel/dovetail from https://source.denx.de/Xenomai/linux-dovetail.git =
branch v5.15.y-dovetail

Fran=C3=A7ois

> > --
> > Philippe.
>

