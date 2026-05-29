Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81392FB632
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046486; cv=none; b=KTuBlSk7A4d6i5krc5nHFHSl8q3464J+DkHOt10BT/DSfAiLwkATIk/bxHgYxF2+ioDuXyv7JUe6EB0b/eDQxSuQcw67X8zqeyonD48Yyx0eJLJT3hOCGygXI7i/CujBu6jRutlBDQpqWamnyvG2Py1wznFFkAhpi/esaoA+7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046486; c=relaxed/simple;
	bh=wyffSkzk0LIBnvPeOx67obTJRrShUnyXCtfqTgcbYGs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WtchRGZkLdNktFG7xhl0sjXpBy1RRSpqbdEH/KX1yu9GRr1w+Ssn0jY0GqQ0b3ERRCP4Gp1RI9/FeNQy06P1+buXsikkhfukLhb+Z7govCGZ8j1HvG8XM5mSCb4DP7jLrKkpTgNMGN7ssS/qQMP/9K1LUmRJ5p5AuS/ZXGdGpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FXRX8Ym8; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FXRX8Ym8"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202605290921132775a4886e000207b4
        for <xenomai@lists.linux.dev>;
        Fri, 29 May 2026 11:21:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wyffSkzk0LIBnvPeOx67obTJRrShUnyXCtfqTgcbYGs=;
 b=FXRX8Ym84ZCMNpDFeVJAInKK3D89KSS0mLialt+V6TkuQLNCyBNAEyEU+O+fyXgsvXpFh1
 jRgq1Mkacv1zNJsAWnEHlro5x4XCZfmsl54dWS/6t+iknWlsNsGyuNNcE8NKksNMuuBIUNB3
 cdwhcPCPWZvdunimi6xrLVr0DdVqnwjeIkh6pjuab8ecPo4mbtoUlVZK9XZ56vZkasqNYdPr
 TXHaDmOLX6XhsrXYWKAQXPdMQnhXPVY58xhEsb233ZjYqqPrPD7ttskvAE2X2zmrj5MyD9nn
 kJGJirETXXEmAiG4JZ7v2PXJFuigE0nS6/t6MXRdtY8vnDbAkO3wGFBg==;
Message-ID: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
Subject: Dovetail on risc-v: Testing strategy, managing efforts for forward
 porting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 29 May 2026 11:21:12 +0200
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

I'm currently waiting for a v8 of Tobias' risc-v implementation. A
couple of minor things still need fixing, but overall I would say that
we are looking good - ready for merging - assuming that currently
running tests are successful.

From my point of view there is one issue left, that needs a discussion:
Testing and forward porting in the future.

Up to now I was able to test all architectures using cobalt / x3. That
will change now, as we don't have risc-v support in x3.

I see the following options:

1: Additionally forward port linux-evl in the future, so that we can run
tests against risc-v using x4. Additional effort for me, especially
because we don't have an in-house user for that. Can you estimate how
much time it takes you to forward port linux-evl in comparison to linux-
dovetail?

2: Add risc-v support to x3 as well. To my understanding there were no
plans yet, but it might be worth it to limit forward porting efforts. I
could focus on x3 for testing. This might also help to compare risc-v
against the other architectures.

3: Ignore risc-v during forward porting. Yes, this option exists, but I
don't consider it as a real / valid option.

4: Merge the risc-v support into linux-evl. That would make risc-v
support exclusive to evl, where we could already test it. Would that be
an valid option for the evl side?

Any additional option available, that I missed?

Best regards,
Florian
