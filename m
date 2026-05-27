Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222C31E84B
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890879; cv=none; b=bA9m/G+xK+Jm3UKp6u2lg/laM2HPQCPSTWcI6XXkaFotErt7ojuEopH+HrQWqw+O7vZCsmZWKm3HiOHkBWUAsP2a/7S8UAr2/AxPtc53iIyuJ4RGUkyoBCar4oOMJO9tljhld2oKvezpNG1CURKkyOSogi6TVykVK0dMeETfqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890879; c=relaxed/simple;
	bh=t9kc/s1SjwO/GVBQiM+KA2Sa+c3dOCbZkwXbfSLwM04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuZ+A44Mhynuteg1V6ZF/2f0h0X0tgbKz0MH+dLPXhdsbjbJxczPtFt4Aa+sXOvM4PiaMTMD8S8z4pNgwrFtPR7YgOUjDalurK1yaRuACW3y7t99AFUPNnS8Uv5qxvGwwAl51DFlzkfdAqzz6knVSL6d29N9qoW9U5xclqxYHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WiJjp/EW; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WiJjp/EW"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260527140745774f5604c8000207da
        for <xenomai@lists.linux.dev>;
        Wed, 27 May 2026 16:07:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KoB3akbulm+NZpurVi3SlWGC2TpTSMp5Cqaxvq2lJ9M=;
 b=WiJjp/EWRloltk2vK9Aj9ClVK8rPy/Se3hM8fZ53k2FlW2fssHhPaoBTLf0WMbnORovd11
 y9C1KP+A3mzHHmwEG6WCyiW6HSaJ9/3VPPiupNTgr7/Yu7lxewKzio+Ce6yJpE1k8JWh4Qyg
 PrC26ryNfpiibTrE03LNZ9Y3vqril1bbyjBQQkM/EOBzeEefa5NwDJ1CSam/Vb+o1t2LI+B8
 z52+Z/+MJxv6AZ49HR/gcjVgeGhVULnC6/CZSb61U32sEE66ed+84Zm17LrpAur0MPHQQ9Xn
 npCFu0dFyytP3Ty4VMHK4MPLOeruWVKQoYRLlFWGnr0hvsV15QYOvu1A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 May 2026 16:07:38 +0200
Subject: [PATCH 2/2] cobalt/tick: Prepare for removal of
 CLOCK_EVT_FEAT_KTIME in Linux 7.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-wip-flo-7-1-preparations-v1-2-b65d1304bb6b@siemens.com>
References: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
In-Reply-To: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

upstream commit
70802807398c ("clockevents: Remove redundant CLOCK_EVT_FEAT_KTIME")
removed CLOCK_EVT_FEAT_KTIME. All remaining users have been migrated
to CLOCK_EVT_FEAT_HRTIMER which we do now as well.

CLOCK_EVT_FEAT_HRTIMER has been around for a long time, but there is
still one difference that changed with the commit referenced above.
That means that we can not migrate to CLOCK_EVT_FEAT_HRTIMER
unconditionally. Older Dovetail versions need the old implementation.

This patch has to reach all Xenomai branches that should support
Dovetail 7.1 and newer.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/dovetail/tick.c                        | 4 ++--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 889d9bfc85df6e8500f8cf9fb617edd17c44c1db..59880a6db1a1f40fcdeef9d2e6738a8b0b8ec17f 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -34,7 +34,7 @@ void pipeline_set_timer_shot(unsigned long delay) /* ns */
 	ktime_t t;
 	int ret;
 
-	if (real_dev->features & CLOCK_EVT_FEAT_KTIME) {
+	if (real_dev->features & COBALT_CLOCK_EVT_FEAT_HRTIMER) {
 		t = ktime_add(delay, xnclock_core_read_raw());
 		real_dev->set_next_ktime(t, real_dev);
 	} else {
@@ -125,7 +125,7 @@ static void setup_proxy(struct clock_proxy_device *dev)
 
 	dev->handle_oob_event = (typeof(dev->handle_oob_event))
 		xnintr_core_clock_handler;
-	proxy_dev->features |= CLOCK_EVT_FEAT_KTIME;
+	proxy_dev->features |= COBALT_CLOCK_EVT_FEAT_HRTIMER;
 	proxy_dev->set_next_ktime = proxy_set_next_ktime;
 	if (proxy_dev->set_state_oneshot_stopped)
 		proxy_dev->set_state_oneshot_stopped = proxy_set_oneshot_stopped;
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 27e641fa7f9178229e0616e4de64b0e267910915..838e01327f5fd158ddd9383d000724f527465153 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -91,4 +91,10 @@
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(7, 1, 0)
+#define COBALT_CLOCK_EVT_FEAT_HRTIMER	CLOCK_EVT_FEAT_KTIME
+#else
+#define COBALT_CLOCK_EVT_FEAT_HRTIMER	CLOCK_EVT_FEAT_HRTIMER
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */

-- 
2.54.0

