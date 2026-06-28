Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7FD2110E
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782622287; cv=none; b=KuoiksyjNMepnt94O0UYh+QYGsMaLZNBFH6DiJlLdOGISdN79GzMfG2a3Gc3zJIsFxjeDp9m9YgDyWd7LS1MaBcY0O437ZpZ7Obin48o185tpptki+MRMCUpWFS/QLTZrZi4JrQKRXtuQSn7JmN35XYV8BjY798VLoj0TwBcXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782622287; c=relaxed/simple;
	bh=YmJrwKr84ro/lkR/c+/6683l6PRzhHqL3qQ8lbcJyjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntizlI1LeQ2WsMPBImQF91ozW9qGY8sVYxcwQMf6ZNeuFzssAYjHiPDnpwotrAYeKqwrexuOO/LR4bsm+aMv+jr6IxCAtd0yXhN3tvjxfYuDnN0VdD/xPy6HCm8A0RALKojmBhghwNY9syRXhjDAlJdo7ftOWjrUwpURzt2mNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fy+X3iIb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fy+X3iIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BU
	d91mfg8T9DEgEQ68GNf2pEdy5ydNOW1wTbaXxt2lI=; b=Fy+X3iIbaMM8tog6SF
	qarJHD0mGoplgvMG2lmkU8xT2MwaLkdGcbDw/xtuKoQC092hM1ZRJ0Kjc79WMT6K
	tx7ce28mdEx0umLyiUtR08E3WgxjoNgBIy/Hyr7X6za6ybWvHBC5dVMQ4JEa1+LK
	SiInJf100oNHoXlwZlgNsvM6w=
Received: from wang-Xenomai.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXYGc2qEBqjBkzGA--.59914S5;
	Sun, 28 Jun 2026 12:51:16 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	guang feng wang <guang_feng_wang@163.com>
Subject: [PATCH website v1 3/5] doc: mark old PowerPC and ARM build examples as historical
Date: Sun, 28 Jun 2026 12:50:57 +0800
Message-Id: <0894b60dfc629b724142f57eff07d8d01285c3ef.1782585785.git.guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782585785.git.guang_feng_wang@163.com>
References: <cover.1782585785.git.guang_feng_wang@163.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXYGc2qEBqjBkzGA--.59914S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Aw4Dtr4rKw1kWrykKrg_yoW8JFy8pr
	s7Cw4xGF1xWF12kr15AayxCryfG3yxGr1rW3yfAasFyrn8Jr1UtFn0vr9IvFyfJr4xZ3yj
	9F40qryDWa15AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwF4iUUUUU=
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC3QTlX2pAqETzRgAA3Q

From: guang feng wang <guang_feng_wang@163.com>

Some architecture-specific build examples still describe old boards,
toolchains and kernel versions.

Keep these examples as historical references, but make it clear that new
Cobalt setups should follow the current Dovetail-based installation flow.

Signed-off-by: guang feng wang <guang_feng_wang@163.com>
---
 content/installation/_index.md | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/content/installation/_index.md b/content/installation/_index.md
index 265cb5a..4eaafcb 100644
--- a/content/installation/_index.md
+++ b/content/installation/_index.md
@@ -737,6 +737,11 @@ The remaining examples illustrate how to cross-compile Xenomai for
 various architectures. Of course, you would have to install the proper
 cross-compilation toolchain for the target system first.
 
+Some of the architecture-specific examples below are kept as historical
+references for older boards, toolchains and kernel versions. For new
+Cobalt setups, use the current Dovetail-based installation flow and
+adjust the toolchain and configuration to the target platform.
+
 ### Building the PPC32 libraries
 
 A typical cross-compilation setup, in order to build the Cobalt
-- 
2.34.1

