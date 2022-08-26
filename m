Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE652560
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 07:55:58 +0000 (UTC)
Received: from [192.168.1.112] (176-93-227-37.bb.dnainternet.fi [176.93.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ilmai)
	by meesny.iki.fi (Postfix) with ESMTPSA id 8ABCF203BE
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 10:55:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1661500556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrWT9wu5G/OLRZmiM/tsbSVhRhO7S3AUdVgNGVGmUx0=;
	b=j3FHBqy5uHGm6K7NHhGKphGxikl5hh0XK7PQxrBfbYnsTAJ5XoIGNGaaaQ1oB9TUzsrcBw
	UvUrbKa63TkKUV8/+OipKpw8irkmKesl5Ud5DBZdCFONs6/s/Bfaiaa91iCQPXPvSQXcMC
	00ZguvbEQE7+yHk1PcYZ5oHKzM/KKJ4=
From: Jussi Viiri <ilmai@iki.fi>
Subject: [PATCH] revl: Add empty Send + Sync implementations for Event
To: xenomai@lists.linux.dev
References: <0990af90-25f5-fdb7-8438-3d65d7dfe528@iki.fi>
 <cacc03cf-7bf6-2e48-caf1-63bbdd40b2aa@iki.fi>
Message-ID: <991bd323-c5b4-a9c4-a052-f30411e2c4a9@iki.fi>
Date: Fri, 26 Aug 2022 10:55:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 PostboxApp/7.0.56
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cacc03cf-7bf6-2e48-caf1-63bbdd40b2aa@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1661500556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrWT9wu5G/OLRZmiM/tsbSVhRhO7S3AUdVgNGVGmUx0=;
	b=XGtMOtMBi3J64ycfGKbF4ghxCE9XS2q0OcVvSlESECoctjwhMni7MMGG+3iBF2HCtaQaRx
	wx8v1vnW2gW9ldPEuBUqN552EVoz1HLruaC1PO/jU61emHzR503RA3d5OKDkdsqEpwTQRR
	y4J/BnsZdJBKwJd1dXgLriLzkIotaQc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ilmai smtp.mailfrom=ilmai@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1661500556; a=rsa-sha256; cv=none;
	b=NsWyPKtiENmg3Oe3p3rHdHp3igzxzrPUQWydzsd4NCHlkBwDOD9vNq1urp/zv6IIr8bW44
	/aX4KPGsGVn+L9OXzPoFyjHS76FmdDjyGp/pZf9skloJ2IS3KZcMAY2P3okG+cjJfxn1Gq
	t3Bh4f7O+q3ArX+rUgxr9/C/zJAQ9pU=

Event wasn't safe to send across threads. Fixed.

Signed-off-by: Jussi Viiri <ilmai@iki.fi>

---

From 0782e7d6c5f9189fe85f8f340721e1bcec3d16b2 Mon Sep 17 00:00:00 2001
From: Jussi Viiri <ilmai@iki.fi>
Date: Tue, 23 Aug 2022 22:49:01 +0300
Subject: [PATCH 3/3] Add empty Send + Sync implementations for Event

---
  src/event.rs | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/src/event.rs b/src/event.rs
index 7fdfd23..f469c43 100644
--- a/src/event.rs
+++ b/src/event.rs
@@ -76,6 +76,9 @@ impl WaitTimeoutResult {

  pub struct Event(UnsafeCell<evl_event>);

+unsafe impl Send for Event {}
+unsafe impl Sync for Event {}
+
  impl Event {
      pub fn new(builder: Builder) -> Result<Self, Error> {
          let this = Self(UnsafeCell::new(unsafe {
-- 
2.25.1
