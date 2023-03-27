Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8FA51
	for <xenomai@lists.linux.dev>; Mon, 27 Mar 2023 10:56:41 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202303271056337a26c3d757cefb7efe
        for <xenomai@lists.linux.dev>;
        Mon, 27 Mar 2023 12:56:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=RWdC7CSHGZVvdTfv1RmzOhwTT47EwIO90Z2cDGwLEPs=;
 b=cjjylzQD7hHiE1uLfqTZKCLuRes3rTNMdhal3UMRIw0WiJuMmxeizNqBYwwF0uC6ft37pY
 OUXVtpm5S2n/xlmTOE34DI3JbZfhCVS5dJurATaBre5kPb+xiSMpbFviffl2AAzMjIAYvdtP
 i/Qcblphs53Q1pBqTs4jXMJkaw4Ws=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable/v3.2.x stable/v3.1.x PATCH] debian/control: Fix missing dependency to gdb
Date: Mon, 27 Mar 2023 12:56:31 +0200
Message-Id: <20230327105631.1331549-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The xenomai testusite - part of the xenomai-runtime package - needs the
gdb binary for testing the gdb support. The dependency was missing so
running the testsuite on a fresh Debian system failed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 debian/control | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index 2fda4e961..3ac6e9f8b 100644
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
-Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
+Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
 Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
-- 
2.39.2

