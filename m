Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC72252297
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645112; cv=none; b=GnTEKBxaeqfGHqH93sYT9Pvs2yUi6wvwpaDi9/yg2GGB8tV8c7xvBTags+CIppFwV6cfE9e6kZHyVhXzItkmkb80gLMuDmeLdGSbxrKONBxd8zwuculkupxA3a9Y8xo3kllgyaoCoDgrtwTkAzM95ApkpjsmvbNqg+bpChi5jMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645112; c=relaxed/simple;
	bh=MrhPpnv1wBVP9IzvHYKGhM58DGfwfgRvMvVetajDOXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzKWt47WKPOYFq4xCTEUkdnbx5DdzD/qzDNROxEF/LUvVSodF1dy8//LLFcU7svQVsXfQWDom3q9qZYrLKgp56tsIoyz0TH4OvZ2aprkBzo/5Kz3mbqFUEDNISIa32yaera5CV9HJBBoyVeDh9vhVxJmlxqlxxv8LdVBkBtGzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YKec95j+; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YKec95j+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AhXBM
	E5QGZRMHNVUIzUvOMqzFJvM/D6rJXpdQTg5CXs=; b=YKec95j+ME3vLvnlkWDCb
	zoXW/pC7+18WnHz5Y89WXY5cb3lFCvN5dS8WFsWoE92kXdyBMAC2n7HgD+oZNBJm
	TTMQ+6bcQyWdtSAzzv62xlT1RlIETVXUaHtLXRAKmuNPXmwEfrUEk+vCYEopV1Lr
	jHwSxnYiJFjSsQ5hzpIktc=
Received: from u2204.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXLY7uK_1n6cqyAQ--.41442S2;
	Mon, 14 Apr 2025 23:38:23 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	richard@nod.at
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path parameter
Date: Mon, 14 Apr 2025 23:38:17 +0800
Message-Id: <20250414153817.1829100-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXLY7uK_1n6cqyAQ--.41442S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF48uw1kCr13Cr4kWrW8tFb_yoWkGFXE9w
	saqr9agr4jyws8K3WrCayavF1ktr9rZ34xG345Zr17J34kGFsakFs5Jr93Ja4UZrZ7KF98
	G343tw42vF48XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRREfO3UUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXQgvcWf9JS7NVwAAsA

Ensure shell expands tilde (~) in the --outpatch parameter path.
This fixes "cd: can't cd to ~" errors when using home directory
shortcuts in output path.

The issue occurred because the ~ character in paths was not expanded
before directory operations.

$ ./scripts/prepare-kernel.sh \
--linux=~/xenomai/linux-dovetail \
--arch=arm64 \
--outpatch=~/xenomai.patch
./scripts/prepare-kernel.sh: 1: cd: can't cd to ~

Signed-off-by: Haiyang He <aspirestro@163.com>
---

Patch v2:
Change `eval "echo $output_patch"` to $(eval "realpath $output_patch")

 scripts/prepare-kernel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ecc830fd2..ea7892b21 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -139,6 +139,7 @@ while test $# -gt 0; do
 		;;
 	--outpatch=*)
 		output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
+		output_patch=$(eval "realpath $output_patch")
 		;;
 	--filterkvers=*)
 		echo "$me: warning: --filterkvers= is deprecated and now a no-op" >&2
-- 
2.34.1

