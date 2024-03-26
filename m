Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A87EF09
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434680; cv=none; b=LVdAk2JiYJQOOCB2e9UlZfi2IfRvDlZDA5K1f3UErhLqRMq8lSqmcA3eJ+XP2ObeyzuUs6PELHPBvvsNanCcetw0/IqOteZdV38Iay0F7tfgcWJDugNsa46CNnmzumnNEjJliz7YbWhiEoB0o5awFs/PsNwJOg892C95OOfe8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434680; c=relaxed/simple;
	bh=CsZ+kjY8gEt7QbiUnpWulvhWayaESufGCaLQbDqmRs8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JX7Zw+CAhh/VN6o3Dm1Tk3wk6pxXTcwKXH3LkD3LKlCdwxIydSCnZyKEEqfPqrov1j1+XBTt7e5fon3U1NLzpvLOGXEZZDZ/Vl6HAwj8OO4wh2ZWKeC8A9dw0qA+FKmC16F4GriUDuXYAU2hz8gXyRTeMgi8PFd5UA+S/H65JcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=F3vpS/gY; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="F3vpS/gY"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202403260631061ab65ec30f19f58780
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=R90Ud4kpuUERw5N9C6oOXqKN+1aoTiAMqJ0M34SwjjA=;
 b=F3vpS/gYG5Hw0LhFQiVNr6gEoqB2c5pxLs96AcMv5MOGsKN1omSUUVa2Mn8omMo+h066Zx
 WUnzirvHGlhZqCZNrH5QQcn9oczqAlqhsCn+d4JuDYXPNekRJgvoPe5QGE9b0SWhDA6wA16Q
 /jRhL45bunIPpNTF/mFoVRM4cqOY4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 04/25] Drop duplicate define of inclusion guard
Date: Tue, 26 Mar 2024 07:30:43 +0100
Message-Id: <1d9e5c6d9c1d5421f80eb3dc19600f4ff4a79747.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/uapi/arith.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/arith.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/arith.h
index 3682736f5f..55df25f5a4 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/arith.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/arith.h
@@ -20,7 +20,6 @@
  */
 #ifndef _COBALT_X86_ASM_UAPI_ARITH_H
 #define _COBALT_X86_ASM_UAPI_ARITH_H
-#define _COBALT_X86_ASM_UAPI_ARITH_H
 
 #include <asm/xenomai/uapi/features.h>
 
-- 
2.35.3

