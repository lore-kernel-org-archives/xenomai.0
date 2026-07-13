Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2B14F70
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926436; cv=none; b=SWFbX6uhR5MqgnmtCluxN/Si5ZxOyzkSPZBe5o+PeThfgfRU6GdJRJQkVC/GF/9cFZVHUdFmVtVm83YA2siKWMuXP5nxLAXnSz9Otap1MnDvPyUAm1FcN83kuwcuRQr8rCKkJDhtcDNvgMvJqpK2SHchiDI5M2YYhBoNkAHPq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926436; c=relaxed/simple;
	bh=FIUuV1uU31uFU6SXtVhBWd2LbsDrCH4HiXp/0KqCF00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0nYc19p+FrJxGd03mjKMKiYD86ZX7Patqtn942Kk+SQ57gOmWMe4LqUBGCSegQNJKNuJjW/ljcORoM4afUkd741pfcR2XRnvGOn9KHjgiRAimV904TbnzyOagp/6sGwnh8pTqyP6aF3HDspnMnSHi/YslMO5ERICNG93eq+zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LzNnHhPs; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LzNnHhPs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FDD33EDB9;
	Mon, 13 Jul 2026 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783926433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqn8wvqVepJlh+BY8MojusekrTLLlB8NzQKR6gbhCqU=;
	b=LzNnHhPsk6v4Gsxf7QMw+eZEw3mItfVyqNi+MghefWd/YxvQXuZ3eOE0XaHtT0QGx39gtV
	xvwD6suPdhybAgROn5q2elPSjArHz/uuQoAWKuC7WgP1UtgbsNOr/WqfnOARWed2QY5Q6C
	ixEuPfDKpQkHI1x99xX7RzMT6dQXY/fQiLwhXA0FzQPW0eTwA8WdKdfLEahjmV1Mye/Fz+
	QUY+0w0wfm/CzMfT7+vIu2WvRonQ5l9Ym42qcB8TX+PFGUIdTO/HszWCaQBqkNLJgN9YW3
	lOTp4WmvHVL8T+CIr7CPKpsXUPtFoM3+oPSDo2uF7hs2mDjy9nxDerhmLaTm1g==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v1 1/1] lib/arch: riscv: add vDSO-related definitions
Date: Mon, 13 Jul 2026 09:05:18 +0200
Message-ID: <20260713070639.60268-2-rpm@xenomai.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713070639.60268-1-rpm@xenomai.org>
References: <20260713070639.60268-1-rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEN6kSZh0fidi1fSmncLoyx7PWvYzrendgLLS7uu38s/53+XJepOoy26nxeDSI/ei4pRLSsMpiKi1wlvRx928EfbRPOeBIFfojG4H5WBk9fGFqzC92SskBHxqraD2V7xgk3DIMnGm9Ja+dj3XQxMtXCHv29cQPOO9h1J1vXo0DNVqKkAxmbQSZa55PwsQr+DyqdJCxrWWRf9aRfhqBkh8wKLjYG70wDT8eGxseQ1KUsmH6IjAusUQKAsxyUOiRazGM0n+PUyXSph0EB6aaeUoWTwEwb56pLe+im6uIbznGrIV1gf5LcqS+BjynUMCnTATwzAZcI5KPrm/Gzc9EdyjTDGKgVyDxNrYUvV/AR2HKATo/n6mqmxC786hamZxPi3mC0YCEmgrcM9kdwPlRnXGahFwykadY3bUkfpeJAHVw81C+blgngW3afC0nORRuA0m80g+ad11nHcPze159s38DnykBfivwh+UWpFFvChgXkzKEgMnv8I6t7hIQkbQq3zU6j+nGNlzq6z+7aGbx7ir50DRf7Tpkyh/1FWRDVnt+t0/ch+KxPDQ0I8ozZjpHhq1BZByh/pgBKevVDOPoBWcFznJ3mrG3LgK9K7Qcgv7gSj4a2ChZQjOsCNiRbEa5WV0N3lNyJG0293qqEwxA6idfQXZ3baqjxjXXIRcXuCctnXA
X-GND-State: clean
X-GND-Score: -100

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h

diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/include/asm/evl/vdso.h
new file mode 100644
index 0000000..0cd23b7
--- /dev/null
+++ b/lib/arch/riscv/include/asm/evl/vdso.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (C) 2026 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _LIB_EVL_RISCV_VDSO_H
+#define _LIB_EVL_RISCV_VDSO_H
+
+#define __EVL_VDSO_KVERSION	"LINUX_4.15"
+
+#define __EVL_VDSO_GETTIME	"__vdso_clock_gettime"
+
+#endif /* !_LIB_EVL_RISCV_VDSO_H */
-- 
2.55.0

