Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05B3B27CC
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771745; cv=none; b=lAJ+pl1flSEWb59wEjEEWi8rsqN5P1gfVbCSLGfbo8E879qO9vRRssqw5lMbPr+7D0LcoIwGR9IjIb4wG2k3HJmOYlNgBLzS37E0iJ60OOjFSxaIBAz+NMLGaH4PXRqJ15cpeWvUk8AQ6Ov3vWlGrudIXw9mo+RzGKSrX8Oh64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771745; c=relaxed/simple;
	bh=Ubw2dnfGlLJpjAp/p3+vttdbx7RsF+hqLez0sdf+9Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LluyrjIEOiD7pduIxGtAxbHeoCQ1jjXW5wGBc9emPOLMAssye6U88D60UC525CDFnGpnAm8s9cNvGXo2rDgEGg4pM97+KGg0VPfKhY9RA9rHLgkAndVde/QPtT6qCVocRDUxIuSXA39GRohc5L2q5GB67xixvmhcUj+v1c4VANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MdeVozf0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MdeVozf0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DF8920CC1;
	Thu, 18 Jun 2026 08:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781771740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uUaEU5nDbyIx2HOMUIuZaUCcHr6xlHZU8cb54kIEXBo=;
	b=MdeVozf0bLwSa5gBPygSV7VEDl8YQKMwTefCu0uYUM/rDiTi02aGaHUjMfws7LaJdXZItL
	5wDXGq9ntHOAT3qLpY9qUuaP+zbHpJiqjEkDq4W0CmU7TyE2B7hoCiTpCZwjz20jTpdoGH
	gvQ2ZchBdZT1qnkXTdAc6z7nEPoUGiar01Ne5N8mqMZ+YKwdWRd5qTjU79LPqSTS0fFxaI
	OcwZp7cEwAW54hcbHpk6gUtbbsAaRD9TRmw54C7sL4aSyHcr8SmtTc5Y93BimXvGcIsnLX
	8ecOggo578DEZOLqT2B1yN+n7X2xmpLoNKu55ppjhBpVaj1UK6XQh6ib2ouYWQ==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v2 0/2] Fix budget tracking on preemption of SCHED_QUOTA thread
Date: Thu, 18 Jun 2026 10:33:22 +0200
Message-ID: <20260618083524.253860-1-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTG4AtQGTYl81uSS/Ddt4BdDb3jTQ+dKANJGTt4DulrQnDGks7vArghC2ouq6adnYFJuUj37mLNXBFoB4DgqsQUEsLpRq2bErrJgT2UAvXAeSHDt3oXoeoYYW1xuyutOkGXS5jmwaC4qfda1PsSSUfz2DA9DYyRgqcgvF9TiMe2E7ZouJH0v4RfjYxz35nt6ryfL3YyJgMo9hnXt9KQCpiAV2c/qLehwYB0d11DLFgOUUdj20MdnOE8YH073QuTgp3P6bIRRJocEGLP45e2MO1dzcaRlLf/30dN2AvmF/hTEPZj1ONhrlNTfF2AhIE52rymNOfgMxjWoBVU6xzOC6AXksOAJsGsSRKVR7OFboxXZyyPxZXWEDmwAXke/qY85dbch6uFNMU3yxAq0AK0syks7k7+Cpnc/wTc3RiHACwTL5qrYjiu0ZNS7lyx2AFbdtgpiLF6pyqU/uRp65ZjUwiF7G7WCTa2rHTlgeURP78rOPnI0BdmpOqe8PVlle5dWH4WI6JemobnxyQXyTb5BRTn4Yk+2FZ0eXYnMm443XPI0Z2MCYjSoupwkhfUAyUOg1QQY0aHqCPRFMNvAyFe54nKHnGbVs5X1fSxPFK4EKKlNJtTZROF2Y3vlUnkuj0BNDTT5zJbr+xsaClVJ1Ueavld8g3Be3stdwS7vZME+aZtTlg

From: Philippe Gerum <rpm@xenomai.org>

Dropped the confusingly cosmetic change in __evl_schedule(), no
functional change since v1.

Philippe Gerum (2):
  evl/sched: core: introduce schedule out handler
  evl/sched: quota: fix budget tracking on preemption

 include/evl/sched.h       |   1 +
 include/evl/sched/quota.h |   1 +
 kernel/evl/sched/core.c   |  12 ++-
 kernel/evl/sched/quota.c  | 201 ++++++++++++++++++--------------------
 4 files changed, 106 insertions(+), 109 deletions(-)

-- 
2.54.0

