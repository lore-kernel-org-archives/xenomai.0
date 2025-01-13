Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A61CAA94
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772563; cv=none; b=JQNPPtnftfaNKEjw33mPrtI02e+OExuBLKsdt0wuQEcQQUMC7WvDRdyrBfwmKZVr93VU4rZ3+KJbsjjF4cZAjNDrAweYFKfjzTf7+92Pjvf750IjdqtIxsphf5IIOh5MdhSkzkgYxdeXsF5RSg5CR+TcLFFQhzsGaStRlfaZsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772563; c=relaxed/simple;
	bh=DA1StaNfcRilO/tI0zDYukdWZgm0SU9mMNPFaMhi2wQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSN8hJyf10S1fqcU1pQd/kDJUzQueG2zVuxUqlKLYyq8Q++qJX/olrR6UtBJlxqEYEMQDZWuGrZIPWnpgtrMbt9Y5nUf8+Kp4GtrnlYb2MJU/p9TiBE9xE1OswiPagpg/+SR69IgOzKVrTLRlxvgd171coNQeTy3pcd/AQn3neU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LgbRypGs; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LgbRypGs"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202501131249111982d28ea3b1f105f6
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KvXNkt9vRF8A0mhJUBaLWeSMowY7mhxOwr1i+CtWpwM=;
 b=LgbRypGsqUt/riQpw4FJAu0ORWE0wNclC3CdstK6zg9fKlNHTqrdW0KxYLLCIKenW+ABqC
 thYkeQmXhUgRe9OGmiRxNfQbhr1sTsh1qPJeeJhAbKGz60TglylU8u2oeTLMNIKlcQgtdCGQ
 emFm6yow2ux8KBVJdblCGSXE4Gx2anCAJ9kW0kuZxCXOVa4Y8N61bzz0JtMWTG39kA4DmK9a
 /LTiw5Ok+UmVtTzHoim4Djszr0PLAyiNBnow9PXdygQRv4sRNuWHWRbl7SAe/u5tgHcHcHdj
 xYUVmCXMMgEI/UTTOAADFe4IqBJINH4W2PRptRqPlmtroJBC5aRBJvfA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/6] Update kas to 4.6
Date: Mon, 13 Jan 2025 13:49:03 +0100
Message-ID: <18b38e85330612858a52427fe4670e8b99bb608c.1736772548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736772548.git.jan.kiszka@siemens.com>
References: <cover.1736772548.git.jan.kiszka@siemens.com>
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

Just house-keeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml |  4 ++--
 kas-container         | 26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 853d929..aaf0df7 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2024
+# Copyright (c) Siemens AG, 2019 - 2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -30,7 +30,7 @@ variables:
   SSTATE_MAX_AGE: 14d
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:4.5
+  image: ghcr.io/siemens/kas/kas-isar:4.6
 
 .sstate-prepare:
   script:
diff --git a/kas-container b/kas-container
index 6b2131c..0437381 100755
--- a/kas-container
+++ b/kas-container
@@ -27,24 +27,28 @@
 
 set -e
 
-KAS_IMAGE_VERSION_DEFAULT="4.5"
+KAS_IMAGE_VERSION_DEFAULT="4.6"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
 
+# usage [exit_code]
 usage()
 {
+	EXIT_CODE="$1"
 	SELF="${KAS_CONTAINER_SELF_NAME}"
+
 	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
-	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump | lock } [KASOPTIONS] [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
-	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall} [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall } [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
 	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
 	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
 	printf "%b" "    \t\t\tof config to stdout.\n"
+	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
 	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
 	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
 	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
@@ -63,9 +67,7 @@ usage()
 	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
 			"container runtime\n"
 	printf "%b" "\t\t\tfor running the build.\n"
-	printf "%b" "-d\t\t\tPrint debug output (deprecated, use -l debug).\n"
 	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
-	printf "%b" "-v\t\t\tSame as -d (deprecated).\n"
 	printf "%b" "--version\t\tprint program version.\n"
 	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
 	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
@@ -80,10 +82,12 @@ usage()
 		    "\t\t\t(default for build command)\n"
 	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
 		    "\t\t\t(default for shell command)\n"
+	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
 	printf "%b" "\n"
 	printf "%b" "You can force the use of podman over docker using " \
 		    "KAS_CONTAINER_ENGINE=podman.\n"
-	exit 1
+
+	exit "${EXIT_CODE:-1}"
 }
 
 fatal_error(){
@@ -269,11 +273,6 @@ while [ $# -gt 0 ]; do
 		KAS_REPO_MOUNT_OPT="rw"
 		shift 1
 		;;
-	-v | -d)
-		KAS_VERBOSE=1
-		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -d"
-		shift 1
-		;;
 	-l | --log-level)
 		if [ "$2" = "debug" ]; then
 			KAS_VERBOSE=1
@@ -285,6 +284,9 @@ while [ $# -gt 0 ]; do
 		echo "${KAS_CONTAINER_SELF_NAME} $KAS_IMAGE_VERSION_DEFAULT"
 		exit 0
 		;;
+	-h | --help)
+		usage 0
+		;;
 	--*)
 		usage
 		;;
@@ -293,7 +295,7 @@ while [ $# -gt 0 ]; do
 		shift 1
 		break
 		;;
-	shell)
+	shell|lock)
 		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
 		KAS_CMD=$1
 		shift 1
-- 
2.43.0

