Received: from flamingo.ash.relay.mailchannels.net (flamingo.ash.relay.mailchannels.net [23.83.222.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB13A7845
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949552; cv=pass; b=Z7qjGXTozJgTOPn3OmSYx54z8iit3hdNhQiuenRZxC7XT2wLRFSeGc9yioNb3pRC0nFQBkpFIlQZkL9sPAvBbIW8vVFv2uthYj5QL3VpHDknuGcYTnIpp2U/Pq/pEIJVYSjNDhHKvUC+mONUyfDsmijwrQrk6CbrODY40Gcth4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949552; c=relaxed/simple;
	bh=YqjZYku/e6JmGVZAn0o9uo+ujjcYTUMvEPVFGxHhDn4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jtognM/z9y4ZU1gWKuwBvWc1AiODebQui+I0LPiR6rhOm0u7OC/8QuewIcFPThikxljoXxsBKKaBENEW/IipBYjXZxxShSos/DZn9fthONEcai3WbGaTtAOQM5beCe5xqaX/IelCJT/i/B3fnroXxgHSGhFLv7DgN+5IwGrogIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=cBmPaEh9; arc=pass smtp.client-ip=23.83.222.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="cBmPaEh9"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 731D0163FA7;
	Tue, 24 Feb 2026 16:12:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.104.88.134])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C7047161F5D;
	Tue, 24 Feb 2026 16:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771949543;
	b=dvEaGn00pFtsSffYXA0NP1AFzicCn6GoueuMHnAjzwDWB9GSiXo9BxQxsyDCMlC7VVBr7o
	P0ucW3+yFvjK9PUBMg+B20DoRZEWDItzftVcYwtZaichtdnevX8RS85pUgv+e8PaaFywIA
	cC7mDfxmUelgK/kVjmlfdMVRjKpT7xqo/N/rFDqRPOFOaztBSsS6TDTxF16t2sgtYSywE3
	0gw4Ts2B/riZUNBoUAWh+0ObMqD2/6xfZYd3rqTfObuenyqf+g9ebZwvpR2MHJplgYFWwK
	6I10/dYaROwsLmGIYheucC5U7XGTIH0H/VjxS0RL5YAiqfhBeZICHTgw3AlXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771949543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YqjZYku/e6JmGVZAn0o9uo+ujjcYTUMvEPVFGxHhDn4=;
	b=ND0FjA9cmrlCJCii1JWmX3YbWudosnRpKJFd7b1tDK29C9s/ztV1PZ/ER/xEGmXuIuh0xA
	zBsHueX4aiGTKS0xFaLoilJzGLnayYbbSAWhh5+pLSERfO5ME6h8BUcjYeccxBozsBQlTU
	UZSFAx2KU1uG9CmOPGFSOyTgB6Wy8ERDV/HgdJQ7gXd2Ao4OIbf7RR7jCKtI8l/hVtwd7m
	zBaCekcSLs8DbaY63fT/ErjmtkwV35dNzMrwDbIKkNdmrNd9oQ9b+lZNjKgW57aiHPwzkj
	q3QNuVBIhUe5QedIQa3Apwe7EoaAaxXVksqHRAQxn1PkIxRHln3gOdpXqiRzbg==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-9zbl8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Harbor: 1e719841053c77c3_1771949544157_2209291218
X-MC-Loop-Signature: 1771949544157:476075137
X-MC-Ingress-Time: 1771949544157
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.88.134 (trex/7.1.3);
	Tue, 24 Feb 2026 16:12:24 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.59.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4fL2ml1k38z107X;
	Tue, 24 Feb 2026 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771949543;
	bh=YqjZYku/e6JmGVZAn0o9uo+ujjcYTUMvEPVFGxHhDn4=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=cBmPaEh9bjxcAF/76OQCAvphtqaUTR9/2/zYxMbJBioyw0/85qDd+2lA2Ngvck/iB
	 GEAIu9dQQz5SSAnM4le80Ti83p+5M5rAUJeiJc32CdmGlUeqABlVDOX+WbeAHYf+us
	 aAxlv/YRqMYbquFziLZmmFS08ikVM9f4nH9gqNgQqaPuL2LpX51Q2q+JMqAt79yZ6/
	 Cr8YW1hL82HZjb/wl6wWOlkmXLfoah2Dl0eT3C30TwSXke+sx+lUY7A4pFghfAB8a6
	 SiadinyRCI85a+dY2ErjhK//GAGmi2lLnRaUbKq5qsQlZH6UOeMBAAJNb8Mnonq7q/
	 D8bpwzI6MHoRA==
Subject: Re: evl ps cpu time reporting issue
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <21b140ef-69b2-6dbe-f12c-c4c46a28a67e@bela.io>
 <ae5e9ded-d9c9-92f2-7652-22d63340c988@bela.io> <87wm02s0jr.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <1043650e-6cee-00b0-c44e-35fcdfc6b892@bela.io>
Date: Tue, 24 Feb 2026 11:12:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87wm02s0jr.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote on 24/02/2026 09:01:

> Can you please add this patch to your kernel? This may help in figuring
> out which input to the calculation is wrong.

Thanks, here's a sample:

while sleep 0.1; do cat /sys/devices/virtual/thread/thread\:2597\:0xffffb417fe30\:2966408512/stats ; done
...
286 1230 1511 922 23489998 0 25909 92772685
287 1232 1514 923 23531006 0 41008 93137397
287 1233 1515 924 23559820 0 28814 92637646
287 1234 1516 925 23585834 0 26014 92881291
288 1237 1520 927 23656565 788211 23656565 30013
288 1238 1521 928 23684279 0 27714 92538624
288 1239 1522 929 23711753 0 27474 92913295
288 1240 1523 930 23737566 0 25813 92877151
289 1242 1526 931 23775363 0 37797 93009590
289 1244 1528 933 23862059 0 27904 92771007
289 1245 1529 934 23889157 0 27098 92878781
290 1247 1532 935 23925820 0 36663 93076817
290 1248 1533 936 23951423 0 25603 92655744
290 1250 1535 938 24013939 0 62516 185803244
291 1252 1538 939 24066786 1 52847 93163049
291 1253 1539 940 24086170 0 19384 92564594
291 1254 1540 941 24114369 0 28199 92882843
291 1255 1541 942 24146957 0 32588 92868913
292 1258 1545 944 24209654 0 25559 92716216
292 1259 1546 945 24244103 0 34449 92941370
292 1260 1547 946 24272996 0 28893 92816177
293 1262 1550 947 24311504 0 38508 93060111
293 1263 1551 948 24338783 0 27279 92701893
293 1265 1553 950 24394686 0 55903 185748119
294 1267 1556 951 24432533 0 37847 93039946
294 1268 1557 952 24456816 0 24283 92702343
294 1269 1558 953 24485695 0 28879 92879370
295 1272 1562 955 24575185 545061 24575185 45087
295 1273 1563 956 24600363 0 25178 92046991
295 1274 1564 957 24627141 0 26778 92884865
295 1275 1565 958 24654509 0 27368 92847752


