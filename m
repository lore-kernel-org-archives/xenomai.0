Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEB26AFB
	for <xenomai@lists.linux.dev>; Sun, 25 May 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748160429; cv=none; b=lYbaOyD9WpZ5keYh2K6yh/9WMSD0XFQ5DD1hoGWIzq/9p+1WbRSyJy5KHzQTpQMkZqczpLasGOYCXYHaiGk2fHUXWbrrRx1IKIFU51GPRfeO1ac9c2AcR0xwQqZa7evMNWdccdj5zueEiLSzzENkvMGfOUzSHdGlgSEs+eAItBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748160429; c=relaxed/simple;
	bh=QFxBLCO5FTjv8h1ytoZbqdcWdgfmChPVvF3lVKmKcUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKjvFx5xdf7NPm/zJFqubAM788uVXwG1Y26qB8VdC2A9NDEoLaIe4cwj1wB92McETA3T/JFoPu+az6L2Qj0r4gIS7dxh4D76X16CNXsH+IlEgZX9+GQWAn6NNrWmquOfmsRs4HlgPuwOLsea1Zsp2VH0Ea59m1AKctnyENs2AkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aitP6gg1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aitP6gg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/n
	xUfK82c+D4G9NNco63UZPZ92KANtWEPZUgfml8zuA=; b=aitP6gg1WFiTb2/O3i
	zh2utpnFm2juhaZyS4YBC7vCFXp9vWYnZVzcahMAW8xO+6MGl/9oaDmYN+/NRtMu
	BoF7QjFgjdluPSOFafb4FCTT2IAJDs9233qz7FZDL6uk9mcnF552Kkfq6Jg7dkNx
	z4bzrra7be6a78PFQDq6Y3mNw=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3VyidzzJoMy4_EA--.8410S2;
	Sun, 25 May 2025 16:06:54 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] scripts/wrap-link.sh: Add support for -h|-help option
Date: Sun, 25 May 2025 16:06:48 +0800
Message-Id: <20250525080648.353288-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3VyidzzJoMy4_EA--.8410S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDZw1rWF4rCryftw45Awb_yoWfJwcEyr
	s2qr93JF1xGr45KF1Fvrs0gryY9F45XFyUWryrXr12v3s8Crs5XFs7J3sIqF13A34UWrW2
	vFZ8W348Jay8XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUGg43UUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBtYcWgyxim8mgAAs9

Following the porting-posix tip, add support for -h|-help option.

Tip: https://v3.xenomai.org/tips/porting-posix/

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 scripts/wrap-link.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
index fa83bd5e2..21c6885a2 100755
--- a/scripts/wrap-link.sh
+++ b/scripts/wrap-link.sh
@@ -17,6 +17,7 @@ Options:
 -q be quiet
 -v be verbose (print each command before running it)
 -n dry run (print all commands but don't run any)
+-h, -help show this help message and exit
 
 Example:
 $1 -v gcc -o foo foo.o -Wl,@/usr/xenomai/lib/cobalt.wrappers -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt
@@ -85,6 +86,11 @@ while test $# -gt 0; do
 	    dryrun="echo # "
 	    ;;
 
+	-h|-help)
+	    usage "$progname"
+	    exit 0
+	    ;;
+
 	-*)
 	    cc="$cc $arg"
 	    ;;
-- 
2.34.1

