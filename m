Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2F2309B9
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088139; cv=none; b=BqBvQp3QToE3mPqj9Zh7gesAbVN4s5ehXSl+6JYIhI9YiNdQ/6sKww6fKFyYtzgGSf/djFJ2mFNrUiCdxgXL2m5TDmBjhX6ckc+sIiTqmY1TBSNrCo6Pj+UYhkEt+uedCxfT7KQq1+y397dHmlgTadGp0Wz3gHrE93K7tA1jlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088139; c=relaxed/simple;
	bh=I93jw/ri+QxPhlz3WLuWmALL5Bv4qsjpfwRzklDcIjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZyPB0UsbSsbatKUJVQjdDBS2sdBRBTY2Bs45agfMyOiHjNfc3y7ASxIVarTLTmeDOvF7qYdSrF0/7rYb0kArWDxj7L2CdFMEA0FPlqcYBCE3uYflnnD8BOcbbGWCfc28PKhF0PAGiD8AWNiCe8T1Kx43z0sm8cTvYFbBBmoIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JHg/lvhB; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JHg/lvhB"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025121820020794aec820e20002074e
        for <xenomai@lists.linux.dev>;
        Thu, 18 Dec 2025 21:02:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RQDyUl3zwxN9JSGg/yI9wGGAV6rrkGhfBjL0TC2Tokk=;
 b=JHg/lvhBJ44AAHSnUvux7sTmsT1OT8DPN02VwS2OiO5SA/UmOq7EwbjACq70izPn85KXf3
 XzE+Rsi06lJQAEYiN4Tl/YnYZInvsnqWgZw+I3DyUg86zLKBhTMgW87W1oG52LqJk/PNekyX
 DmJfGbO6nikDKR+q4o2qahwSPFqz33o1YMx5COIZXc19+xpfmrPUhBWhIUJ8Q8iHuZW9fkHZ
 Q3o2lxPS8CGtaBtIS72N0tehS1b8fTTkA4G/Yv3ltEvBRNL5MKfNa++UwpjsiKo1LRzyj3+L
 +rnal5fiUPn3t9d+i9lDHf42x6C9gNX8wPP959Ospl/Vo3QoVM5GGD2A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Dec 2025 21:02:02 +0100
Subject: [PATCH v2 2/6] y2038: lib/cobalt: select: Fix timeout writeback of
 the compat time64_t case
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v2-2-f606e54e8d57@siemens.com>
References: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The kernel might modify the timeout parameter. As we have to convert
from struct timeval (user) to struct timespec (kernel, pselect) the
updated value was hidden from the user.

Fixes: c2b883446b80 ("y2038: lib/cobalt: Implement necessary wrappers for y2038 support")
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/select.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 611994d17..5472e991e 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -57,9 +57,13 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
 
 	pthread_setcanceltype(oldtype, NULL);
 
-	if (err == -EADV || err == -EPERM || err == -ENOSYS)
+	if (err == -EADV || err == -EPERM || err == -ENOSYS) {
 		err = __STD(__select64(__nfds, __readfds, __writefds,
 				       __exceptfds, __timeout));
+	} else if (__timeout) {
+		__timeout->tv_sec = to.tv_sec;
+		__timeout->tv_usec = to.tv_nsec / 1000;
+	}
 
 	if (err >= 0)
 		return err;

-- 
2.39.5

