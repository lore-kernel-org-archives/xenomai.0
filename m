Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830CB2BF3CA
	for <xenomai@lists.linux.dev>; Thu, 24 Jul 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358424; cv=none; b=YUzgYBIuDrBpqWnLJvMvm24E25UngJfVhJk0vsOeuHuBeDUaQpNpdskwihNTLxFoRUkzzYMf7sSH0ShCfvV79F8jL0DXs4PbB19/9b+shLTLUlCr93rF4+f4/fKxpXGXPzbSF2taMpvKP9CYm/l5dplQWKR/7y6TA8cDRuXMcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358424; c=relaxed/simple;
	bh=+4bf07eg2QSWOBdFSXHHUOiZ7ds9O2celd2uoBVVdj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQ01C5JAPYB00HHKyw8Iagw02M8aiaf31e6G1s2l4xD/EZZ8rGExrVx/1pmgB5DCNMJOP3/d3oziiDq1IHPfPTiuUd8FJpXwSLbjJ3FBoXwdf0AuGQAOpCTk+GPQn3xRtPsK+n/cXPZ+Voon1aYCwAwa7AnOi7lWeoiU8rmjBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xm2oitjM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xm2oitjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=i7
	gdykPB+fWjN864kcytDpFXAGsv8TpNaVvAnhLSonU=; b=Xm2oitjMLTOn+2oTM/
	Jho1fBQ5vh1xlFzLF3zwOQ6PpDiya6r0MxuvwnEe7+ihIDZ9VpNmCaYAvUoqAAIm
	sxjP0iPiEWBa0k79UCiUIKRXYydHoM5Es+b9Hfg4ZN+KEoW4OGXZOIUcS+vLLm+2
	4j2pVf54TZZNoZDp360zvKgss=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHxmpRIIJoV27kGw--.36049S2;
	Thu, 24 Jul 2025 20:00:18 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH 1/2] lib/cobalt: fix incorrect addr passed to sc_cobalt_backtrace syscall
Date: Thu, 24 Jul 2025 20:00:11 +0800
Message-Id: <20250724120012.1656476-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHxmpRIIJoV27kGw--.36049S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr15Ww4DGF1kCw1kKr43GFg_yoW8XF4kpF
	1Sgrs2krWUGwsYyFZ8Ww1kCry5Xa95XFy7WF13CrW8Cw45XayIqr1aqa4Ivr13Grn8JrW3
	K3y8tr1UCF1v9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_sqXUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBOUcWiCFp2zqwAAsT

The correct value of "frames + skip" should be
&frames[0] + skip * sizeof(void *). But ARM64/XENOMAI_SYSCALL3 expands
it to (unsigned long)frames + skip, which means &frames[0] + skip. The
sc_cobalt_backtrace syscall gets incorrect addr, then the backtrace of
relax is invalid.

Symptom maybe as following:
2
/root/latency
316 2 syscall sampling-313
.

Applied this fix:
2
/usr/xenomai/bin/latency
293 2 syscall sampling-290
0x2970 /usr/xenomai/bin/latency
0xffffb0de4cb0 ?
0x13a64 /usr/xenomai/lib/libcobalt.so.2.0.0
0x13b28 /usr/xenomai/lib/libcobalt.so.2.0.0
0x39a0 /usr/xenomai/bin/latency
0x3b5c /usr/xenomai/bin/latency
0x17a68 /usr/xenomai/lib/libcobalt.so.2.0.0
0x7d5b8 /usr/lib/aarch64-linux-gnu/libc.so.6
0xe5edc /usr/lib/aarch64-linux-gnu/libc.so.6
.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 lib/cobalt/sigshadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index 10736b113..938055e08 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -59,7 +59,7 @@ int cobalt_sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 		nr = backtrace(frames, ARRAY_SIZE(frames));
 		/* Skip the sighandler context. */
 		skip = nr > 3 ? 3 : 0;
-		XENOMAI_SYSCALL3(sc_cobalt_backtrace, nr - skip, frames + skip, arg);
+		XENOMAI_SYSCALL3(sc_cobalt_backtrace, (nr - skip), (frames + skip), arg);
 		break;
 	case SIGSHADOW_ACTION_HOME:
 		/*
-- 
2.34.1

