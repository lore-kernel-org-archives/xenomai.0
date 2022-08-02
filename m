Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146577F
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 16:47:17 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id DE1D82000B
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 16:47:09 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 836B2941ADA
	for <xenomai@xenomai.org>; Tue,  2 Aug 2022 16:47:08 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id q19so4738973pfg.8
        for <xenomai@xenomai.org>; Tue, 02 Aug 2022 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UfJ08fy2EPExCKrV8yWdjK+qv6i2rM1KiSElGQ4K1Bc=;
        b=USLaPjvsWjhy8boXvB5XWdjaVz6fIi56nAC9XdHP8zkOfnP55flimY52UfcprxpAHp
         lfdIOOOr85SH5BeetB+sqfZDxyhFjM48YpgTVIuRSef3llsNb3zDhspY/44tLlENZxo1
         JvwM4tI3Fw5Lpv4Y2WVmvBDu9DlYXnYB/pAUoIosCzHG0YRdyTFLwlSDWGdlrABL6G3W
         +LHvd7+H9Vw/e+LgbeBpLQmQu1erLxnKWdJO5PyQ4KQpkjjtwImCISXhWSbDDgs203sC
         q8AALuSn8GCs6tNzdp2DusQauxDcH3fWy+/1/aas+Vm9F94/9920LTpMtHh6b+uujOJk
         pyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UfJ08fy2EPExCKrV8yWdjK+qv6i2rM1KiSElGQ4K1Bc=;
        b=eBGXfc7gPFLxUS8O2HU8SHE9gJHp1+zz5J5wnLm9ZCrlQ2WATE15ebnLDTc04cezov
         fokkSHGXYRXFXOjt+QSxgppkdle3f5yA7p8N+RHmM2PWcF5L/ifQLqgMKA2FLOKfvbs8
         y8OtnQ5TX4RYpw0DM3tm+CNXul6ib51ThS8GwxNR05nO/jESnN8ztJS/dtCvncQ4XbTp
         RL4NWm7w50arYTpYeTE8Pq+MWxk/ZumNOHWQjkwIZtuJeTzMzjZX2uKxYiorvoqqexfN
         Qq6gcsNDYuaX3uri4Fx8Q0gArgPS06BHTGf6D9a29Sv288Pg3FL+zSdyLuMLesFdod68
         pqpA==
X-Gm-Message-State: AJIora96VXEyhBbzxlmFsCOkrC4VSSSp5ogk3jzr91eErSbeDt+ZYmVQ
	btNuiL1VLTCHVwvUda1NZpqj/H1lp4yu0w==
X-Google-Smtp-Source: AGRyM1tTNATTHA7K5O6MADJQQlDKBNwS4R/AdMMI3kmHt0DMZqf/zIYZaPyRtI22lHxXqfUcdkU6Gw==
X-Received: by 2002:a63:d006:0:b0:419:b272:9e6d with SMTP id z6-20020a63d006000000b00419b2729e6dmr17503639pgf.608.1659458826770;
        Tue, 02 Aug 2022 09:47:06 -0700 (PDT)
Received: from semi2.localdomain (075-084-128-050.res.spectrum.com. [75.84.128.50])
        by smtp.gmail.com with ESMTPSA id p2-20020a625b02000000b0052d63fb109asm5300806pfb.20.2022.08.02.09.47.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2022 09:47:06 -0700 (PDT)
From: Konstantin Smola <ksmola51@gmail.com>
To: xenomai@xenomai.org
Cc: Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit compat
Date: Tue,  2 Aug 2022 09:46:51 -0700
Message-Id: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
X-Mailer: git-send-email 2.1.0
Received-SPF: pass (spool1: domain of gmail.com designates 209.85.210.178 as permitted sender) client-ip=209.85.210.178; envelope-from=ksmola51@gmail.com; helo=mail-pf1-f178.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=USLaPjvs;
	spf=pass (spool.mail.gandi.net: domain of ksmola51@gmail.com designates 209.85.210.178 as permitted sender) smtp.mailfrom=ksmola51@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

The rtnet interface was lacking 32-bit support for bind and connect ioctl.

Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
---
 kernel/drivers/net/stack/include/rtnet_internal.h |  1 +
 kernel/drivers/net/stack/ipv4/udp/udp.c           | 39 ++++++++++++++++-------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtnet_internal.h b/kernel/drivers/net/stack/include/rtnet_internal.h
index ec7e614..8194791 100644
--- a/kernel/drivers/net/stack/include/rtnet_internal.h
+++ b/kernel/drivers/net/stack/include/rtnet_internal.h
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <rtdm/driver.h>
+#include <rtdm/compat.h>
 
 #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
 #define RTNET_ASSERT(expr, func)                                               \
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5977a3b..89f4d80 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -357,23 +357,40 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	const struct _rtdm_setsockaddr_args *setaddr;
 	struct _rtdm_setsockaddr_args _setaddr;
+#ifdef CONFIG_XENO_ARCH_SYS3264
+	const struct compat_rtdm_setsockaddr_args *compat_setaddr;
+	struct compat_rtdm_setsockaddr_args _compat_setaddr;
+#endif
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
 		return rt_socket_common_ioctl(fd, request, arg);
 
 	switch (request) {
-	case _RTIOC_BIND:
-	case _RTIOC_CONNECT:
-		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
-		if (IS_ERR(setaddr))
-			return PTR_ERR(setaddr);
-		if (request == _RTIOC_BIND)
-			return rt_udp_bind(fd, sock, setaddr->addr,
-					   setaddr->addrlen);
-
-		return rt_udp_connect(fd, sock, setaddr->addr,
-				      setaddr->addrlen);
+	COMPAT_CASE(_RTIOC_BIND):
+	COMPAT_CASE(_RTIOC_CONNECT):
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		if (rtdm_fd_is_compat(fd)) {
+			compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr, arg, sizeof(_compat_setaddr));
+			if (IS_ERR(compat_setaddr))
+				return PTR_ERR(compat_setaddr);
+
+			if ((request == _RTIOC_BIND) || (request == _RTIOC_BIND_COMPAT))
+				return rt_udp_bind(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
+						compat_setaddr->addrlen);
+			return rt_udp_connect(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
+						compat_setaddr->addrlen);
+		} else {
+#endif
+			setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
+			if (IS_ERR(setaddr))
+				return PTR_ERR(setaddr);
+			if ((request == _RTIOC_BIND) || (request == _RTIOC_BIND_COMPAT))
+				return rt_udp_bind(fd, sock, setaddr->addr,
+							setaddr->addrlen);
+			return rt_udp_connect(fd, sock, setaddr->addr,
+						setaddr->addrlen);
+		}
 
 	default:
 		return rt_ip_ioctl(fd, request, arg);
-- 
2.1.0

