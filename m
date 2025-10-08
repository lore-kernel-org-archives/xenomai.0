Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E74C6C
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759974271; cv=pass; b=Igr8mL8xbD0BMBe5frOENIWQIucWyIHgOd6YOGFxbkFgxr+ND9lqqK9HNL0D2e6/OWdaGvv/W7rJsxZGVabq2fbOcGGey3mjEC1nyKQpLK1xZROkb94VCvWq8x7F0Ysjo/hiAVxBh7KC3dyftqeFl8kp4bYTG1SLwMALQS6IUpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759974271; c=relaxed/simple;
	bh=Nga9oDoYRZpKnD+ipDOEQOxhiabb/l4pOCOgBdXplO0=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=tZOso/qNaFhbZlY8uB/WNCX9x+1Um8kIizJjPdvNU7v90iOybbGLcFi4o2J62vRCwf/HXh0ijrq1Zoy4TiVaFd2Hfp+0d5LeGYJjHKml2HRsUl35b0N+rAQ5uQ2bKlOGkqYSnTMpEmg6S2Zurw8IoWHAc1zO2X9uUEw7bwxrD6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=mo5EUVMq; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="mo5EUVMq"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B75F3941D47
	for <xenomai@lists.linux.dev>; Wed, 08 Oct 2025 23:23:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a244.dreamhost.com (100-114-102-221.trex-nlb.outbound.svc.cluster.local [100.114.102.221])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 20B1694253A
	for <xenomai@lists.linux.dev>; Wed, 08 Oct 2025 23:23:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759965806; a=rsa-sha256;
	cv=none;
	b=VVEk5WbgkC+Ce0vfdxRxtl1/gohslw5lVxYjHNQbtSB2fftDxPJOxDsQRgvD/qaYq/3bAr
	gKdxgJI648X/qZi/e63ZazZz3d+yATQaE417JNHVl8CooFF1xtqKnBcMyrOZQkj8LKgxJo
	dNpq3ngKPqSPiWnXb4qna71LdsGGcK3NL8o2MjDpJY4g0dL/L58BrsevpKfncrvyCgHFd0
	uedFHchbUeWDy5nczlISMg2Q6pZoYh1oGo3iNjsYKh9vkOQyves3fEGiHJk3uiqg6XUCf8
	vt7uLskHgxxsfYvrsV82136qRM9PTNqjFWZwlrbb7Zm/53ssxC/OL6KwI8nMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759965806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=YFLk9WbRIdRuSZZZjIXTwjRKmF+MjzAnbvnz92vwyt0=;
	b=f0ZGrT5AxnJJsJXTJFtrsRll3YDY8l+fkxkcyfupLMjELcH1sVDLkaHDgPVDCCMPbbOnBv
	l9RbQOfCA9unlOXMsrQmYiOVqXG+9RtvPqZpAP4C9j/ATz2lWCJ2DJc8gqLNXRlSeK7cj5
	j7IqDAfr1nCJ7NFHvhfyfNN4rDCHVvhdiKd2KgpcH9DFw32RvPR/ZRHr1U4pHD/CZXofD6
	VYHYIY84l1BmsTnIV9+kVdOOMaa9tqurGwEbDRqlsL0GVVvqgH33l04cS3to9dxwQXHb8v
	zPrv/TZbEQzXb5KxAWNwVzsAxYUHeYSZZ9zEKCsQgH66K7/UESfEtGc5tQ/+4Q==
ARC-Authentication-Results: i=1;
	rspamd-777888ddf6-dhhd2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Fearful: 79b57bdf635978c0_1759965806539_3443093498
X-MC-Loop-Signature: 1759965806539:1514229444
X-MC-Ingress-Time: 1759965806538
Received: from pdx1-sub0-mail-a244.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.102.221 (trex/7.1.3);
	Wed, 08 Oct 2025 23:23:26 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.95.48.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a244.dreamhost.com (Postfix) with ESMTPSA id 4chpwF3P3GzGS
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1759965806;
	bh=YFLk9WbRIdRuSZZZjIXTwjRKmF+MjzAnbvnz92vwyt0=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=mo5EUVMqCpsO4Ss5c65pbHWD36GSwzEkDJyYkgKlMjlAK7V5Prxi8OfTy0pkXPdp4
	 fjAe30B7VKZPIHu+ytPK/jPQP7BP7gGR9XDk6dTwT7ouAq2QGwHwbSd1LlMaXcQzmt
	 wuhMSpDYPgwJabhVVI7XV0pqP+uDKun6obrVaZSKejeM6chNnR8iQ7lhn4HZTd/ICw
	 qpokMYJUguSk+fmkHGNgzoX30Pk/eise7S/r/jOCpY3PEa/34hmDa9v1gjiShDhwd0
	 /imDBbxGA2Zn4RbaARkb960LAK60Ks8Zx3z+RNIsPcOyOGPZFVe5oFTu7I97R84jzb
	 jvhbKP1SeG5rA==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: Issue building libevl
Message-ID: <04d329ce-66e9-d2d4-e413-b392dabaa5a5@bela.io>
Date: Wed, 8 Oct 2025 18:23:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,
I was building libevl natively on Debian on the PocketBeagle 2 using the beagleboard image and a 6.12 linux-evl kernel I built.
To access the headers, I ran modprobe kheaders`and uncompressed /sys/kernel/kheaders.tar.xz to ~/h .

Following the instructions at https://v4.xenomai.org/core/build-steps/index.html#building-evl-prereq, I tried:

   meson setup -Duapi=xxx  build .

However, I didn't find the right value to put in place of xxx: there would always be some missing path that would make setup-uapi.h fail. To give an idea, from within ~/h, I have these relevant (or not?) paths:
$ find . -type d | grep '/evl$\|/asm/evl$\|/asm-generic$'
./include/asm-generic
./include/asm-generic/evl
./include/evl
./include/uapi/asm-generic
./include/uapi/evl
./arch/arm64/include/asm/evl
./arch/arm64/include/uapi/asm/evl

Also, note there 's no ~/h/Kbuild.

It seems that something is wrong with the heuristic there in setup-uapi.h. The workaround for me was to apply the below patch. Any suggestion on how to implement a widely applicable fix?

============
diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
index 633c5ed..1d28716 100644
--- a/meson/setup-uapi.sh
+++ b/meson/setup-uapi.sh
@@ -12,7 +12,7 @@ link_dir() {
      ln -sf $1 $OUTPUT_DIR/$2
  }

-if test -r $UAPI/Kbuild; then
+if true; then
      link_dir $UAPI/include/uapi/evl .
      link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
      link_dir $UAPI/include/uapi/asm-generic .
================

Best,
Giulio
