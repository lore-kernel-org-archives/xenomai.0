Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50382737E1
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163126; cv=none; b=kH6Vv2OaM8RH4vixxq7z8b0uR2iuxivvaSbTjuHkZt698K3nNRap5sHqhdA5EXaJeBBxsjYpLe7cOmKorBoRbSmEDbzV0ej9ufUQNHPgZsbG+/E2gvrBAIr8EVMKf4/pospgtzPKta7+gQ7xt0xq1i7aphVDauGuthuYjLD0w5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163126; c=relaxed/simple;
	bh=70ebjAL82UCO6jYSkLDyUYszespX2JGxTqc4BptrnLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RygS8zuT5HOKPQocGnFzXjXlC9HGeC1436QNnEd3cwVnOS6vAoD4fOhbaRzkEcr3fxI1H+F7Ah6UZ8tLNpsXgmtb22kAW6b0a06DPiGMyom0eptTa8gtDux1bcDpPK11D0Ba5ae1xY2hSAapT9uoI37qyR0GUPjrvmwTp8GBcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=dR9FfbRt; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="dR9FfbRt"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202512191651568f0e67299e0002075c
        for <xenomai@lists.linux.dev>;
        Fri, 19 Dec 2025 17:51:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fPeXoVGVxnVaqiu59wwsgAxyfRYZunIRD2UCLhllpF0=;
 b=dR9FfbRtBwYQPdyQxB1+Hvqd4yhqyt/LJOfTnI8Kl2ffH8+WWn9sRBGd+WDZoHpN724L/l
 B2aJn95zmpbbTIdb383RRDMSHnJ6k8u6aSvQXVvNCxyfeB95EyAIlGXI6Dw9YrJRlGpNS30g
 1koSrTvzhVVOHMrpqaOJyTHArIAQN0Y+wmFTgknzo4ezUnZnbNO1wtHnCnFfNLsXvjYnvOcl
 SC1qhExXxZEpwAkFiJsHkAMpVwuMzqNR8Wt3ElBA2c40WfpVa5cTguvBsUSsLCj+9Zjaa/6Y
 MZkdZsuxgguvwMUWYprKUgwXkjIycJbMzesvTRpP9+2/tcLCkm/4YZPQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/5] Update to kas 5.1
Date: Fri, 19 Dec 2025 17:51:54 +0100
Message-ID: <140ed6fbcf7f222ac4f8de9e2bdf4b5f7c9406f0.1766163114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1766163114.git.jan.kiszka@siemens.com>
References: <cover.1766163114.git.jan.kiszka@siemens.com>
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

Housekeeping. Due to issues in the current trixie schroot, we need to
stay on the bookworm container, though.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml |  2 +-
 kas-container         | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 31c9414..bffc80c 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -30,7 +30,7 @@ variables:
   SSTATE_MAX_AGE: 14d
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:4.8.2
+  image: ghcr.io/siemens/kas/kas-isar:5.1-debian-bookworm
 
 .sstate-prepare:
   script:
diff --git a/kas-container b/kas-container
index 476724c..b46682e 100755
--- a/kas-container
+++ b/kas-container
@@ -27,8 +27,9 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="4.8.2"
+KAS_CONTAINER_SCRIPT_VERSION="5.1"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
+KAS_CONTAINER_IMAGE_DISTRO_DEFAULT="debian-bookworm"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -64,7 +65,8 @@ usage()
 	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
 		    "configured build.\n"
 	printf "%b" "\nOptional arguments:\n"
-	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image.\n"
+	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To force\n"
+	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=run0.\n"
 	printf "%b" "--with-loop-dev		Pass a loop device to the " \
 		    "container. Only required if\n"
 	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
@@ -117,6 +119,26 @@ trace()
 	"$@"
 }
 
+prepare_sudo_cmd()
+{
+	if [ -z "${KAS_SUDO_CMD}" ]; then
+		# Try to auto-detect a privileged executor
+		if command -v sudo >/dev/null; then
+			KAS_SUDO_CMD="sudo"
+		elif command -v run0 >/dev/null; then
+			KAS_SUDO_CMD="run0"
+		else
+			fatal_error "No privileged executor found, need sudo or run0."
+		fi
+	fi
+
+	case "$KAS_SUDO_CMD" in
+		sudo) _KAS_SUDO_CMD="sudo --preserve-env";;
+		run0) _KAS_SUDO_CMD="run0 --background= --unit=kas-container@$$";;
+		*) fatal_error "Unsupported KAS_SUDO_CMD ('${KAS_SUDO_CMD}'), use sudo or run0.";;
+	esac
+}
+
 enable_isar_mode()
 {
 	if [ -n "${ISAR_MODE}" ]; then
@@ -128,15 +150,17 @@ enable_isar_mode()
 	KAS_ISAR_ARGS="--privileged"
 
 	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		prepare_sudo_cmd
 		# sudo is needed for a privileged podman container
-		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
 		# preserved user PATH may lack sbin needed by privileged podman
 		export PATH="${PATH}:/usr/sbin"
 	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+		prepare_sudo_cmd
 		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
 		debug "kas-isar does not support rootless docker. Using system docker"
 		# force use of well-known system docker socket
-		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
 		KAS_DOCKER_ROOTLESS=0
 	fi
 }
@@ -267,10 +291,14 @@ trap kas_container_cleanup EXIT INT TERM
 set_container_image_var()
 {
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_DISTRO="${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAINER_IMAGE_DISTRO_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
 	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
+	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
+		KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DISTRO}"
+	fi
 }
 
 # SC2034: DIR appears unused (ignore, as they are used inside eval)
@@ -283,6 +311,7 @@ setup_kas_dirs()
 	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
 	DL_DIR="$(check_and_expand DL_DIR createrec)"
 	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
+	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
 }
 setup_kas_dirs
 
@@ -339,6 +368,10 @@ while [ $# -gt 0 ]; do
 			if [ "$(id -u)" -eq 0 ]; then
 				fatal_error "loop device not available!"
 			fi
+			prepare_sudo_cmd
+			if ! [ "$KAS_SUDO_CMD" = "sudo" ]; then
+				fatal_error '--with-loop-dev requires sudo for device setup.'
+			fi
 			sudo_command="/sbin/losetup -f"
 			sudo_message="[sudo] enter password to setup loop"
 			sudo_message="$sudo_message devices by calling"
@@ -593,6 +626,7 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
 forward_dir DL_DIR "/downloads" "rw"
 forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
 forward_dir SSTATE_DIR "/sstate" "rw"
+forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
 
 if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
 	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
-- 
2.51.0

