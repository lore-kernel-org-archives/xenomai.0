Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C533CC
	for <xenomai@lists.linux.dev>; Tue, 16 Aug 2022 09:47:53 +0000 (UTC)
Received: from [192.168.1.112] (176-93-241-122.bb.dnainternet.fi [176.93.241.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ilmai)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5A3A81B002D7
	for <xenomai@lists.linux.dev>; Tue, 16 Aug 2022 12:47:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1660643271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5tKVH2b+OsshBUpAIBSeHbftbeDk5X5Cw7chvKRTcSc=;
	b=pn9DD9tcLf5KLki/SV62oHVo3QcMTlLrDLKXX3AuvEkEs9B99WDqvUDNLRwJa5DOEF57Wi
	NG3IWm9u9IsBuEOKqL8BNM6ylFAKo6CtdTXnXihN7bpzdVzITDv8ZvMZ7IRO7Uq4lXKbti
	MxhPhyd9XXCd42XXfJCC37BkPK79aSiR+qxmfXIjIiBRIMj7BX0B7ZQAntuH9pW5TyoZmX
	190cEPDMOICIHMqn96LFH3rfT9Q5vv/bNrr08W4E/I1LTd2Er/futF9v8S/SE4GPaqdqDk
	3bJvgjkYWZL2xoEQyfeXpMF/TtkQN5aJnly3BYVPD3SIQxdx1NjeJRWtEjdS0A==
To: xenomai@lists.linux.dev
From: Jussi Viiri <ilmai@iki.fi>
Subject: [PATCH] Update evl-sys to 0.22.2 in revl
Message-ID: <72acdb53-ae99-224f-3743-61a03768b9e2@iki.fi>
Date: Tue, 16 Aug 2022 12:47:49 +0300
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
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1660643271; a=rsa-sha256;
	cv=none;
	b=hDzA/Ry0/j2PSeuofTjyeZRy2LTgqbL+a6sTlenwP+ypE7aq4OE6tKIuH6UDESwHR67QB4
	Z30661FLp0D6ur6ujrfd8Giy5DMegvebFu5ORvXOSjb6RAA7SkEFRu/bIfo5m8LKv9aAMd
	H8Ibqg09kGeXhkU7b9hbdSlrOL8PSJS+zzj+7PIE4zrfNn7guF+Ud6+dNOL8AM7VYwVE4X
	6Ix08HECa7vyW2UowwGJyqJfrtbna8c4MOkDq51zk7alALR3bPK5IZZuBl7DXHL/tqmnXQ
	SB8u1XrAZlE1MpfIZPKlPrGfqp1CM4cuh9PAH7ESA+/cFPndtVvbyxAlLHV+2g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ilmai smtp.mailfrom=ilmai@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1660643271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5tKVH2b+OsshBUpAIBSeHbftbeDk5X5Cw7chvKRTcSc=;
	b=bg1eZhZybAEWEWYDmdVXpva9br4o4hiFQSHHcx5UlkEh/fJHEYm+QzD68Rvd9r3Mb/f4UW
	+f5c1R908w59IurZ5yAzILAKEy5pu2jG0vlEko8cFbcx95qD01AG+1dP9GC+cAmMfH2ig+
	gz56AzEImtEPWW0a74F9XPDA/4yIyDLHJhw6lB/9nhwlEsigN8iLt4AKGwnBZ9axsE7T9n
	Gs9m3pD+uGdxMsneU5NJQSjy0+e7fNBa8sNjaKLLpQ7fNmHLF4gSM8OcMCBUndOa3XYwPL
	pvcjkK9+dlroWOR1zW4enl7NbUwVXhevPqTgOrANMrIx5gWDhPYE/QGNMqMKLA==

revl doesn't build anymore since evl-sys has been updated to 0.22.2. Fixed.

---

 From ff1dc49ccf531013a96b7feff5d595783b9115c6 Mon Sep 17 00:00:00 2001
From: Jussi Viiri <ilmai@iki.fi>
Date: Tue, 16 Aug 2022 12:19:56 +0300
Subject: [PATCH] Update evl-sys to 0.22.2

---
  Cargo.toml | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Cargo.toml b/Cargo.toml
index a6662c8..420f311 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -6,4 +6,4 @@ edition = "2021"
  [dependencies]
  libc = "~0.2"
  embedded-time = "~0.12"
-evl-sys = { version = "^0.20.2", git = 
"https://source.denx.de/Xenomai/xenomai4/evl-sys" }
+evl-sys = { version = "^0.22.2", git = 
"https://source.denx.de/Xenomai/xenomai4/evl-sys" }
--
2.25.1
