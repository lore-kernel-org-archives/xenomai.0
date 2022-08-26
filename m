Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74D23D3
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 07:32:41 +0000 (UTC)
Received: from [192.168.1.112] (176-93-227-37.bb.dnainternet.fi [176.93.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ilmai)
	by meesny.iki.fi (Postfix) with ESMTPSA id 40E3F203D5
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 10:32:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1661499152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PL5pt1WCaRDaNgC8DRYqbY9ZkFLkOrvXHxIP2wUoekk=;
	b=YD8c2PBSnTQPg3qxk1KnfeaJXKLK7tg9AChXd/3nK3ywAYWAKjGqsFA7NzHOnadXqHjJiK
	lFkrERNufu1RDeRmLRiIDAkey6WQPieVjiCg24JIams7IQqQ8/bcsOK9LuLCvWCqcedavR
	+C983f9pYWOEYS0fl0KXNbThx82P16A=
To: xenomai@lists.linux.dev
From: Jussi Viiri <ilmai@iki.fi>
Subject: [PATCH] revl: Mutex shouldn't require locked objects to have the Sync
 trait
Message-ID: <88f92512-a51e-7428-2c6a-926d7fa2ecbf@iki.fi>
Date: Fri, 26 Aug 2022 10:32:30 +0300
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
	s=meesny; t=1661499152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PL5pt1WCaRDaNgC8DRYqbY9ZkFLkOrvXHxIP2wUoekk=;
	b=LWH9G+u8EDYoNngEiNY1TKM8h3TNluhyXj4gF/+PYZhLB1JJIYm+XcmNDHI5Bta5J5cuDZ
	dHJW90qtSveXKQjT6sgMhrJMcdouySG7gt3eWas/0F98+ti1a1tc4XkAZEWKJTVFzZ30sg
	+xjgpc3yXRwr5XqRXfc7BozRJDe/nug=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ilmai smtp.mailfrom=ilmai@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1661499152; a=rsa-sha256; cv=none;
	b=SgVT29FSRYP32DnO6fcuNv6XjoIlhizArbyGEK+gojr6MnnWG++vOMkvie5r9+lDQ3PAIV
	NVplx1TUKfmZD26kmojhH5z5dtb+a46QKNaCvHvdA0Lvku72p+Jsbyn+cryzPpWflBHlHU
	gBPk9ww5w7Aa1g1smYJPAqqEV8lLmgw=

As said in the title, Mutex shouldn't require locked objects to have the 
Sync trait. The point of the Mutex object is to provide that trait by 
wrapping an object.
Used ?Sized + Send like std::sync::Mutex instead.

Signed-off-by: Jussi Viiri <ilmai@iki.fi>

---

 From 04c362a8239a71a516fb7405e3720d4cf25951dd Mon Sep 17 00:00:00 2001
From: Jussi Viiri <ilmai@iki.fi>
Date: Fri, 26 Aug 2022 10:29:04 +0300
Subject: [PATCH 4/4] Mutex shouldn't require locked objects to have the Sync
  trait

---
  src/mutex.rs | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mutex.rs b/src/mutex.rs
index 57e1670..af58d40 100644
--- a/src/mutex.rs
+++ b/src/mutex.rs
@@ -139,8 +139,8 @@ pub struct Mutex<T: ?Sized> {
      data: UnsafeCell<T>,
  }

-unsafe impl<T: Sync + Send> Send for Mutex<T> {}
-unsafe impl<T: Sync + Send> Sync for Mutex<T> {}
+unsafe impl<T: ?Sized + Send> Send for Mutex<T> {}
+unsafe impl<T: ?Sized + Send> Sync for Mutex<T> {}

  impl<T> Mutex<T> {
      /// Create a new mutex for guarding `data`, using the properties
-- 
2.25.1


