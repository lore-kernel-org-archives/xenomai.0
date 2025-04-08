Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB191E3DD3
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117737; cv=none; b=YfxWsytUZ2Qz37VYz4OX2huhJMZYoMwXIDY6+xFZKrEnxvGmfeOLEDKgfAIbLU+nvBxQ47mN/+Mra6F3JMEScnPQk+Wbm8/G1X5oANSL7GX09614TGvfYDqal8B79sMLWo/pvJsrLjWh5eSeSmrp/lY/L1t+cq27APKTBlQ/170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117737; c=relaxed/simple;
	bh=UT/p38GqXxbUIdz8BmWaHgVIS1ZFgNFRVZlCgIYbl4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=uCIIG6nsQ6FahgPiOvhXJJPL1Vfo7jdr/CBzOvF1DhFWoJPA18YBl908q4Fl3UF7V4pivh1dBjLN77w3pz53iUXdlpUk3MFOAMVrhQ/hq7940mUMwl3lKa7GhyuBLflOKuQiH3c2oGTyl41uciFjcsLRIJWrtN4ve+St71DJbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZDv4PZ7r; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZDv4PZ7r"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250408072821bfa13d893e9fd0d4aa
        for <xenomai@lists.linux.dev>;
        Tue, 08 Apr 2025 09:28:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UT/p38GqXxbUIdz8BmWaHgVIS1ZFgNFRVZlCgIYbl4Y=;
 b=ZDv4PZ7rzoNpesz/MFHlKVJRyxise4znbrP+i8+yIRyH0dwVpUkKHPdS/BHtAK2uhYH8id
 DF8FEHzyBlQYq7JpLAoNnrw9gNXI1290HC4+5S2BY9dtAqbESfs8PnCsAYmtcz7ARNkQMzXS
 Yn7KKxg6yHRifZiTOzIBcQVu9naikIaUKMKVZgI4ZJkFTysver5os5aqkSvJ+IUmqSA2dgiE
 9ao9SVgo+tgcdDPGGV1isikfMMvgI31oNA51yy56M6DQcKraXM6Nja3nTQ4S6i3CU5tnDf07
 wZi3elRBVuX1hn7m97J+c/KrQLB32F9HXNJCo5KgHXwD68b8EleqY3Ww==;
Message-ID: <ae4fe2866435af0989e88ad413b74a8f04c9ab30.camel@siemens.com>
Subject: Dovetail forward port to 6.15-rc1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 08 Apr 2025 09:28:13 +0200
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

Hi Philippe,

there is a "bigger" change in 6.15-rc1 affecting the vDSO
implementation for Dovetail on arm. See upstream commit [1]

31e9fa2ba9ad ("arm: vdso: Switch to generic storage implementation")

It basically removes the infrastructure that we build on in [2]

322f6fb3a5e0 ("ARM: vDSO: export user-visible MMIO clocksources ")

That means we have to rewrite the vDSO interface for arm, right?
Any other/better idea?

Best regards,
Florian

[1] https://github.com/torvalds/linux/commit/31e9fa2ba9ad64ef09eb4a8326e5cc=
8af3f6fa1d
[2] https://source.denx.de/Xenomai/linux-dovetail/-/commit/322f6fb3a5e00

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
