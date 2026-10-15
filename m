Received: from calculus.sigma-star.at (calculus.sigma-star.at [188.245.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397851AFDB
	for <xenomai@lists.linux.dev>; Thu, 15 Oct 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.196.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065497; cv=none; b=hN2xsUbb/imhvSv2gP4Y3ceq3XKsuZZgA7N9/gmjUuxc1AbD6V/XcvGnjVM7bPFUCXLOWPy+UKyrujvV333TKwdPyHH/beMCyIeidvFCwLCaO58tD8voS4dfSSJ5xPblGT1ioRhuqLSAjj6mLtSAqH32XkvS1XSv4VClHCquKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065497; c=relaxed/simple;
	bh=58DEbk5drxj0NcuOeFImHHQJrwafCL9DYO3fK0zTvV8=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Tr14F3xQTq13OJwgQgumtGWf3sU3HAbYY/C7MqGYYuC0tMriqp12EJeKN7Z68zADxGjUmyL1EibJZa/1su7RaJpjV56JgDRbgaIPGJoxTbDyzg8nYfKUsKM8cg0Nk8HRQ7J8VjpbsP3frPATD6LgHE/V1xy5wiZPvxJagZPmf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b=KErGz9Ps; dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b=3vGQVeMI; arc=none smtp.client-ip=188.245.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b="KErGz9Ps";
	dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b="3vGQVeMI"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1792065475; bh=58DEbk5drxj0NcuOeFImHHQ
	JrwafCL9DYO3fK0zTvV8=; b=KErGz9PsIcvV5dQQqQZOyOfP5BrCKfLC7Tc+7p7InfnOcK24m5
	zRvn0TezAxWKvqlt6wKFBEUkUA8/75C628DA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1792065475; bh=58DEbk5drxj0NcuOeFImHHQ
	JrwafCL9DYO3fK0zTvV8=; b=3vGQVeMIPuAYQ3EfsHsgCYCW7PruQfTqndQ5SbF+PCAbcEeODl
	ZuQr5eVqic2a7guA12cNORzU6jbSNUXyY2i/LNINjyb3b/FXyHNAuy8G6R7pYiy7CoIg5p4ga+i
	xmpOWPIZgp0rJhya6FrSIUOL0PRAsrehhi46+HK/iEQwv33SibTAcP5adVRhGgtk0fB3ewsl0M0
	8n5aKntbLHhGcrRdAlfnXHOKbHyec7Jx8n1Nb/A7gWQ2p8sHdhHvkOXB/Mr9AuUohpGgrNkiDTw
	lJH4YEhO2XBFs0153J5eQS5RmiyO+qk9aM+jb3MuSsFcEmT/4+zjkpYxJ3+IYxRO1ew==;
From: "Richard Weinberger" <richard@nod.at>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "Richard Weinberger"
 <richard.weinberger@gmail.com>, "Philippe Gerum" <rpm@xenomai.org>
Cc: "Xenomai" <xenomai@lists.linux.dev>, "Florian Bezdeka"
 <florian.bezdeka@siemens.com>, "guangfeng.wang" <guang_feng_wang@163.com>
Subject: AW: Call today
Message-ID: <mv9hiiqb.0db2987e-79ae-464a-9a97-05c97d029f46@nod.at>
In-Reply-To: <9f598cf9-5a8e-4f3e-84ae-5e1ca7bb66de@siemens.com>
References: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
 <CAFLxGvxKcWEvwOBnTOX9VQ2wQiUsML7r267zRMD_ixL3EyUCdA@mail.gmail.com>
 <9f598cf9-5a8e-4f3e-84ae-5e1ca7bb66de@siemens.com>
Date: Thu, 15 Oct 2026 11:57:55 +0000
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Wed, Oct 14, 2026, 11:51 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> > I was about to ask whether somebody has (long term) latency plots
> > for i.MX8M mini SoCs.
> >=20
>=20
> We do not have one in CI lab, but Philippe has/had one in scope for
> Xenomai 4 and may have related numbers from his lab.

Would be good to have some solid numbers.
On my i.mx8mm board I see latencies around 45us.
What worries me a bit, copying memory on a different CPU in
a Linux task significantly increases the latency up to 100us.

Thanks,
//richard
