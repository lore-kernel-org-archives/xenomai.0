Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A69364052
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931311; cv=none; b=fqaMt5ZLU/cqo4LCWA83bEIQJhzv70woi0mnIPrjivIIdzpBo0MJson24aeBCK8CwJ2cwYCgFK4ZJ4wGQcw5SRJlsKroQp/HDDhKox9kMFJRyC0gjJbWwgj5jMspoghqKCi676LLZG+z4j5Uo/V11lDcLPLgsIG/zqqXUCJEmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931311; c=relaxed/simple;
	bh=XTmFk/jVMMzfrbwlyOWbM9n7vrBWHB6wvTViH4MYWFE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgB6HELKFFG/bVt0un4bzF1xqv8fK9/dXBU6QtzliznL4fxftUgvQIQiAA0Onth4kFB6SNBdyqn3meEe0VJzsGg3k1yp9iJUvpy29bdcicY+STowSWTxr6upt+HUivqpFApVpOCYZ5asiSGZBa69u6oLezYc/ug8w/SrTWi6q48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=KPOzNcF7; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="KPOzNcF7"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026082815345745858da2570002070b
        for <xenomai@lists.linux.dev>;
        Fri, 28 Aug 2026 17:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=H9M/SFwESEVvYvhRvmMwjHrkEUbPlftwoTlQq+LM8QE=;
 b=KPOzNcF7OxnhkfTqCQ7sUzk52b5fn5lmUxI/pvoaTrTQLnqNwPoOznVZnR0gr7A7sINSz3
 H8UjzkxuATwcrfg8bLEdgcrCApx3SpfPUkzDeJFv5EoYi/G+LoaORVnYz6CpOPZjYY3JlmQv
 hUTgiic+M+HcEawFNCJrRHZu2lGhafb4kCgR3epr3DIDzPMSB1TsRHHGKtLxQMCwlv1GEqS5
 3qaJFypua7NPNcrk63pL2QCDAeIC0N3/x7nsSME1zRgxQgQ76t+QhIo921E0j7hevPYIc3Ri
 KL0+MxgtBnjpDuvNwGAUraQPJ9Eq6LZ23vC7BFMXLE9k+OJEhzkmLEBQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/5] ci: Allow riscv builds to fail
Date: Fri, 28 Aug 2026 17:34:53 +0200
Message-ID: <ee9837cbadd5b4e2b20a0ca2d68f33e6303185f5.1787931296.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787931296.git.jan.kiszka@siemens.com>
References: <cover.1787931296.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Integration is still ongoing, too many loose pieces are flying around.
This may change soon again, but we need to shield us from unfixable CI
failures for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/lib/kernel/head.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
index e5af966..028240b 100644
--- a/ci/lib/kernel/head.yml
+++ b/ci/lib/kernel/head.yml
@@ -54,12 +54,14 @@ build-head:qemu-riscv64:
     LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
     KERNEL_VERSION: "head"
     CACHE_KERNEL: evl
+  allow_failure: true
 
 lava-test-head:qemu-riscv64:
   needs: [ "build-head:qemu-riscv64" ]
   extends: .lava-test:qemu-riscv64
   variables:
     KERNEL_VERSION: "head"
+  allow_failure: true
 
 build-head:starfive-visionfive2:
   extends: .build:starfive-visionfive2
@@ -67,12 +69,14 @@ build-head:starfive-visionfive2:
     LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
     KERNEL_VERSION: "head"
     CACHE_KERNEL: evl
+  allow_failure: true
 
 lava-test-head:starfive-visionfive2:
   needs: [ "build-head:starfive-visionfive2" ]
   extends: .lava-test:starfive-visionfive2
   variables:
     KERNEL_VERSION: "head"
+  allow_failure: true
 
 build-head:rpi4:
   extends: .build:rpi4
-- 
2.47.3

