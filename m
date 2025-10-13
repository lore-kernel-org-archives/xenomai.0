Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F01299952
	for <xenomai@lists.linux.dev>; Mon, 13 Oct 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375474; cv=none; b=UFnaOKkBZ914QDszVn/s+65pzmmv4btNmSozblOzIAgTLdKkWdWn7FiB4AHnJGd5i7hJHf9jLOMMaVwRiRGYsiMRHvVcqizRJvz7wkrgmSBsLrZgruYu/Wx4oBClbUkhQENUTBndlGdx8gVoPTe/LiJ6/xQYU8Wmlgq3TUQecLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375474; c=relaxed/simple;
	bh=lno6U57wW/RdEmIRzHs7+Kmqro0HX+jTgrt8arsWgS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maC0aldM72USShSxCu+LGdIYEjGi6/JXgMtK5NPbBAy3XdY0dk8Ya9HM34x4zUC28tcsZba9G5PVRMrgAUgrwjG/oNZdUnNFBPp6xOYY7afnMFJU0pmWuUZspQ7ROTUK5McA4lBWu5ocsYKTpbbAafYfsj9Bz/z0/XgVVfnRMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=H5TU3g+7; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="H5TU3g+7"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251013170100a0622172a8000207f6
        for <xenomai@lists.linux.dev>;
        Mon, 13 Oct 2025 19:01:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=B+99sR89LaXAi8+vfJ06rIWlkGmmYdAYaNMRvCWqEnQ=;
 b=H5TU3g+74P912e4snWMSYmBe7pIMK5prQHE9zR7lgh4jCbsYmlbvNMciGhoMmFbk89GPD6
 rHln6FDjutu1JR64jDizMKZ2Zr5IJcODvG1n1c5bQXPtpz0OX77TRHxsY81YcCKAbM1UkK6V
 gX3vYQX/5RwAHJXrWhowE8YHIA2Pa+iwIJplT6vh89w7pSZYwQQ6vefuaBEc5ytqGYhuddGO
 Y9wmieQKAbw69qu/u46Jr99zQoYv/Z6U5yIlTsHvjIvDSe00iv+Qn6G1k8zICwB3HjQ0ffPw
 aty8M0RoGKM1Tg/NWXhEc08l/yiflzvpcSrFUsJi4Wnhg+0xbyRKdvcg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 1/6] testsuite/switchtest: Avoid including arch-specific syscall header
Date: Mon, 13 Oct 2025 19:00:55 +0200
Message-ID: <8e7aeb4b292dd03d0da30929935766f751356811.1760374860.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
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

We only need the generic one, and the arch-specific one will soon
require non-thumb mode from its users.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/switchtest/switchtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 434004450a..a2ff42dcfd 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -37,8 +37,8 @@
 #include <getopt.h>
 #include <asm/unistd.h>
 #include <asm/xenomai/features.h>
-#include <asm/xenomai/syscall.h>
 #include <asm/xenomai/uapi/fptest.h>
+#include <cobalt/uapi/asm-generic/syscall.h>
 #include <cobalt/trace.h>
 #include <rtdm/testing.h>
 #include <sys/cobalt.h>
-- 
2.51.0

