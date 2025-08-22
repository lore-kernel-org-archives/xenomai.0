Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E1199230
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836502; cv=none; b=Lf55yn855HVc01hrsjVb0Lxcsr4ELo8rVYV+o6vgNbtswhC+32VSCLerKtT7lfp87M5qt8M9PW5OM2hxA3DoG1t30C45OrZ3Cf4D4NmwWr3AHEEbNXOzOnr0JFUnGbo2CHvH+hfBE8IlnjGJ93baVK/BibGitfNmifleBnV8BHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836502; c=relaxed/simple;
	bh=GybIGRY4ZRhpgrRyrfp48nfi6RZVrM1Tek8oMHtyvwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=phEAQwPmaqwmu2wUgiptOyri2dic9E5RI20MuZK6602SEnsO/x81ssZfBVgEYq317HlfRhnp5Or9KYTc7F2l95WXjlY/Bqvqg9SlslJnAGzfNhKGK0JWh27k2TxfWIug7Q4uduc07uEEvxydNOfEeYgD4nKBkcZh6/d2sIHRli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pa6wTx3i; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pa6wTx3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8T
	eZ0kEAAxnwRTtJsohmiOMm8pF9I654FYIMyhRSJPU=; b=pa6wTx3iPCqmrkq5+V
	L6jQQ1LI/s7DokRrXcGVMrBLpJCPrPUelURSBQP2on7QKl1wbob1Uks7CcZR1y12
	7rK7s+2Fmx0pr5s98GdpwAxLSaVAu3a1kRN9IAj+SFD3qZw6QjID8welFe4/6YhV
	akzl+Wu4RZvJWk+QVO3JCRxMU=
Received: from wang-Xenomai.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHah9M8KdoxbKSAA--.22177S2;
	Fri, 22 Aug 2025 12:21:33 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	wang <guangfeng.wang@siemens.com>
Subject: [PATCH v2] Replace obsolete AC_CANONICAL_SYSTEM macro
Date: Fri, 22 Aug 2025 12:20:59 +0800
Message-Id: <20250822042059.4812-1-guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHah9M8KdoxbKSAA--.22177S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUWF17tr1UXF1rZF4UCFg_yoWkZrb_Cr
	WxCrnrCr48Ar9rC3W09rW7JrnFqa4UAw4YgayDKr1jkry2vFs8Aws5Crnaqan5u3Z0grW3
	Za4Fva4j9rnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUrgA3UUUUU==
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbBMQ2xeWin4-XzYAABs-

From: wang <guangfeng.wang@siemens.com>

The macro `AC_CANONICAL_SYSTEM` is obsolete and triggers warnings
in modern autoconf.
This patch replaces it with the recommended macros to silence
these warnings.

---

Patch v2:
- Using AC_CANONICAL_TARGET is enough. Delete AC_CANONICAL_BUILD and AC_CANONICAL_HOST.

---

Changes in v2:
- Fold in previous discussion from:
  https://lore.kernel.org/xenomai/24d3ca0f-52c9-4d82-9ffa-7ceee81c8ba8@siemens.com/T/#t

Signed-off-by: wang <guangfeng.wang@siemens.com>
---
 config/ac_prog_cc_for_build.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config/ac_prog_cc_for_build.m4 b/config/ac_prog_cc_for_build.m4
index 8cba24927..731de2b22 100644
--- a/config/ac_prog_cc_for_build.m4
+++ b/config/ac_prog_cc_for_build.m4
@@ -5,7 +5,7 @@ AC_DEFUN([AC_PROG_CC_FOR_BUILD], [dnl
 AC_REQUIRE([AC_PROG_CC])dnl
 AC_REQUIRE([AC_PROG_CPP])dnl
 AC_REQUIRE([AC_EXEEXT])dnl
-AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
+AC_REQUIRE([AC_CANONICAL_TARGET])dnl
 dnl
 pushdef([AC_TRY_COMPILER], [
 cat > conftest.$ac_ext << EOF
-- 
2.34.1

