Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9A2236F0
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926436; cv=none; b=IC+e4bTwfAofZZSZB5U4+DEBnE+c8W3OMDYcavY0Xk3oVYNPKXYcQf6kPQc3ig++we30iXrLWirxjDU+HPDbbX0vB0g2fhypedJdqGBwi2ATooAbAEbz75/G+RJkD0p3hC153NfFGXzVz/ppswVl/IIjPt9BiEXbZbTLPivRHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926436; c=relaxed/simple;
	bh=kGX8U92PlEIr7mf966Zmjjt90nIRlJzAeMHvhCPNAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9JCGpC8lWoeuMoQU9fanzqMN/C0W5k+LbF5gERvnDe6OPEH0Xb7iRSEMdz+pTuyk/aGu//ByJ6r/Vg+7dnibLEWPEvev4nIwI/3coP9VQSahBotc2/nr9XzbnHdAqeQtISBxUL/yHrxkMDns4bLaZCn99BnL0/5kHApn2l8KpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=gIDzi5Uf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="gIDzi5Uf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBA6E3EDAD;
	Mon, 13 Jul 2026 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783926433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gYj0IYAfDX6eqlMqalEo5lINJti8AsX7Nd9T6kAFo40=;
	b=gIDzi5UfxjMvwXWBXuolkuqvoXut8JAXXtTsSuPaIDbBl654KkJvn8+8+AQV4lAKR+Uqjn
	cCOSOOdiygv5dXtkaWTV0Pm1o5v4YLxa1WErl6JXvgxzuh/yApLhYLNA0zF4IpCR60ZcIQ
	8rN3xWz5fIzVuRW53+DTmzWiM0TUoh0vekPJQnOsaycpl2ze+4eaTbVwegifsDugvynZhx
	MEGFHtOHAbnDef+sI2qOxXQHlJXnBuj/JgCuVU98qNYGxn3Sc/4QKzXmZytQGlhwMzQFH0
	S66/GqizYI+CkGyk0Xq16eJG9Rn9RnoFA0SrH1ewb0FCCVZPGEul0uVxNBZRsA==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v1 0/1] vDSO-related definitions for RISC-V
Date: Mon, 13 Jul 2026 09:05:17 +0200
Message-ID: <20260713070639.60268-1-rpm@xenomai.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGPLH3oY5FqujRu6hW0nVVceLlMibFpMlmR9WW7/8QIYYcd/AJFj1GyJ1/KsbVRKX8422ytG+agjBAN6XAMNT2Rah4iV7nTB9L4ReXv5AnciNC/C2EC9kvmkQYY2/RQFCFsxQ8/VsGeUkgwRpVb1z1RAV6DyG/sBGpI7tG7f943S2WIqL0pKEKBtwpOtR4LQ9Xkh8MT0Q2BaP138yfq64ZPAGCEuVZWxOblPrwRsgB3YovCeKiKDrpFxo3vNGRklRkLnfUNkN+ZeWURynL25mQ3/yMHmSw1wpjNkSuphaduL+nU06m5/ILBHvvv9YkrFn6lwEFWF2jj0jNJozttzTLaAFsJ845wtPcUDKG6+HTBHMWMKw+U2ogN97ycJqpRhchYv+1qN3Ji/Pw9YMl1X3n5qCyZcqvosjnJ00b2FSQAouJDwKx/JSK5x/U++tQMimpa783epsw966BHZ4g/QvZNEVm+QenP42Rve4W5wSU2ryTA98VE4StEJcLevrXitnSY8z0PxoLetxXpbd3JnmTij3eyQLPnXQbWeS2B6wcVqGzM2D9o4I++3v9cfdG+N8zV4qWM9ptikNKlF5IOciUqGeM0AWgWmWUtwKz86KTUVIrL6HNfK69B3p607pKw5Grxi7oPDyv5z1tC/GSUmtuWHWzoul3nMYBcNBvuW9asAg
X-GND-State: clean
X-GND-Score: -100

From: Philippe Gerum <rpm@xenomai.org>

Philippe Gerum (1):
  lib/arch: riscv: add vDSO-related definitions

 lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h

-- 
2.55.0

