Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740153FBB7
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=sV3aac6RV9ciiR39IKCAASOTv4QEKq0kzZ5ck4pkrAxTQ753iKGit6xp8GLkFbmEOeTKhO40+cmuSGPeaDo3He9LtWuYXyEtiq6kvWYAKCvLJiY0GOAVix8VhOfDEh9DDmIeopjhS3wmWazeRQdlMXUg2Nq1WekKFyloMIWSIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=rp0AmKBVWfCsNH3ANtNY0BrJkrXCBKoOrRjpBOgvN8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBicAW6LpQ/Taz4zY+4rwT08XP8D+7CjF/p+tfmDTTWHm/p1OS0CXBiV/0O/ecOwKXyDSCHOnlnr5E2muBIVHJE8cDyWNzv1QBIQ3Bw4XteA5vQ7vK+5gXFyOWuSv58WVCWqEDNPXRjZ7JhzKJsuNJG/F/4qC2m0e7Q6vlPt/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E334B6195FFB;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6NBgRSBdYgB7; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A1AC9644CE8C;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nkX8bJ43h6To; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 5D4B66340E17;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/16] prepare-kernel.sh: Define command line variables
Date: Sat, 25 May 2024 13:58:03 +0200
Message-Id: <20240525115806.12101-14-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240525115806.12101-1-richard@nod.at>
References: <20240525115806.12101-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To use "set -u" later, define all variables that can be set via the comma=
nd line.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index a8179518b..43883ded3 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -3,9 +3,6 @@ set -e
=20
 unset CDPATH
=20
-# Default path to kernel tree
-linux_tree=3D.
-
 patch_copytempfile() {
 	file=3D"$1"
 	if ! test -f "$temp_tree/$file"; then
@@ -120,6 +117,14 @@ generate_patch() {
 usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--verbose] [--rever=
se]'
 me=3D`basename $0`
=20
+# Default path to kernel tree
+linux_tree=3D.
+output_patch=3D""
+linux_arch=3D""
+reverse=3D0
+pipeline_patch=3D""
+verbose=3D0
+
 while test $# -gt 0; do
 	case "$1" in
 	--linux=3D*)
--=20
2.35.3

