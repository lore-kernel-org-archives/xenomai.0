Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E2250BF8
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547914; cv=none; b=jKeDkVis//FPR/W4nZiBQ/9gX8QnR77FA+2poO8ODZ+9iMmWzkhEKQtDSdi6yzvUEUiO3IBWDH44wfMGIPqQuyZOfjq+/z3wRIDlloj86rmyl8R4eaanemovxftTzWpIiXUHg1QO5akXUhvgpKUFU9msDYeMFXSpSTi38H2kg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547914; c=relaxed/simple;
	bh=0Sol4xdmaNAHKq2v9OoCymW9YesqowvtXa6WGRdQZlg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ThnU0lqRG8Z2gYoJFoYBdY9+fKCbpEuaqp7gsbGZFgEjT9WAZEkMoAMvCLhuLM/KLNMshilWSETSmRimIJ4rB2BnDFvoAde4fljqJbHJLguiA+vCLUql+lajXUEuh8lhtEkymzpp3uoRgudFVwUKUfVmvw0Jjs8NLAK/cTJsTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BfAmZ8/W; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BfAmZ8/W"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250214153458d82c6130abea348271
        for <xenomai@lists.linux.dev>;
        Fri, 14 Feb 2025 16:34:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=0Sol4xdmaNAHKq2v9OoCymW9YesqowvtXa6WGRdQZlg=;
 b=BfAmZ8/WWYKKxHbQqLDSlgGOGeDDA8gs51lfFgUzeWq1fDh9ENsTIOWQLv0mOi9RAhB7z0
 lX9vT1eVkLdEHnzUBL0H/u3jXnbnB2b1qa25UROQWsijxkOpoL2NFfs39LtcmLQST7pVyP93
 epeG/5aj/cUWe1sugeWUWeT5/qQfjda9pOryQFUfNK5CuYguWy2uF4SIkVZFBb5l0VHTCQNd
 FgnDzjfRmwrlaxaECIrB115p9es7+Su87YOExxw+G3ep2bvq8YJRmzuDbu9n+5ldQowVhwRk
 9RcKv/76VhEyVLEuSyYMhq7aUz8Y4CpW7RHLL1hBuipAr9+S2Q40mmgg==;
Message-ID: <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
Subject: Re: Problem with moving from Ipipe to dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>, 
	xenomai@lists.linux.dev
Date: Fri, 14 Feb 2025 16:34:55 +0100
In-Reply-To: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
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

Hi Marc,

On Fri, 2025-02-14 at 12:43 +0100, Marc Str=C3=A4mke wrote:
> Hello Everyone,
>=20
> I am trying to move from kernel 5.4.228 with an IPIPE patch to a newer=
=20
> kernel with dovetail. The config from xenomai-images works, my config=20
> does not.
>=20
> The hardware platform is X86_64 on a Beckhoff Made CX20233 industrial PC=
=20
> (CPUINFO model name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : AMD Ryzen Embedded V1=
202B with Radeon Vega Gfx)
>=20
> I tried bisecting the kernel version and basically the problem lies in=
=20
> the switch to dovetail as far I could find out.
>=20
> Then i bisected the configs between my config and the one from=20
> xenomai-images and got a strange result:
>=20
> The config setting which triggers the diff in the kernel configs is=20
> CONFIG_SLUB_DEBUG_ON=3Dy. With debug on the kernel runs, with debug off i=
t=20
> hangs.
>=20
> Any ideas how this debug setting can cause this issue? How should I=20
> continue Debugging? I have some mistrust in the "working" kernel because=
=20
> I cannot really understand how the SLUB debug setting could resolve that=
=20
> issue.

Nope, no idea so far. Could be everything...

Does your problem also reproduce on qemu/kvm? That might help to
simplify the debugging process.

>=20
> How would I get more information from the frozen system? I turned up all=
=20
> debug settings and get basically no output. The IRQ Pipe torture tests=
=20
> run ok. The problem only appears if xenomai=C2=A0 is started during boot.=
 The=20
> failing kernels do boot with xenomai.state=3Dstopped as a parameter.

Might be a bug in the IRQ pipeline that shows up as soon as you enable
an oob stage. A boot log might help to get some more information about
your system.

Is that a boot time failure or something that happens later?

Florian

>=20
> Kind Regards
>=20
> Marc Str=C3=A4mke
>=20

