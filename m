Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDB33D9
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 14:32:18 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023042714321529b4e5bb996ce1c71f
        for <xenomai@lists.linux.dev>;
        Thu, 27 Apr 2023 16:32:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NHxcrCPbURxGze4gbHFTUWy/TDM7bc+Y3qNMnM92Zn8=;
 b=GvAYFzc9GQtrtay9VTZ0JNpMtbWWq5L43GSuW/Kzyj0OwHcOc/acbgPwpq2vA2MPJhpvhw
 sgWxEvdLiXy7vLmHiMhzkZK/yrUvY6uvugF4Vg2fqXgzXroc+PE+Y/zFQp/dFGbm+A++cIWm
 eKssTUEifFF7m/B7P/J4ST0sSHU0U=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 27 Apr 2023 16:32:10 +0200
Subject: [PATCH 1/2] lib/boilerplate: Do not remove
 $(DESTDIR)$(libdir)/xenomai on uninstall
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-florian-debianization-extract-testsuite-v1-1-0a957cde7b74@siemens.com>
References: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
In-Reply-To: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

$(DESTDIR)$(libdir)/xenomai normally looks like this:

  -rw-r--r--  1 root root 11184 Nov 20  2013 bootstrap.o
  -rw-r--r--  1 root root  9416 Nov 20  2013 bootstrap-pic.o
  drwxr-xr-x  2 root root  4096 Mar 24 19:37 testsuite

We have two files (matching bootstrap*.o) and the testsuite directory
which holds the smokey testsuite. When running "make uninstall" inside
the lib/boilerplate directory the test suite was removed as well.
Limiting the uninstall target to what has been installed during
"make install" fixes this problem.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/boilerplate/init/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/boilerplate/init/Makefile.am b/lib/boilerplate/init/Makefile.am
index b78dd61d1..648168875 100644
--- a/lib/boilerplate/init/Makefile.am
+++ b/lib/boilerplate/init/Makefile.am
@@ -29,4 +29,4 @@ install-data-local:
 	$(INSTALL_DATA) $(call get_pic_object) $(DESTDIR)$(libdir)/xenomai/bootstrap-pic.o || true
 
 uninstall-local:
-	$(RM) -r $(DESTDIR)$(libdir)/xenomai
+	$(RM) $(DESTDIR)$(libdir)/xenomai/bootstrap*.o

-- 
2.39.2

