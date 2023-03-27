Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82029A51
	for <xenomai@lists.linux.dev>; Mon, 27 Mar 2023 10:56:51 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023032710564354d8d86de25a4016ab
        for <xenomai@lists.linux.dev>;
        Mon, 27 Mar 2023 12:56:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1S4A+icPg4L01L2mzoSStDPdgetp17iUyZF2erJpuBs=;
 b=nnH70J8C8XX1OpMD0YL4lN4hizR10j0MV+284iBaldwsciRWFF0UY/D07gAl/fiWxmf+d8
 fOtvSIMx0c7bDMI9Q0+FT+0vj736Gd7+K5dJnKoABps2+GcDn2NjvfZwuVO+RgiCh6NP8m2x
 +HLPniPGk6NkiR0f0T2vvPQdxCqV0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable/v3.0.x PATCH] debian/control: Fix missing dependency to gdb
Date: Mon, 27 Mar 2023 12:56:41 +0200
Message-Id: <20230327105641.1331666-1-florian.bezdeka@siemens.com>
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
index e6125cb7f..f14b166c3 100644
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
-Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
+Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
 Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
-- 
2.39.2

