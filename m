Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83541197A7F
	for <xenomai@lists.linux.dev>; Thu, 24 Oct 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754834; cv=none; b=Iw2mTi3YhTr9+tKcNswwCn1XNyOQJ4SG2Cm0bwbXZCjKiqmtzbidTcxNilPbcB7YuCoM42bHmFAceI6iwNze9tkQiGTwrmIgGGNVpPbPV4V5VLQqa5S+M7+4WR9TBn5NJq1LIowpGI84EvlFovIB1ySjHo+xoeOFoQ28jMTsJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754834; c=relaxed/simple;
	bh=r1BdS60Goi9endyruI+BULA79dKxOe58a7ZxlI36vBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQFSW3LyKoiJK8IkaEESdyaYLPvsJ6iDe6+tLQZa10b3gXwAyDcV2M4iw+U/47QtbTBwiOQyYkrp/aGs6iqaQ99ITnRnNKlG8rskWFpnR8lFSjasIVBl2TTD+LJziG+HCeJLGqr0AkcV6dA7EjZ4j9zlMrBRxq3I4BhcMe4X6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QMlBlxZq; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QMlBlxZq"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241024072700eaf36688500a71f431
        for <xenomai@lists.linux.dev>;
        Thu, 24 Oct 2024 09:27:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YeHbkJBgwVmHLsVfqh4eEHzrH3NSrQHfawC32dSyaf0=;
 b=QMlBlxZqs3d/SpgQi5F2hYzT95VZJ9Kq1sskcgK3YNSQMsCt28J9jSqTPS1+jxIKuKkTVY
 uf0+Zm6gkgCOZ0/+++ZBhL2FayLgcPwcFi+wu7VrVD1aA9hqnEuDNNQv+DRhTmFIkIZ3Clvx
 3oEKNXyFAnkXP6L/dHwP3n9kTPz9qXGC88pnp2UL2ToRRu79VKb4PGdi+VM1iZsUApOIpPFi
 B/SvKJ26qKlGMcJbnPD2HcPDWL0bbadCOxQFrsdLht5ot3qE7f4Vuaok2hdgZxw2zkPsUBoE
 4YUTfztbo3RyRBhv3Xfc95dTPrBDhRLWK51GaP2J+XNACG4Gxcih6gUg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] y2038: lib/cobalt: Fix __STD() macro usage for some services
Date: Thu, 24 Oct 2024 09:26:56 +0200
Message-Id: <20241024072656.179803-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The macro usage was broken for the following services:
  - recvmmsg
  - mq_timedsend
  - mq_timedreceive

The message queue services were forwarded to wrong libc functions,
the recvmmsg was missing the correct routing.

Detected while trying to remove the function wrapping at all.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/mqueue.h     | 4 ++--
 include/cobalt/sys/socket.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
index 89d4bff79..9fd502c04 100644
--- a/include/cobalt/mqueue.h
+++ b/include/cobalt/mqueue.h
@@ -42,14 +42,14 @@ COBALT_DECL(int, mq_setattr,
 COBALT_DECL(int, mq_send,
 	    (mqd_t qd, const char *buffer, size_t len, unsigned prio));
 
-COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend64,
+COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
 		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
 		    const struct timespec *timeout));
 
 COBALT_DECL(ssize_t, mq_receive,
 	    (mqd_t q, char *buffer, size_t len, unsigned *prio));
 
-COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedsend_time64,
+COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
 	    (mqd_t q, char *__restrict__ buffer, size_t len,
 	     unsigned *__restrict__ prio,
 	     const struct timespec *__restrict__ timeout));
diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
index d5e81e5bd..9095594c6 100644
--- a/include/cobalt/sys/socket.h
+++ b/include/cobalt/sys/socket.h
@@ -31,9 +31,9 @@ COBALT_DECL(int, socket, (int protocol_family, int socket_type, int protocol));
 
 COBALT_DECL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags));
 
-COBALT_DECL(int, recvmmsg,
-	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
-	     unsigned int flags, struct timespec *timeout));
+COBALT_DECL_TIME64(int, recvmmsg, __recvmmsg64,
+		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+		    unsigned int flags, struct timespec *timeout));
 
 COBALT_DECL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags));
 
-- 
2.39.5

