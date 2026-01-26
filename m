Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5E2DECA0
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444101; cv=none; b=G53lPIyIZM1wykzFcmUowNzyuCRzUrvNNccOZuaR8i5SVQgH3VWtgYo4AvNNo313PVAw8eKZF8Zo26FvceBBygBXX17gaMGTEOIzcEIxVvTGJmNEByzy+xzaHKXJRQBM46RIcO27feI0LadJoDTfvK72hoP5KoPvmRGaVgG0QfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444101; c=relaxed/simple;
	bh=JX9G+0rEfHGBWGrtvyNZv0cb4O3BdiAYzCtoDy1LFKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q49Pl0dpYDtLR+KrUFGBR4ONwskhZXTW24CZ5Ewng2JQ4W92/4IF5qDyzmo0jPSiWHkGJO/Fl5b8h1FW+lc+q9WxYkoGB9J6zAv3btHpg07JMp1fqmooxJ+ByEIseZtMuBOw9KDdRoc/staWB28POAlgO0FjNCOaA7UlwEHLIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Gc1oDrqp; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Gc1oDrqp"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260126161454e030965296000207b2
        for <xenomai@lists.linux.dev>;
        Mon, 26 Jan 2026 17:14:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mbX47rS4h2brF1qJNvKaEe5V6th2pxyNLlvsSp3RcpI=;
 b=Gc1oDrqpABoXwuv+KvfwfQxU8LSyw5iwbwKepObNstOpmweShbltqFRdymixCyKS++LyZf
 EVMT6apyI6eUfwpMBKUXfCUDke2dHgeZhS/YnJwlHiX5Ot3UaV9YVC5l8mrwxYnz9FrgPsxv
 5eMuIYUUVpugWcJh0J8ryPIOlAqTSvB8YYfmNFEU6CkCMYPRQ7ezC6a7QHni4kF2lx42T1lT
 IoW3yPmaOP5Hwk64FUKiPiYOX4FbCm/8eea3NY/PnVd3Ep5AyX6rU0mw41o6vKq9qP567ao1
 0hGkUi8e6CZ1cWlrVBLUIvRMdOGTdfXhAN1Ee8C840FOPrUZOBBAvDBw==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Add CI support for dovetail head
Date: Mon, 26 Jan 2026 17:14:42 +0100
Message-ID: <20260126161445.349483-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi,

this adds the functionality that pushes to the dovetail head branch
trigger xenomai-images CI builds using LATEST_GIT_BRANCH="latest" and
xenomai/next.

This was tested for the dovetail branches:
- v6.18.y-dovetail-rebase (current head)
- v6.17-dovetail-rebase (no pipeline triggered)
- v6.12.y-dovetail-rebase

Best regards,
Clara

Clara Kowalsky (3):
  ci(dovetail): Put rules into workflow section
  ci(xenomai-images): Add build job for dovetail head
  ci(dovetail): Trigger xenomai-images CI for dovetail head

 ci/ci-dovetail.yml        | 22 +++++++++---
 ci/dovetail_xenomai_3.yml |  5 ++-
 ci/kernel_head.yml        | 70 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)
 create mode 100644 ci/kernel_head.yml

-- 
2.52.0

