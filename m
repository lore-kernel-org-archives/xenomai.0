Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77737FF70
	for <xenomai@lists.linux.dev>; Tue, 18 Aug 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065701; cv=none; b=BAaWE2MvR2UOvKzFnbnOtUx+zvHBwyZJKrcPiyWDHtHD1URCw02yKmppruEakBRfmHrhl8iFlh/i5/fCUcNjxp9jDSlBpq/SnlnJgYAv1222MtLlWq4P4SM4/3+0j5DVWXN3ZCjdbwK3e56EGDXnflGQlqF+p9FPw19YnHlbAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065701; c=relaxed/simple;
	bh=MBi03QJNArdVmeVSLb4OOWl2MZmbZ3h/LNzR3yYR9Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bWxa+8HGLgBO3Yn5Ktiaaie+Yrw9ZYdF7Oivf6Oqo9mM3bdL2UZ+AizxHAClJ88/2mjIKu0nHSro5rqmLGVOEKxM+ml9BXFnl9MPRn+6L7KKG+8+jhQEuDx6awIwlK8+qUDSVUwX3sx9m9IUpRWTpbK04GLVX4SmSsDdkGhQUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JvwgxPRk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JvwgxPRk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C3203ECEA;
	Tue, 18 Aug 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1787065690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpaMCmryB71PdkryMbjkL0YRq+75eXJABoTKD6sins8=;
	b=JvwgxPRkT9qgdfI1pBpbT48MtmfVqA72CKpp9n/KI4qDbQiVxaYuj+z96ODJ/ODwVQ4rq6
	9cN6ZygZFYmkAEIDh9uGGG9+AAOvSwXtAAdj9m2vZWET8NXJFnhuwWlQgw/QKYxLPUqi9D
	ODffxjt51w3HxS5J4xRMWWSLNFxmUE1rG9DC7W/DDrL0FNBZnYxA73GiBr6E8agoJzKL0T
	jTIdR+xSiWSsj0a+RqfVQDTwh0bCKiu7+CWVVJhyCtnoHw6Z3c9tLy60gFW5EHgG6a+obj
	5o8cgCNXuU1K7rakcMxV8HDaNG4sKeZEZVzSFXUzGe/l8qSJBW5rcsRCnFPX0Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
In-Reply-To: <CAKndYJGm0Ne6_fMkrNmQoE92LZmSghyH23CYmht0Ogs-obRH1A@mail.gmail.com>
	(Gerte Hoogewerf's message of "Tue, 18 Aug 2026 06:35:42 +0200")
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
	<87v799kt2q.fsf@xenomai.org>
	<CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
	<b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com>
	<CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
	<87bjb0lqob.fsf@xenomai.org>
	<CAKndYJGm0Ne6_fMkrNmQoE92LZmSghyH23CYmht0Ogs-obRH1A@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 18 Aug 2026 17:08:08 +0200
Message-ID: <87ecfv31rb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGREn3+/9naU3bGF6zCkZonUx4dXj0WLByDUBR28L0N2x73jyX8ydqBbZZ5xYQmJ2Ms83RG0e42SDsFY0OILT52POAg9Kt4JgNH5m5UDRoXmZHi20ZvQQouTNxjvGmx7RF/xRDbZ1OgDcH+kxh65X8j4taP2tlVPPXqYXrQOCcBPRWKmugBT2QeHv3uv67Wd9fZ3AToyBUzIEzGrDLDYSJxaaTTfmLsjeSAIYoEFRAdf4HuFTSPIHtprckzUqIMA9vEkG7YPQyLxEU5GPFECkjP7RBB0PP8kbh/0uu2AO+l8knMD1q3C74mio28J3YAGTiIWo0ndC5QDSH5OGCz6s4WW0Z53S5bgupmUJSXojuGfgp2pi36oM6HtbG4fij3YRa7UZIEuJYiJF3gbpQGhWq7fN3gPcTmtLXhJcFvEXi67Ii/lCyGPIrMJinPEAwmE3rusxfuNKBKduDlvyUHKWRG6EHrrVfoAsWeFy7FStXbjlqmxfOnWoYAC2NS7e22TY5gM/jGCy0GtgkHNHmloedDKX6Stg1KJCwbzscjNVqNBEqaHqWAL5V40bpxrjwG7pzEENI8HYxjLWRI0K/Qw0pQft3zctKwls8TMhflfTCIoOjvhET1NSqVqefJvkohDb7mDktMZDLfbslK+A7JXdMSrUlw6jel+aQy1i/yWfmGuA
X-GND-State: clean
X-GND-Score: -100

Gerte Hoogewerf <ghoogewerf@lmi3d.com> writes:

> Hi Jan/Philippe,
>
> Philippe wrote:
>> [..] the following patch allows the socfpga to boot, could you please try it on the Zynq?
>
> Thanks for the patch. That patch doesn't make it better or worse; it's
> an orthogonal problem and my configuration wasn't affected by it.
>
> Jan wrote:
>> That would indeed be welcome already.
>
> We will try to participate.
>
>> [..] I had to manually enable CONFIG_VDSO
>
> Noted. Thanks for the tip.
>
> With a bit of AI research, I landed on something that fixes the
> problem for me on "smp_twd" with CONFIG_SMP=y. I'll share the attached
> patch to provide further insight into the problem. It may not be the
> best candidate for direct adoption, but hopefully it'll shed some
> light on the problem.
>
> Furthermore, here's the AI's explanation:
>
>> On Zynq-7000, smp_twd.c sets CLOCK_EVT_FEAT_C3STOP on the TWD unless the DT node
>> has "always-on". With no broadcast device registered, tick_is_oneshot_available() never
>> returns true, so Linux never switches that CPU to oneshot; and tick_install_proxy() just
>> reads td->mode rather than forcing the switch, so the EVL proxy inherits periodic mode too
>> and the in-band relay never gets armed. Jiffies freeze silently until the first real timed sleep
>> hangs forever.
>
> For me, the "timed sleep" involved a network driver toggling the PHY
> reset.  It was asking the kernel for a one second delay (via
> "jiffies"), while jiffies was basically stuck. This is why our
> original boot attempts never reached userland.
>

Ok, makes sense. There is no reason for the proxy timer to inherit the
C3STOP misfeature in the first place, since we are going to use it for
high-accuracy timing, and playing stop-and-go with the timer chip is
certainly not the best way to do this. The evl core already prevents the
idle mode to enter C3STOP, but as you pointed out, we also need the
timer core to always pick oneshot mode for the proxy, which was
overlooked.

Could you try this patch, without the dts fixup, and let us know of the
outcome?

diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
index 5a877987a84e4..6d2b7a860d230 100644
--- a/kernel/time/tick-proxy.c
+++ b/kernel/time/tick-proxy.c
@@ -229,13 +229,16 @@ int tick_setup_proxy(struct clock_proxy_device *dev)
 
 	/*
 	 * Inherit the feature bits since the proxy device has the
-	 * same capabilities than the real one we are overriding
-	 * (including CLOCK_EVT_FEAT_C3STOP if present).
+	 * same capabilities than the real one we are overriding,
+	 * except for C3STOP which is omitted to prevent the timer
+	 * core from fully disabling oneshot mode if no
+	 * oneshot-capable broadcast device is available either.
 	 */
 	proxy_dev = &dev->proxy_device;
 	memset(proxy_dev, 0, sizeof(*proxy_dev));
-	proxy_dev->features = real_dev->features |
-		CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_PROXY;
+	proxy_dev->features = (real_dev->features |
+			CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_PROXY)
+		& ~CLOCK_EVT_FEAT_C3STOP;
 	proxy_dev->name = "proxy";
 	proxy_dev->irq = real_dev->irq;
 	proxy_dev->bound_on = -1;

-- 
Philippe.
