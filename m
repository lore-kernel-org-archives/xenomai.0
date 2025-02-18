Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4B22F16F
	for <xenomai@lists.linux.dev>; Tue, 18 Feb 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875331; cv=none; b=V/Iov6S9bsVLpKQ6O0evRp9QALUjEQivqkT6MZsN/gNnA3zornXZiQQ5/UuAlkeYvRSuT29IASORfva0uta68j3Uru3ahpjEwNESGqYpBbOJHpbJFCmjmtlXriHsHAZn37Xe3AwAxDTI4w4AEJalxpTxN/uVGG2H6FTwfuiCKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875331; c=relaxed/simple;
	bh=Ua6HZRX/rE5IsIetdakvoFjyWT3SfRYLDVhN3kZ+/lU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhUKg8Jo/enbj9cqm27wSGyGsSk2dvcSroCPDZXw85XMIwc0He1GyDo/PQpz9htGEQ5sb031xj1vGpW9azLI06a7yFBGlOmMdDGmRg0LQutxfWXKKoXacDF4m9JIp2pfEMeZNaZ36MkFnj6DEii7mYrsFa55+GT8f3efbqUYdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QdM/+rWa; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QdM/+rWa"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202502181042011faaae0b66b9b6707a
        for <xenomai@lists.linux.dev>;
        Tue, 18 Feb 2025 11:42:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UutzxJo9u3bCk61v6VsJ4bxu4RCIV1GbWrQx7OXqGos=;
 b=QdM/+rWapZ262Wwfx0lCaCCUDWR+wzIcvZG/6JESkfygs44eWeRYFAspt7CBxPXziytuXX
 JYq8X1/uwp6iJq4Lt7A5nWrJmET08Vm90DDKRtp3AjxmzxEpU0aEMUxCPTauBIfkLhgY5zeO
 VAh0qxrsZqUI4i7JYdjT7VHrBNQfNxvKfQpPadE1kUj0/2NHKA8+kytYq6HWEayzhxMIZu5i
 Zz5HXodutHw6EiBgB+rXrHpcqcwAdvmvg1csQd0AYcax1YWrcs/Q8u/8XUnqz8VWTJk500bl
 8E07fF/Nzt2yzTcGf7YAfU1YxK+RTAWxjMe9eN8Tg51/8Q8E2OU3kTbQ==;
Message-ID: <d378d69ebda4a573066bf92154a2b8e8358f8aed.camel@siemens.com>
Subject: Re: Problem with moving from Ipipe to dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>, Jan Kiszka
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 18 Feb 2025 11:42:00 +0100
In-Reply-To: <56ea2070-cfc5-4b03-b073-aef489932093@eltropuls.de>
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
	 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
	 <fac0181a-eee1-4820-ad8c-ea2b88629f5f@eltropuls.de>
	 <a398fe9f-d3c0-4254-8a9e-5fe0eff25f86@eltropuls.de>
	 <23280aaa-d95d-4ae0-8ce4-ebfcdb857e44@siemens.com>
	 <bb3d5883b5fadf01598a192c5afacdcbe66a0ce7.camel@siemens.com>
	 <56ea2070-cfc5-4b03-b073-aef489932093@eltropuls.de>
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

On Tue, 2025-02-18 at 11:06 +0100, Marc Str=C3=A4mke wrote:
> Hello Florian,
>=20
> On 17.02.25 23:32, Florian Bezdeka wrote:
> > Run lx-dmesg (see previous mails), just to make sure we don't have any
> > pending WARN() in the console buffer pending that did not make it to
> > the console (due to a broken IRQ pipeline) anymore.
> >=20
> > In addition: We dropped the maintenance support for 6.6 a view weeks
> > ago. There was an announcement on the list. Can you reproduce the same
> > issue with 6.12? The 6.6 based branches will not be touched anymore.
>=20
> I have not been able to find that announcement. My selection of 6.6 was=
=20
> based on it being listed as the LTS on the xenomai.org homepage...
>=20
> I retried with 6.12, bootlog attached. Same symptoms.
> No further messages in lx-dmesg.
>=20
> >=20
> > Two more things that jumped at me but might be unrelated:
> > - Dynamic Preempt: full
> > - Clocksource: Each provided log seems to use a different clocksource,
> >    especially TSC is missing in the dmesg_runs_kvm_smp2 file.
> Clocksource is really puzzling me. To me it looks like the major=20
> divergence between both logs is when it the working log I get:
>=20
> [    2.158696] tsc: Refined TSC clocksource calibration: 2399.965 MHz
> [    2.159240] clocksource: tsc: freq: 2399965000 Hz, mask:=20
> 0xffffffffffffffff max_cycles: 0x22981673afd, max_idle_ns: 440795328505 n=
s
> [    2.159930] clocksource: Switched to clocksource tsc
>=20
> While in the non working case the progress in the logfile stops at this=
=20
> moment, so can something go wrong when switching the clocksource to tsc=
=20
> or in this refining TSC calibration step?
>=20
> I tried with Dynamic Preempt disabled. No difference
> Preempt_Voluntary also made no difference.
> Preemp_none also no difference.
>=20
>=20
>=20
> The one thing I cannot understand honestly is that I get this issue at=
=20
> all. Is no one using dovetail on X86? (Most posts I see are from ARM).=
=20
> The only difference in kernel config to the xenomai-images config is=20
> that I enabled overlayfs and squashfs (my root image is based around=20
> debian-live)

We're using Dovetail on x86, but: I think all of our boards are Intel
based while yours is an AMD. There might be a small but significant
difference (code wise) somewhere, but as a kvm / virtual target is also
affected that's kind of unlikely.

Let me try to build one of your configurations that does not boot up on
top of KVM. Might take a couple of days...

>=20
> Thank you for your help,
>=20
> Marc
>=20
>=20
>=20

