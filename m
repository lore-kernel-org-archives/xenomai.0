Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC066AAD
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:29:53 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202308010929454e2df134b7d33b48ad
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 11:29:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=v+68JgR15UsEyA0Gxr6jycaV6ASSvSkz3m9DIDg2JXw=;
 b=cW22x/3+llTG2qsKFhLaN65j98BUHVT7amymMo1Y0U2My3V4YPTBszA4Va9rkbNwvZLP8A
 wTdkHiJiWA9LO4vqAQwocMy/vLDZhbTlLVA/xEBcu/jjXhPSY7DbyQn/pUxzPeaaoPtBlQiE
 /Cep087gyta609w2IT5c9jJ8TKnGQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 01 Aug 2023 11:29:39 +0200
Subject: [PATCH v3 5/7] cobalt/uapi: Move to data types with fixed sizes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v3-5-2aea39ad909a@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

While making the Xenomai thread and sched UAPI y2038 safe a valid point
came up during review phase: We assume that int is 32 bit.

This assumption is currently true for all supported platforms but to
be correct we should use the corresponding kernel data types with fixed
sizes.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/event.h  |  6 +++---
 include/cobalt/uapi/sched.h  | 38 +++++++++++++++++++-------------------
 include/cobalt/uapi/sem.h    |  6 +++---
 include/cobalt/uapi/thread.h |  4 ++--
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/cobalt/uapi/event.h b/include/cobalt/uapi/event.h
index 8710e8e25..5abf55632 100644
--- a/include/cobalt/uapi/event.h
+++ b/include/cobalt/uapi/event.h
@@ -45,9 +45,9 @@ struct cobalt_event_shadow {
 };
 
 struct cobalt_event_info {
-	unsigned int value;
-	int flags;
-	int nrwait;
+	__u32 value;
+	__s32 flags;
+	__s32 nrwait;
 };
 
 typedef struct cobalt_event_shadow cobalt_event_t;
diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
index 6b1639feb..4fe1d8ee9 100644
--- a/include/cobalt/uapi/sched.h
+++ b/include/cobalt/uapi/sched.h
@@ -32,11 +32,11 @@
 #endif	/* !SCHED_SPORADIC */
 
 struct __sched_ss_param {
-	int __sched_low_priority;
+	__s32 __sched_low_priority;
 	int: 32;
 	struct xn_ts64 __sched_repl_period;
 	struct xn_ts64 __sched_init_budget;
-	int __sched_max_repl;
+	__s32 __sched_max_repl;
 	int: 32;
 };
 
@@ -52,13 +52,13 @@ struct __sched_rr_param {
 #endif	/* !SCHED_TP */
 
 struct __sched_tp_param {
-	int __sched_partition;
+	__s32 __sched_partition;
 };
 
 struct sched_tp_window {
 	struct xn_ts64 offset;
 	struct xn_ts64 duration;
-	int ptid;
+	__s32 ptid;
 	int: 32;
 };
 
@@ -70,8 +70,8 @@ enum {
 };
 	
 struct __sched_config_tp {
-	int op;
-	int nr_windows;
+	__s32 op;
+	__s32 nr_windows;
 	struct sched_tp_window windows[0];
 };
 
@@ -84,7 +84,7 @@ struct __sched_config_tp {
 #endif	/* !SCHED_QUOTA */
 
 struct __sched_quota_param {
-	int __sched_group;
+	__s32 __sched_group;
 };
 
 enum {
@@ -96,35 +96,35 @@ enum {
 };
 
 struct __sched_config_quota {
-	int op;
+	__s32 op;
 	union {
 		struct {
-			int pshared;
+			__s32 pshared;
 		} add;
 		struct {
-			int tgid;
+			__s32 tgid;
 		} remove;
 		struct {
-			int tgid;
-			int quota;
-			int quota_peak;
+			__s32 tgid;
+			__s32 quota;
+			__s32 quota_peak;
 		} set;
 		struct {
-			int tgid;
+			__s32 tgid;
 		} get;
 	};
 	struct __sched_quota_info {
-		int tgid;
-		int quota;
-		int quota_peak;
-		int quota_sum;
+		__s32 tgid;
+		__s32 quota;
+		__s32 quota_peak;
+		__s32 quota_sum;
 	} info;
 };
 
 #define sched_quota_confsz()  sizeof(struct __sched_config_quota)
 
 struct sched_param_ex {
-	int sched_priority;
+	__s32 sched_priority;
 	int: 32;
 	union {
 		struct __sched_ss_param ss;
diff --git a/include/cobalt/uapi/sem.h b/include/cobalt/uapi/sem.h
index 01a9b552f..ae8e967a9 100644
--- a/include/cobalt/uapi/sem.h
+++ b/include/cobalt/uapi/sem.h
@@ -40,9 +40,9 @@ union cobalt_sem_union {
 };
 
 struct cobalt_sem_info {
-	unsigned int value;
-	int flags;
-	int nrwait;
+	__u32 value;
+	__s32 flags;
+	__s32 nrwait;
 };
 
 #define SEM_FIFO       0x1
diff --git a/include/cobalt/uapi/thread.h b/include/cobalt/uapi/thread.h
index 07602db9f..3facbfb99 100644
--- a/include/cobalt/uapi/thread.h
+++ b/include/cobalt/uapi/thread.h
@@ -46,8 +46,8 @@ struct cobalt_threadstat {
 	__u64 xsc;
 	__u32 status;
 	__u32 pf;
-	int cpu;
-	int cprio;
+	__s32 cpu;
+	__s32 cprio;
 	char name[XNOBJECT_NAME_LEN];
 	char personality[XNOBJECT_NAME_LEN];
 };

-- 
2.39.2

