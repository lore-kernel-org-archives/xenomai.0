Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF71FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:14:33 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230223070423dbb329d6d6da27e673
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2ceFULkzowph6Hx6rpXKbJxOoASOO8W03sncUSUBNJA=;
 b=SKD9S9NLUeueRn1XMqaH4Tsd6zgFpDIyRPDd+Jt9eWpyVVIl9MfEVJvyLyDOpjnujLNNkd
 YrQijv9hFr5omX6g4eMY2diS0YDdwtmTL0FJLtyTY1AJNi336IEtZWILwd/ECcN8SwdaPir0
 ubLzbRI+II2g9rob/0j2WvLk/DboQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 7/7] drivers/net/stack/ipv4/udp: Implement compat support for the udp driver
Date: Thu, 23 Feb 2023 08:04:17 +0100
Message-Id: <20230223070417.3969366-8-florian.bezdeka@siemens.com>
In-Reply-To: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
References: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The rtnet interface was lacking compat support for the following ioctl
commands:
  - _RTIOC_BIND
  - _RTIOC_CONNECT

This patch is heavily inspired by Konstantin's proposal but migrated
to some rtnet APIs that allow us to stay away from
  #ifdef CONFIG_XENO_ARCH_SYS3264
sections.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5977a3bc2..777c8a27a 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -31,6 +31,7 @@
 #include <linux/tcp.h>
 #include <linux/list.h>
 
+#include <rtdm/compat.h>
 #include <rtskb.h>
 #include <rtnet_internal.h>
 #include <rtnet_checksum.h>
@@ -355,25 +356,27 @@ void rt_udp_close(struct rtdm_fd *fd)
 int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
-	const struct _rtdm_setsockaddr_args *setaddr;
-	struct _rtdm_setsockaddr_args _setaddr;
+	struct _rtdm_setsockaddr_args args;
+	bool do_bind = false;
+	int ret;
 
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
+		do_bind = true;
+		fallthrough;
+	COMPAT_CASE(_RTIOC_CONNECT):
+		ret = rtdm_fd_get_setsockaddr_args(fd, &args, arg);
+		if (ret)
+			return ret;
+
+		if (do_bind)
+			return rt_udp_bind(fd, sock, args.addr, args.addrlen);
+
+		return rt_udp_connect(fd, sock, args.addr, args.addrlen);
 
 	default:
 		return rt_ip_ioctl(fd, request, arg);
-- 
2.39.1

