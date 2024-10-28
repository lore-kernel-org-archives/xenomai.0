Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872461DD54E
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123092; cv=none; b=dpjKL0vqcREdESw0nN1Jw0sO1VR88QPM2KEYpCDb+KtWQBk2BGxhpDOGZCTFEs9xtJ3BAYTuc9Fq8/GG5OdlmvF8iFijXGvaFC/c3Dwap3cdd7dyj1y/aUDagIJsFvV+3dj7X+QCbycZmyPbFbxjfLFJ/hpL8hkdG9ucfYXrfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123092; c=relaxed/simple;
	bh=97hgzuJgFCq2obh38XDNLQXtwPLohdAerUEdOPQhHAw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIab8b4J5cPy5D/kxYNmnX90zUw4rdZjt/o+vvxjBneVIeUW5N21nd2496VD6Rw/MR92Bgida8lYENVzZuSAeeyEPNySJT3WFRKUS4np7Cs1NswTaSHzfu56DOfQ3qFh9sNsMgqtZGLcfuLVE/PJrpC7/xc0zEJff5HFRseGUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=KTcfR0SB; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="KTcfR0SB"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241028134445679f950db558802d6a
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NHrnNroQS07HN+b6ZSBP8KwZCsm25UfDbZ3Zp92M0EI=;
 b=KTcfR0SBDCBQc1vgnLobqn9VmHNxJKjhiws8brwChUI0rccr3CJw9OCq8XRtdjRN82gb3c
 e0pazF14ZRm9rdPb5Ba6XLpwoNJCtGZld3HrC8a6/l1bPJoRgActTNaSKK67kZjiZjALs5zo
 5HjlERQx/5ZicMKQs+unhkg3so5gInr2BRajwSgcDHFW5oyykTunohZ7H4P4Yr0HnaMkq683
 orFuL7tTR4V0wPR2WduvQ+74EBcZTBMjUshA5q5DNGYIcgUMhGxTY8mE+nhyDFnGvA74NjYm
 2IsO2YVqY5jmiFMrGY4bhciUFPJFlewmQYLSAZCNWUuCYHajsq/uoP4w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/6] Update to kas 4.5
Date: Mon, 28 Oct 2024 14:44:40 +0100
Message-ID: <88056bcbbcaf9d1482aa42f9fdb4386c7becaedb.1730123084.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730123084.git.jan.kiszka@siemens.com>
References: <cover.1730123084.git.jan.kiszka@siemens.com>
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

Just housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml |  2 +-
 kas-container         | 25 ++++++++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index ea66b06..a40dbcb 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -30,7 +30,7 @@ variables:
   SSTATE_MAX_AGE: 14d
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:4.4
+  image: ghcr.io/siemens/kas/kas-isar:4.5
 
 .sstate-prepare:
   script:
diff --git a/kas-container b/kas-container
index 169ea1b..6b2131c 100755
--- a/kas-container
+++ b/kas-container
@@ -27,7 +27,7 @@
 
 set -e
 
-KAS_IMAGE_VERSION_DEFAULT="4.4"
+KAS_IMAGE_VERSION_DEFAULT="4.5"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -354,10 +354,21 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 		shift 1
 		;;
 	*)
+		ARG="$1"
+		shift 1
+		if [ "$KAS_CMD" = "for-all-repos" ]; then
+			if [ $# -gt 0 ]; then
+				KAS_REPO_CMD="$1"
+				shift 1
+			else
+				KAS_REPO_CMD="$ARG"
+				unset ARG
+			fi
+		fi
 		KAS_FILES=
 		# SC2086: Double quote to prevent globbing and word splitting.
 		# shellcheck disable=2086
-		for FILE in $(IFS=':'; echo $1); do
+		for FILE in $(IFS=':'; echo $ARG); do
 			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
 				fatal_error "configuration file '${FILE}' not found"
 			fi
@@ -368,11 +379,6 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 				KAS_FILES="${KAS_FILES}:${KAS_REAL_FILE}"
 			fi
 		done
-		shift 1
-		if [ "$KAS_CMD" = "for-all-repos" ]; then
-			KAS_REPO_CMD="$1"
-			shift 1
-		fi
 		;;
 	esac
 done
@@ -512,6 +518,11 @@ if [ -f "${GITCONFIG_FILE}" ]; then
 		-e GITCONFIG_FILE="/var/kas/userdata/.gitconfig"
 fi
 
+if [ -f "${REGISTRY_AUTH_FILE}" ]; then
+	set -- "$@" -v "$(readlink -fv "${REGISTRY_AUTH_FILE}")":/var/kas/userdata/.docker/config.json:ro \
+		-e REGISTRY_AUTH_FILE="/var/kas/userdata/.docker/config.json"
+fi
+
 if [ -t 1 ]; then
 	set -- "$@" -t -i
 fi
-- 
2.43.0

