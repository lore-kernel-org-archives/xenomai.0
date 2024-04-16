Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E712CD91
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276354; cv=none; b=oRwnZIO6+fdxnasLbwfEWJ7s/SxxMlYqgfBiECdZyFUzzhVEzBSTY3VQgNnCDGgQeb7npsZs5qBKxR/rPPD+DMLQEOlsKvoBkZ6QnKIeQEXeN9j+g+m9uegenZJH14GPOl7Pmbi0UT6uTDjj8WQuYmG+qDysp/bsSkV12CFhVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276354; c=relaxed/simple;
	bh=28mc0ng+tInhj615E6Gm4ijQSuEdTqgUy7C6Qkz7yWI=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeiktycqJvY4ePvNl0YEy+zlcTsuwWEIFjrBvdkFdybKTroH2U4UnGVD3mtR7YJU/n9lfiHoZ4GywLAYCSQ81fAhY4qHD1l4z0wx5Ep9arqA9UYOPiYsogltH01qHs5ugJjBOOyjY6SxlKdzM3k4ydWWi1Xe4rGNkyRCDl0wGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=drotek.com; spf=pass smtp.mailfrom=drotek.com; dkim=pass (2048-bit key) header.d=drotek-com.20230601.gappssmtp.com header.i=@drotek-com.20230601.gappssmtp.com header.b=TwdzoDtT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=drotek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drotek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=drotek-com.20230601.gappssmtp.com header.i=@drotek-com.20230601.gappssmtp.com header.b="TwdzoDtT"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-346b146199eso3189482f8f.0
        for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drotek-com.20230601.gappssmtp.com; s=20230601; t=1713276350; x=1713881150; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o2sL/KN5X2pIWB+gb2/QyI5/1mPX+oXudXYQabHGvhw=;
        b=TwdzoDtTbkE2Kfx2PnHxVtcjtG+A4NOy+lJo8nOecW/D/bBNijL0LyNUUSE8XdKZKu
         4kxOrSMUbzscqIh9a8zCFco0SAkArHJxuguhxFljOBC1Lyg2UFCok5Qy6zwJwW2x/sON
         zfLG9JKrwUyKcrUzM+6dM5hzOKg1wvmWDkdB0qZStvD9YeIyLpkdnHfj8c45w/ndzZov
         detUYTMihVmLVUtOpbGefRjo6W8Xj0pHy6KXXsT6YHFasF5imQGseagsTccz1BCKOgxH
         RmHbztN6GSRG3Rrf8KwsfEVZR7n6PvfzY8vs/udnSAhUDlwJI5XN26Of/RgMbR0qtu8C
         pbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276350; x=1713881150;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2sL/KN5X2pIWB+gb2/QyI5/1mPX+oXudXYQabHGvhw=;
        b=dCBf4ddbHgxA8lCWXlHIuniyFhx/YEQ5Ee3GFRq294Os/BGpfORsPOFOi+x1SyHMHa
         9/vWP4mgOQI45EINeWia3KQD+enM23GvDlpd6Y+9uH4kFj2cw0ZeHKSFTCDkZzIyKzS4
         5dsREgCArdXjMx7QGE/ZwaBxB8tO2V46hZp5rNbL5cRjpMjZPBigka5ZEruPjxHJWZCJ
         fxNdxKKEbDSkc+vJNZkWMJdOwWciH38dSWcg8l/lbUHa34jgjlcK1AsinlmnqEBXLd55
         xoZRwoIikujlRs9xP3vVQo3Ng5qa3h2IXmG1fl+syJBVTrUuuJd0pBSQ6/f+Q8QcQMUA
         8rPw==
X-Gm-Message-State: AOJu0YyhN0HzuO6uBNq7FhPNxp0xT1cBRvyAgoS0CBGsF+/lLKpntQWE
	22hag7B19FTpxqrUgQ5bCfSXbtMyOZmgmfEMd+u1zBWYWT3oUvOYzVxwpLCDA3Q=
X-Google-Smtp-Source: AGHT+IGSmmwxYGy5V7k4sV33OTEgKCkO4WMcvTicTiFvCXP0yJK15Nh73UuBqHoG5/5cMGGKU9aVsQ==
X-Received: by 2002:adf:efcd:0:b0:346:92d2:a496 with SMTP id i13-20020adfefcd000000b0034692d2a496mr8377166wrp.29.1713276350311;
        Tue, 16 Apr 2024 07:05:50 -0700 (PDT)
Received: from Edoras.gmail.com (apoitiers-259-1-37-199.w90-55.abo.wanadoo.fr. [90.55.220.199])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b003437ad152f9sm15008550wru.105.2024.04.16.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:05:49 -0700 (PDT)
Message-ID: <661e85bd.5d0a0220.a8214.d5f4@mx.google.com>
Date: Tue, 16 Apr 2024 16:06:05 +0200
From: =?ISO-8859-1?Q?C=E9dric_Ch=E9pied?= <cedric.chepied@drotek.com>
To: =?ISO-8859-1?Q?C=E9dric_Ch=E9pied?= <cedric.chepied@drotek.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Posix timer creation failure
In-Reply-To: <661e49af.df0a0220.ffef6.a7bc@mx.google.com>
References: <661e49af.df0a0220.ffef6.a7bc@mx.google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/30.0.50 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Cédric Chépied wrote:
> I'm trying to execute a simple posix timer example (see code below). When I
> compile it "normally", it works fine but when I add xeno-config generated flags
> (to add RT tasks later) the create_timer function fails (invalid argument).
>
> Here are compilation flags :
> 
> sdk/sysroots/x86_64-fslcsdk-linux/usr/bin/arm-fslc-linux-gnueabi/arm-fslc-linux-gnueabi-gcc   -mthumb -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a7 -fstack-protector-strong  -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security --sysroot=sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi --sysroot=sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi  -O2 -pipe -g -feliminate-unused-debug-types  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed  -Wl,-z,relro,-z,now -Wl,--no-as-needed -Wl,@sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/modechk.wrappers -lalchemy -lcopperplate sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/dynlist.ld -Lsdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib -lcobalt -lmodechk -lpthread -lrt -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -fmacro-prefix-map=/workdir/build/tmp/work/cortexa7t2hf-neon-fslc-linux-gnueabi/xenomai/3.2.4-r0=/usr/src/debug/xenomai/3.2.4-r0 -fdebug-prefix-map=/workdir/build/tmp/work/cortexa7t2hf-neon-fslc-linux-gnueabi/xenomai/3.2.4-r0=/usr/src/debug/xenomai/3.2.4-r0 -fdebug-prefix-map=sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi= -fdebug-prefix-map=sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi-native= -Wl,-z,relro,-z,now -Wl,@sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/cobalt.wrappers -Wl,@sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/cobalt-glibc-time64.wrappers CMakeFiles/timer.dir/timer.c.o -o timer 
> 
 

Wrappers seem to be the problem. When I link without
"-Wl,@sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/cobalt.wrappers
-Wl,@sdk/sysroots/cortexa7t2hf-neon-fslc-linux-gnueabi/usr/lib/cobalt-glibc-time64.wrappers",
timers work. But I won't be able to use the rtcan driver (I won't be able to
call ioctl on the socket).

It seems to work by adding "-nostdlib" when linking but then I got "undefined
reference to symbol '__aeabi_unwind_cpp_pr0@@GCC_3.5'".
If I disable exceptions with "-fno-exceptions" it compiles and runs fine. But I
need C++ exceptions for my "real" code.

What is the correct way to fix this ?

Thanks,
-- 
Cédric Chépied
<cedric.chepied@drotek.com>

<http://events.drotek.com/>
