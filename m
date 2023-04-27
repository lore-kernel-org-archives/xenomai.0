Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3396FA5
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 14:32:21 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230427143215ec8616e22f0868cf03
        for <xenomai@lists.linux.dev>;
        Thu, 27 Apr 2023 16:32:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DwQM9ssnE7eOh5jmHXAY1GIAw4TiHmf+oOfB1plnjNo=;
 b=Qxh/hNwfVWsxzQBpn5msNAbGU5E/VlFvO+uNNaDMbm2nmrk3rv/27xAyiQOztlHj5UnIaJ
 XCLMDzwlbCEPAgGRsP46hcnT2hrqiLnvokxLTpOz9n5YTU2zBP3aD50dEXKKo8C5DVgMufC/
 Sps+itxR1scxgZ1emVOGr5OCsnlJw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 27 Apr 2023 16:32:11 +0200
Subject: [PATCH 2/2] debian: Extract xenomai tests into separate package
 (xenomai-testsuite)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-florian-debianization-extract-testsuite-v1-2-0a957cde7b74@siemens.com>
References: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
In-Reply-To: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Previously the test suite was part of the xenomai-runtime package which
was missing some dependencies like gdb for optimization reasons.
Pulling in development stuff like gdb was no option for production
systems.

Moving the testsuite into a separate package allows us to model all the
necessary dependencies correctly. Even adding "gdb" to the dependency
list is now possible because the testsuite (with all the dev
dependencies) is normally not installed on production systems.

/usr/lib/xenomai/bootstrap*.o is moved from the runtime package into
the libxenomai-dev package.

We have three packages providing /usr/bin stuff now. Listing all the
binaries inside the .install files allows cleaning up hacks from
debian/rules.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 debian/control                   | 18 +++++++++++++++---
 debian/libxenomai-dev.install    |  1 +
 debian/rules                     |  2 --
 debian/xenomai-runtime.install   |  8 ++++++--
 debian/xenomai-testsuite.install |  2 ++
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/debian/control b/debian/control
index 857d8ff8f..9855de198 100644
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel armhf arm64 i386
-Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
+Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
@@ -20,8 +20,7 @@ Description: Xenomai runtime utilities
  environment. Xenomai provides its own API and emulation layers ("skins") to
  make migration from other RTOS easier. Examples are: pSOS+, VxWorks, POSIX.
  .
- This package contains the runtime programs and the testsuite for the Xenomai
- realtime system.
+ This package contains the runtime programs for the Xenomai realtime system.
 
 Package: xenomai-kernel-source
 Section: kernel
@@ -75,3 +74,16 @@ Description: Headers and static libs for Xenomai
  .
  This package contains development files (header files), the static libraries
  and scripts used to compile realtime applications.
+
+Package: xenomai-testsuite
+Section: devel
+Architecture: amd64 arm armeb armel armhf arm64 i386
+Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
+Description: Xenomai testsuite
+ Xenomai is a real-time development framework cooperating with the Linux
+ kernel in order to provide a pervasive, interface-agnostic, hard real-time
+ support to user-space applications, seamlessly integrated into the GNU/Linux
+ environment. Xenomai provides its own API and emulation layers ("skins") to
+ make migration from other RTOS easier. Examples are: pSOS+, VxWorks, POSIX.
+ .
+ This package contains the testsuite for the Xenomai realtime system.
diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.install
index a8e6b4e33..b57231585 100644
--- a/debian/libxenomai-dev.install
+++ b/debian/libxenomai-dev.install
@@ -6,3 +6,4 @@ usr/lib/*.so
 usr/lib/modechk.wrappers
 usr/lib/cobalt.wrappers
 usr/lib/dynlist.ld
+usr/lib/xenomai/bootstrap*.o
diff --git a/debian/rules b/debian/rules
index 600947346..7664bf21c 100755
--- a/debian/rules
+++ b/debian/rules
@@ -72,8 +72,6 @@ install: build
 	for f in $(CURDIR)/kernel/cobalt/udev/*.rules ; do \
 	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 	done
-	# xeno-config should be only in libxenomai-dev
-	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	install -m 644 debian/libxenomai1.modprobe $(CURDIR)/debian/libxenomai1/etc/modprobe.d/xenomai.conf
 	# remove empty directory
 	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
diff --git a/debian/xenomai-runtime.install b/debian/xenomai-runtime.install
index 372b0e402..77a4c445a 100644
--- a/debian/xenomai-runtime.install
+++ b/debian/xenomai-runtime.install
@@ -1,3 +1,7 @@
-usr/bin
+usr/bin/cmd_*
+usr/bin/insn_*
+usr/bin/rtcan*
+usr/bin/wf_generate
+usr/bin/wrap-link.sh
+usr/bin/xeno
 usr/sbin
-usr/lib/xenomai
diff --git a/debian/xenomai-testsuite.install b/debian/xenomai-testsuite.install
new file mode 100644
index 000000000..167188d11
--- /dev/null
+++ b/debian/xenomai-testsuite.install
@@ -0,0 +1,2 @@
+usr/bin/xeno-test
+usr/lib/xenomai/testsuite
\ No newline at end of file

-- 
2.39.2

