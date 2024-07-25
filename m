Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27B3BBC2
	for <xenomai@lists.linux.dev>; Thu, 25 Jul 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951652; cv=none; b=hrGVMU2Da7QbmMs4EgF2pjg94WSecB1wHNhMs2QflhUSSGhihVfjUn4tsy3KYGz48cuB9Tj0XUUnqiKyB6fVYNsocninmYo1pRPbbfK9lAxMJNI6sCzOw0CAnrSzk+iJMenJRRJMVO7vsznEosBwdzGQEAxxerBGFmrdGWBoZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951652; c=relaxed/simple;
	bh=1Ujg0u7qBc8wZHWrtYWz5+a2+5s3Dny0nHZfiQzoFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lk9hmx8PFAFbi4iTMIkixrfj8L3Tt3Pxj+AELtvuejZcrZWn6rYTUPs6CdiVrx8Ecp+3G4Gn0dahyFuLXaIT7zwNFn3UXxj0L2sDTvr6yB6PU+0VFs1Hy4ZqYOnc+wAo5gYCTFoZ0ixhD3xcovykMkAkhecNLfwAWg1a2uB/WEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0/9EcRF; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0/9EcRF"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 7977C100002
	for <xenomai@lists.linux.dev>; Thu, 25 Jul 2024 23:54:01 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 82EC2D8065A
	for <xenomai@xenomai.org>; Thu, 25 Jul 2024 23:54:00 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-25d634c5907so453300fac.2
        for <xenomai@xenomai.org>; Thu, 25 Jul 2024 16:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721951639; x=1722556439; darn=xenomai.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7LQaC0gbyb2yH2h/iwOLJq+7SFlL/9rqQgBh1sZTgU=;
        b=H0/9EcRFBYl/5e2tEiJBPyvBjZ2HMnBH9xfi5a8VPgM7XgT2tldwGM6dmhnDrpVAP8
         uMIBNNCrpRNv7e+PW2LpB0pgSU8tz7LB5GvM6O9XUQYzCdZPrgQ2uZCVjqdGl54MtDZu
         nBSLu5Wza0R43HwCLyJQ8FS8Au3r7FE9x/sBWjHG+DJotxhBD5qec7V0HVNAwbvTdyeb
         gzrvSIaSOTj0788zbDZL38A9o/9ZkwcO3CoNlUO5wZz6J/jVEdmXuDOf+OUbPvfpLv9K
         trLKCQoZzPdPZy0n2PegaK2MXVDro0XOpw8tzMG38VXQtGG5IoAsjuCnbWONBonXtBVy
         ausQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721951639; x=1722556439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7LQaC0gbyb2yH2h/iwOLJq+7SFlL/9rqQgBh1sZTgU=;
        b=LoDRw4NuCj+C3r51YA0WFD/xLcYL/4x61KHqUJ7ugTKhV6tBKpqEm2NB7sNY59PPyD
         AL59pLvTB/S+9curZ1rhyAjB7tRuIZsVAvJvgZQOqZl0R6d1A4OVw+Mev2aDWB5ogmUu
         ggyYvFO7Ujdpn/LTtwr0s2mrDAJqn+NFRUNu5+fsN3DtuiF+TUPvmFgR43877JiCywlY
         OvFpbUpe/3cA/CkbEEvubJaYh++Y8mJiNrTrZmer1Co1Ttr0i3Q7YI2D7GSiHSzH7fbu
         /0umY6fWYka71tjjprlRS6odXOBOioS8S5/Gmbi3fpQ+L0XOfw1cgokQQTcODdqOx8cV
         X2JA==
X-Gm-Message-State: AOJu0YyGgItB7SY/MxOoUNzTGuuQxX2NmTlDQCMymKcf+p5x0AwKCxUw
	/z90JG+80RZvKYRd+MNd6rM+owW0iltUL2+4TiQCrvc4Ac0YrPu5aqI4Hg==
X-Google-Smtp-Source: AGHT+IER6jTn6FswWlb1FuOuy+QJp1wMGaElZHWQR6ekXSiQtRBIpBitOTbD7sEFFObo/QHJpECgAw==
X-Received: by 2002:a05:6870:4686:b0:261:1ffb:4ab6 with SMTP id 586e51a60fabf-266cc37864dmr4384618fac.21.1721951638999;
        Thu, 25 Jul 2024 16:53:58 -0700 (PDT)
Received: from rhelC.localdomain (104-182-174-186.lightspeed.irvnca.sbcglobal.net. [104.182.174.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8af081sm1657118b3a.220.2024.07.25.16.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:53:58 -0700 (PDT)
From: kon <ksmola51@gmail.com>
To: xenomai@xenomai.org
Cc: Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 1/1] kernel/drivers/net/stack/packet/af_packet.c: 32-bit compat support
Date: Thu, 25 Jul 2024 16:53:47 -0700
Message-ID: <20240725235347.115933-1-ksmola51@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: spool.mail.gandi.net;
	spf=pass (spool.mail.gandi.net: domain of ksmola51@gmail.com designates 2001:4860:4864:20::2b as permitted sender) smtp.mailfrom=ksmola51@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

From: Konstantin Smola <ksmola51@gmail.com>

kernel/drivers/net/stack/packet/af_packet.c: 32-bit compat support
Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
---
 kernel/drivers/net/stack/packet/af_packet.c | 62 +++++++++++++++------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
index 6013ff9e7..3ac5f5f13 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -29,6 +29,7 @@
 #include <rtnet_iovec.h>
 #include <rtnet_socket.h>
 #include <stack_mgr.h>
+#include <rtdm/compat.h>
 
 MODULE_LICENSE("GPL");
 
@@ -107,10 +108,10 @@ static int rt_packet_bind(struct rtdm_fd *fd, struct rtsocket *sock,
 	int new_type;
 	int ret;
 	rtdm_lockctx_t context;
-
+#ifndef CONFIG_XENO_ARCH_SYS3264
 	if (addrlen < sizeof(struct sockaddr_ll))
 		return -EINVAL;
-
+#endif
 	sll = rtnet_get_arg(fd, &_sll, addr, sizeof(_sll));
 	if (IS_ERR(sll))
 		return PTR_ERR(sll);
@@ -266,26 +267,53 @@ static int rt_packet_ioctl(struct rtdm_fd *fd, unsigned int request,
 	struct _rtdm_setsockaddr_args _setaddr;
 	const struct _rtdm_getsockaddr_args *getaddr;
 	struct _rtdm_getsockaddr_args _getaddr;
-
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	const struct compat_rtdm_setsockaddr_args *compat_setaddr;
+	struct compat_rtdm_setsockaddr_args _compat_setaddr;        
+	const struct compat_rtdm_getsockaddr_args *compat_getaddr;
+	struct compat_rtdm_getsockaddr_args _compat_getaddr;
+#endif
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
 		return rt_socket_common_ioctl(fd, request, arg);
 
 	switch (request) {
-	case _RTIOC_BIND:
-		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
-		if (IS_ERR(setaddr))
-			return PTR_ERR(setaddr);
-		return rt_packet_bind(fd, sock, setaddr->addr,
-				      setaddr->addrlen);
-
-	case _RTIOC_GETSOCKNAME:
-		getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
-		if (IS_ERR(getaddr))
-			return PTR_ERR(getaddr);
-		return rt_packet_getsockname(fd, sock, getaddr->addr,
-					     getaddr->addrlen);
-
+	COMPAT_CASE(_RTIOC_BIND):
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		if (rtdm_fd_is_compat(fd)) {
+			compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr, arg, sizeof(_compat_setaddr));
+			if (IS_ERR(compat_setaddr))
+				return PTR_ERR(compat_setaddr);
+			return rt_packet_bind(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
+						compat_setaddr->addrlen);
+		} else {
+#endif
+			setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
+			if (IS_ERR(setaddr))
+				return PTR_ERR(setaddr);
+			return rt_packet_bind(fd, sock, setaddr->addr,
+						setaddr->addrlen);
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		}
+#endif
+	COMPAT_CASE(_RTIOC_GETSOCKNAME):
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		if (rtdm_fd_is_compat(fd)) {
+			compat_getaddr = rtnet_get_arg(fd, &_compat_getaddr, arg, sizeof(_compat_getaddr));
+			if (IS_ERR(compat_getaddr))
+				return PTR_ERR(compat_getaddr);
+			return rt_packet_getsockname(fd, sock, (struct sockaddr *)(uintptr_t)compat_getaddr->addr,
+						(socklen_t *)(uintptr_t)compat_getaddr->addrlen);
+		} else {
+#endif
+			getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
+			if (IS_ERR(getaddr))
+				return PTR_ERR(getaddr);
+			return rt_packet_getsockname(fd, sock, getaddr->addr,
+						getaddr->addrlen);
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		}
+#endif
 	default:
 		return rt_socket_if_ioctl(fd, request, arg);
 	}
-- 
2.43.5

