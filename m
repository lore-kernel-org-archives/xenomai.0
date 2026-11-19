Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117361;
	b=W2+fsdQken/74WqFxB+cPt7jnC1PPvWJ4eUbn+s0m5WbcV760pdvsrK2oZxBCbmZd0FM
	 uOYrG9LR2Wj2+sZQbaVnfJSObArK0ZFqufdDmqVAd+aVY7eBvhRSYIlGTyecFsCHCC36m
	 oyT42Lbtze8CKXEQgOlQX9PdrGReWX6mH46BUTaTw26srk4qtTvQY6vMt4haIAj/y9f7C
	 JZCBVf9mVtC6kprv15XshLah2x1AcpSk2UxH/a5TY023saVe5bUpEUkvSFbjNa3AdgoYK
	 flq2zl1K+yjkUp4wJNg7fu11SgkTR/WeiqntC2QkL891m1ISZaulFIbjZSqOLuYc9sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117361;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=vDKxsqIQqJwkddochK4AO8E7U9bjw32p8v4F++w3peg=;
	b=s88OCmWYlM+8dTuiFPIFfWo31Y0HzSUWdz4RNsc3b8jLzntv10WknF0qmB+I1OY2TFw0
	 RB7LApYJyMY/IlI/UtovbLQOqXX41Q9xnRoPtV0YASOiJtBU+DPEFSqjq0xJ/eXrsVWUn
	 6iMRnnAvZZtsAx92Pe5yiSmW9SWocP/bwVrVei/fNc0OpCmMkaKvdNzXMLVY3KcxBtYWI
	 zqCZQYdobyaDoaT7jks44QWAYY3q4MPxdJQYM79hIqgmYv34I7+qy4GgSpmcTeafU00j4
	 fKWrte/Bw9twV3L6jYMYgJPIPaDUFcGZoIHDrpcBNVN4Ysbgfr29FuPQnmtjDr8gO3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b="IqU/PyGZ";
	arc=none smtp.remote-ip=185.136.65.227
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117D606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 19:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A117D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=IqU/PyGZ
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261119194236853ac4a8c700020718
        for <xenomai@lists.linux.dev>;
        Thu, 19 Nov 2026 20:42:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vDKxsqIQqJwkddochK4AO8E7U9bjw32p8v4F++w3peg=;
 b=IqU/PyGZfQcyRiR+uD53x9wDVGB5sTca4E6BVsYowqfqXDD5B2RsHXPMXA4ub9A1KKKXmX
 9ZuxbWHICj4NfSZPVuCPXPRdyixfhOkh6z9VheuNcsh+tO+LNOoGJ4e0u5kzzvRY0uhYk5xJ
 PsFAN4eVs3Sx1EYMK3zKmO+KAFnsGUCxwtm8BrBkc80LQGDmhlAZ560uqnzaIiTXR9UQIC3Q
 naNkrLulH0RecTw3xXkEqo2Tv0l07RO+OGd5MkC1lEtWtVuwPiqPpSEw075EZkZFcEAnuDI/
 p6QftjRlImo+xSEHAmwCkpn8xxec+ChL2wxahI0hxmquinkW1AGkqVqA==;
Message-ID: <951a56b5307da18a8326bc07e84a6faf3c109c93.camel@siemens.com>
Subject: Dovtail: Question regarding stop_machine
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Thu, 19 Nov 2026 20:42:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

while cleaning up my todo list I came along the following thread:

https://lore.kernel.org/xenomai/1207-6aed9780-55-3e404bc0@80379430/T/#t

Seems that you handled that with=C2=A0

5c39a0e4f186 ("stop_machine: irq_pipeline: preserve hard irq state in local=
 stop context")

already (which sneaked in within the last days).

Meanwhile, I would have migrated to local_irq_{save,restore}_full(),
mainly because we touch the code already and it saves us one long at the
stack.

That should also work, no?

Best regards,
Florian

