Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45818C031
	for <xenomai@lists.linux.dev>; Thu, 11 Sep 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592747; cv=none; b=EM8/0H0EOt49E69IjhFU8y+grjSSPzo4K/h6enajBhTLTcnxIpKH1EyT3Up+sK5/HyuuyI+TmzJtauS8LIZLJ0RGbZQmO9vWPBAKhYWMbuJ8BDOdIDvAx+Q+7b6aFvijOHsPalWwIkdqA6UuHQHo55LwdL5xxDH68OBuEES+ckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592747; c=relaxed/simple;
	bh=yVjqd189pKKEBQn/rNuxn8j/InPH5Mx3tstgldmBwCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bLZDwobXSh53Frwa4fKtPF5FfGlGOx2j0PGwWzAZBJ7GdDQVACemwU5wSXu1yzokt8jdAWHMMcOHdAIzKWmvHdCGGeSGQgu+GM+VtU1qRUwYg2YJ8u6LhoAo771pufMkLHxwgGWA/+DoBrmLsBMEka+qg7OKoKLW5wzGDVP76G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b=lJlKrcx6; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b="lJlKrcx6"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025091112121766c516bbcf0002079a
        for <xenomai@lists.linux.dev>;
        Thu, 11 Sep 2025 14:12:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=DS+03beDl5VuePMVrMPbE3FjVh5NO6BCFhspHd2tnY0=;
 b=lJlKrcx6yr107R7h1V+KkEAzVdXnvmshLLiFdVrPUKTOTVMBPcfYjhX7fJK7FDutBNtuHw
 BCPJPGYYoEbnNLMO9Bw7ZO3OoGyrILA5vAWnTbDqjWNtQ+WNTdcgJ3ByZ+tMYy03xuuAvuSm
 vNfWbgQ6mcuUD+xUPlZUAj814TTAXvnt58m+EPdmlnyLjtEmG6m5SmPI+dv/MdUrcGoywgse
 aNJN5nJULWKaes7FFnYt2Y12eQ1ZCNrzebzdqGQ4IGuCdmex5+Pz3B3nmnxbIGf0ptSo5Q3e
 mGYcVw/zHEVsBP5XCaAdVFjpyfC9Bi8dtToG4sP4ReX4tOHiLSlxgqaQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com
Subject: [xenomai-images][ PATCH] armhf: Enable audit syscalls
Date: Thu, 11 Sep 2025 14:11:25 +0200
Message-ID: <20250911121216.2585340-1-Quirin.Gylstorff@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the following error during the execution of the LAVA
testsuites:
[[0;1;31mFAILED[0m] Failed to start [0;1;39mauditd.ser…e[0m - Security Auditing Service.
See 'systemctl status auditd.service' for details

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/armhf_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index dee6f5e..7f370b9 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -56,8 +56,11 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_CROSS_MEMORY_ATTACH=y
 CONFIG_FHANDLE=y
 # CONFIG_USELIB is not set
-# CONFIG_AUDIT is not set
+CONFIG_AUDIT=y
 CONFIG_HAVE_ARCH_AUDITSYSCALL=y
+CONFIG_AUDITSYSCALL=y
+CONFIG_AUDIT_WATCH=y
+CONFIG_AUDIT_TREE=y
 
 #
 # IRQ subsystem
-- 
2.50.1

