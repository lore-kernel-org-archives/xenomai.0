Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD6A51
	for <xenomai@lists.linux.dev>; Mon, 27 Mar 2023 10:55:54 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230327105546fca613aea2fd835f21
        for <xenomai@lists.linux.dev>;
        Mon, 27 Mar 2023 12:55:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=noykLBM8BQzTdQP69o/0dHXlACeS4lIDtn35Gxm6tzk=;
 b=gWXHEkLn0WiRXu0w2Mv8wEeH8590KEeUmFj/J2HrAQCpxQRL6dAjYVnjJXk06xSzg5Un78
 wIfAWFk6aMZIvZBrg/8FD71oQsmTp9R4Gq6Pjc6b1CXZ02W/ETw/7AR+mTnWhR6gWiUqe7KB
 HxpDuIWA7pz03fHD3Dl0ib6bJ9i8k=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] debian/control: Fix missing dependency to gdb
Date: Mon, 27 Mar 2023 12:55:42 +0200
Message-Id: <20230327105542.1320510-1-florian.bezdeka@siemens.com>
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

Backports to all the stable branches will follow.


 debian/control | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index 857d8ff8f..aba59949c 100644
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel armhf arm64 i386
-Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
+Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
 Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
-- 
2.39.2

