Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053E168A1
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:34 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023050808132518d14f4feec8980b50
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GvcmMPLcqZqHRMqbDotcwJCVxNiUIwQ9o9NG4yQ9SLA=;
 b=Mvi9nLedKyt+5oC9B9AQqLRH/PMF0pgb2v73bYRDlyP3OafqoyKYTligcv+Qzr4BhXgyMA
 p5kFVzkuojkdyfzkoSEwAUz1spocK18895O1iODQ77j6FnCL79xm1hiHBDaMj43UFBNq5yGt
 +ShikL8BtvNHAsXkLB15bS/UeqtRI=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:23 +0200
Subject: [PATCH 01/13] y2038: cobalt: Introduce some itimerspec64 related
 helpers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-1-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The introduced helpers will be used by the timer and timerfd y2038
related services for reading/writing itimerspec from/to userspace.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/time.h | 21 +++++++++++++++++++++
 kernel/cobalt/time.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
index a55398068..e348cf9b8 100644
--- a/include/cobalt/kernel/time.h
+++ b/include/cobalt/kernel/time.h
@@ -28,4 +28,25 @@ int cobalt_get_timespec64(struct timespec64 *ts,
 int cobalt_put_timespec64(const struct timespec64 *ts,
 			  struct __kernel_timespec __user *uts);
 
+/**
+ * Read struct __kernel_itimerspec from userspace and convert to
+ * struct itimerspec64
+ *
+ * @param dst The destination, will be filled
+ * @param src The source, provided by an application
+ * @return 0 on success, -EFAULT otherwise
+ */
+int cobalt_get_itimerspec64(struct itimerspec64 *dst,
+			    const struct __kernel_itimerspec __user *src);
+
+/**
+ * Convert struct itimerspec64 to struct __kernel_itimerspec and copy to user
+ * space
+ * @param dst The destination, will be filled, provided by an application
+ * @param src The source, provided by the kernel
+ * @return 0 un success, -EFAULT otherwise
+ */
+int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
+			    const struct itimerspec64 *src);
+
 #endif //_COBALT_KERNEL_TIME_H
diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
index 27dbf8290..716223dc5 100644
--- a/kernel/cobalt/time.c
+++ b/kernel/cobalt/time.c
@@ -36,3 +36,41 @@ int cobalt_put_timespec64(const struct timespec64 *ts,
 
 	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
 }
+
+int cobalt_get_itimerspec64(struct itimerspec64 *dst,
+			    const struct __kernel_itimerspec __user *src)
+{
+	struct timespec64 interval, value;
+	int ret;
+
+	if (!src)
+		return -EFAULT;
+
+	ret = cobalt_get_timespec64(&interval, &src->it_interval);
+	if (ret)
+		return ret;
+
+	ret = cobalt_get_timespec64(&value, &src->it_value);
+	if (ret)
+		return ret;
+
+	dst->it_interval.tv_sec = interval.tv_sec;
+	dst->it_interval.tv_nsec = interval.tv_nsec;
+	dst->it_value.tv_sec = value.tv_sec;
+	dst->it_value.tv_nsec = value.tv_nsec;
+
+	return 0;
+}
+
+int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
+			    const struct itimerspec64 *src)
+{
+	struct __kernel_itimerspec kits = {
+		.it_interval.tv_sec = src->it_interval.tv_sec,
+		.it_interval.tv_nsec = src->it_interval.tv_nsec,
+		.it_value.tv_sec = src->it_value.tv_sec,
+		.it_value.tv_nsec = src->it_value.tv_nsec
+	};
+
+	return cobalt_copy_to_user(dst, &kits, sizeof(kits));
+}

-- 
2.39.2

