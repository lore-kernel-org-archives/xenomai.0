Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768538BBD
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 15:43:05 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202309281532497c528d3a232ba72e4c
        for <xenomai@lists.linux.dev>;
        Thu, 28 Sep 2023 17:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=B0GeoT4pIbZSi1f4p7dB195W7bE6IlvyGA7Q1RPtVEU=;
 b=TNZoLUUd2CLR6O5tIVrXaG3j48kJpeGNygZxBXyWX2kPQmteHmRpg4Qr1O9tU0vr9+0z5c
 lih2llwy9w9lGTRTRyJdNErrslhbae/oEnGXAwIFgAl6WC8E8cL2Yp2Cg1rLBOxiWidB5FNK
 4H0qlwheXLQnbHfUnsInrYu6lk2+A=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/4] start-qemu: Pick up architecture from .config.yaml if left out
Date: Thu, 28 Sep 2023 17:32:47 +0200
Message-Id: <090ef7283e1f1cee87707d4658b21026434799a0.1695915167.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695915167.git.jan.kiszka@siemens.com>
References: <cover.1695915167.git.jan.kiszka@siemens.com>
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

This allows to simply call "./start-qemu.sh" after a menu-based build.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 51f71a2..751d20a 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -12,7 +12,7 @@
 
 usage()
 {
-	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
+	echo "Usage: $0 [ARCHITECTURE [QEMU_OPTIONS]]"
 	echo -e "\nSet QEMU_PATH environment variable to use a locally " \
 		"built QEMU version"
 	exit 1
@@ -22,7 +22,20 @@ if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
 fi
 
-case "$1" in
+if [ -n "$1" ]; then
+	arch="$1"
+	shift 1
+else
+	if grep -s -q "TARGET_QEMU_AMD64: true" .config.yaml; then
+		arch=amd64
+	elif grep -s -q "TARGET_QEMU_ARM64: true" .config.yaml; then
+		arch=arm64
+	elif grep -s -q "TARGET_QEMU_ARM: true" .config.yaml; then
+		arch=arm
+	fi
+fi
+
+case "$arch" in
 	x86|x86_64|amd64)
 		DISTRO_ARCH=amd64
 		QEMU=qemu-system-x86_64
@@ -80,8 +93,6 @@ if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
 fi
 
-shift 1
-
 ${QEMU_PATH}${QEMU} \
 	-drive file=${IMAGE_PREFIX}.ext4,discard=unmap,if=none,id=disk,format=raw \
 	-m 1G -serial mon:stdio -netdev user,id=net \
-- 
2.35.3

