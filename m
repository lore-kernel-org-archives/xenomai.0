Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE885CA0
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 20:07:27 +0000 (UTC)
Received: from [192.168.1.112] (87-95-52-126.bb.dnainternet.fi [87.95.52.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ilmai)
	by meesny.iki.fi (Postfix) with ESMTPSA id 127492008B
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 22:57:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1661284675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z90bg8AJBT/+4JotkNmXxyUwsuaKSVO7jKEUUg53r14=;
	b=IAnrCO3GrKJi+/PWBS875DHITbxPPjkS35Rp9VhOy/zabeDRlhRIjboFhLWrfynlS0vEG9
	AAyfvazT7BRZDhhkYvmq724+QsUhrWfGra7vHjbAn7HOvghCcjGO8TaJ7fb0IuS67JOHng
	DpGUPZWDXYL9k2/dWTjKlmCxB0asbjQ=
To: xenomai@lists.linux.dev
From: Jussi Viiri <ilmai@iki.fi>
Subject: [PATCH] revl: Add empty Send + Sync implementations for Event
Message-ID: <0990af90-25f5-fdb7-8438-3d65d7dfe528@iki.fi>
Date: Tue, 23 Aug 2022 22:57:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 PostboxApp/7.0.56
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1661284675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z90bg8AJBT/+4JotkNmXxyUwsuaKSVO7jKEUUg53r14=;
	b=vzDarTpWtIXp8yDW5bKJM/I6h4DEujFgDQU0KWA3GbtNOR+BRgFiVu1tnf6i6raZmvJDwO
	6rOwUf8ISge12iun8685gCLfGIghMXI0Currme5buzxx6xhDFduoCyIAwb+vE1vqHxZLtX
	POdh8Vxp/Lg1WVE68Q/woOghus7dT4U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ilmai smtp.mailfrom=ilmai@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1661284675; a=rsa-sha256; cv=none;
	b=XQJXMfhYuuudLpOlF+lDebAJeXcUEX4qSRxYFqGNd4lHNl6pEN2vhDQI/KIVm1borY0psk
	27u3EpqoBZ2B2xAEp7/7J7UjKppFjACUHP16FZ6d92HkAIg5qipGKCFrMiObCs/oMzDg04
	gqN8ZiDFotmifnJPpBoukzIVIldYflQ=

Event wasn't safe to send across threads. Fixed.

---

 From 0782e7d6c5f9189fe85f8f340721e1bcec3d16b2 Mon Sep 17 00:00:00 2001
From: Jussi Viiri <ilmai@iki.fi>
Date: Tue, 23 Aug 2022 22:49:01 +0300
Subject: [PATCH 3/3] Add empty Send + Sync implementations for Event

---
  src/event.rs | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/src/event.rs b/src/event.rs
index 7fdfd23..f469c43 100644
--- a/src/event.rs
+++ b/src/event.rs
@@ -76,6 +76,9 @@ impl WaitTimeoutResult {

  pub struct Event(UnsafeCell<evl_event>);

+unsafe impl Send for Event {}
+unsafe impl Sync for Event {}
+
  impl Event {
      pub fn new(builder: Builder) -> Result<Self, Error> {
          let this = Self(UnsafeCell::new(unsafe {
--
2.25.1
