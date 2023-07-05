Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C62137F
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:36 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202307050638263b8d1b8a22654ebf35
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7gb47Y7X10kd03CksnhjllqCp4hs0yxziQIyAn+0GqY=;
 b=EUCpiNC6DhHGo7SbNZVuQacWBWv4DjW5SCnNKdv09GC9jdJ31jaafR0LASIMVOJU3vToP3
 RfDs/g+QNFpUzg170ZMiBeFt91wfPym8NFqaj67PH1Efy+Za3XLHDZTR9Ox7G/wEq206DQWz
 PiE/19W6nTEaQjpHisVGrnjyIgC6Y=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:28 +0200
Subject: [PATCH 06/12] y2038: cobalt/uapi: Align memory layout for time64
 related types
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-6-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When turning on time64 support the memory layout of
struct sched_param_ex (used by userspace in any case) and the "shadow
type" (struct sched_param_ex64, used by time64 related entry points)
have to match.

Simplified example for different memory layout (offsets) of
struct sched_param_ex:

                                           offset 32 bit   offset 64 bit
struct sched_param_ex {
	int               sched_prio;           0                0
	struct timespec   __sched_ss_param;     4                8
	...
};

With padding we get

struct sched_param_ex {
	int               sched_prio;           0                0
	struct timespec   __sched_ss_param;     8                8
	...
};

This is a backward compatibility breaking change. Incrementing the
Xenomai ABI revision on all supported architectures to express that.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/compat.h                               | 4 ++++
 include/cobalt/uapi/sched.h                                  | 4 ++++
 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h   | 2 +-
 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
 kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h   | 2 +-
 kernel/cobalt/posix/thread.h                                 | 3 +++
 6 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index f2dce74b4..71010e3a9 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -30,9 +30,11 @@ struct sched_param_ex64;
 
 struct __compat_sched_ss_param {
 	int __sched_low_priority;
+	int: 32;
 	struct old_timespec32 __sched_repl_period;
 	struct old_timespec32 __sched_init_budget;
 	int __sched_max_repl;
+	int: 32;
 };
 
 struct __compat_sched_rr_param {
@@ -41,6 +43,7 @@ struct __compat_sched_rr_param {
 
 struct compat_sched_param_ex {
 	int sched_priority;
+	int: 32;
 	union {
 		struct __compat_sched_ss_param ss;
 		struct __compat_sched_rr_param rr;
@@ -60,6 +63,7 @@ struct compat_sched_tp_window {
 	struct old_timespec32 offset;
 	struct old_timespec32 duration;
 	int ptid;
+	int: 32;
 };
 
 struct __compat_sched_config_tp {
diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
index 730456d89..4081fbc0e 100644
--- a/include/cobalt/uapi/sched.h
+++ b/include/cobalt/uapi/sched.h
@@ -39,9 +39,11 @@
 
 struct __sched_ss_param {
 	int __sched_low_priority;
+	int: 32;
 	struct xntimespec __sched_repl_period;
 	struct xntimespec __sched_init_budget;
 	int __sched_max_repl;
+	int: 32;
 };
 
 #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
@@ -63,6 +65,7 @@ struct sched_tp_window {
 	struct xntimespec offset;
 	struct xntimespec duration;
 	int ptid;
+	int: 32;
 };
 
 enum {
@@ -128,6 +131,7 @@ struct __sched_config_quota {
 
 struct sched_param_ex {
 	int sched_priority;
+	int: 32;
 	union {
 		struct __sched_ss_param ss;
 		struct __sched_rr_param rr;
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
index 43b7afb10..fdd5c0e32 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   18UL
+#define XENOMAI_ABI_REV   19UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index b98a96392..301797748 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   2UL
+#define XENOMAI_ABI_REV   3UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
index 65f8164a0..045adf0c1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
@@ -19,7 +19,7 @@
 #define _COBALT_X86_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   18UL
+#define XENOMAI_ABI_REV   19UL
 
 #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
 
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index fb4306351..f663acde7 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -114,9 +114,11 @@ struct cobalt_sigwait_context {
 
 struct __sched_ss_param64 {
 	int __sched_low_priority;
+	int: 32;
 	struct __kernel_timespec __sched_repl_period;
 	struct __kernel_timespec __sched_init_budget;
 	int __sched_max_repl;
+	int: 32;
 };
 
 struct __sched_rr_param64 {
@@ -125,6 +127,7 @@ struct __sched_rr_param64 {
 
 struct sched_param_ex64 {
 	int sched_priority;
+	int: 32;
 	union {
 		struct __sched_ss_param64 ss;
 		struct __sched_rr_param64 rr;

-- 
2.39.2

