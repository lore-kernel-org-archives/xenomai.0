Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4F221D86
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520688; cv=none; b=HpbtmBLbmkfTxmvzvFmN2PTfvkQ1UtyFBUSe1mIZiQlcZlhctVfHZViar0HaBKY4XxcR+ht0ph4fMFpNSOqt4A75CRnIP3kuGQjWGEeOr3z6EVBVbGuDfjjmj69uaGK+5u0dUFGveJiafV+ra0v4LbhJabdkDNsBYpvep3c5NGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520688; c=relaxed/simple;
	bh=QPYChMICQ5wZufTAD6tExoXClhAsHwVn1XEYW2+RpK4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PFPaZ4tyiVANAL7+jHq56YPlY/UP0nw7O4AzG44cPvJYVuGCgkaxkZiCcWZXoI+/QXDtjAwi0e1prsdEuTRwnsK7MqbAWD3uJStyk6DRVT2LTx31p5vVcKr+W8au3X5bOgtSPnR8VFDiJ30/i+bqGyZV8EPaQ5GCq2Ueutr6dUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esiee.fr; spf=pass smtp.mailfrom=esiee.fr; dkim=pass (1024-bit key) header.d=esiee.fr header.i=@esiee.fr header.b=aAmhkUF1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esiee.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esiee.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esiee.fr header.i=@esiee.fr header.b="aAmhkUF1"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so923387f8f.1
        for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 00:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esiee.fr; s=google; t=1739520679; x=1740125479; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8vYAOmPudcZt0q67FVv6qvXn14nH9NhuDULBUSmBAE=;
        b=aAmhkUF1eRo8M2ae0XHFjfFVEF/BvyqGhgyLMSuHK7meJe2CUURgrOOdmhkE3H/Mdf
         kNMxoCJ5zExb1BYq8dBfg1zPJXL2AyBnbk6zJMDGRYm2O/9UyUKxls1K6N87GAqSIDiK
         ejCYxMCl9m8alb5aD5db0yZVYUJpDGFDP8wTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739520679; x=1740125479;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a8vYAOmPudcZt0q67FVv6qvXn14nH9NhuDULBUSmBAE=;
        b=r5aAEaAPYuYUFL5B5bO4nOFfUhtSS8xxQl7eg3dvgfsyMNd6nvqcquUwZ8m1ObKk23
         ynySa+S7L1eTIHftnUTw0zwvw8Hf39zh9XoSW0FKNYwnEj9e46DJGbVcSskzexKNPtod
         XPakK/yTQOYwR9bjMAKMQje7DpvxM2Eyi3gFvoTg4BQfmxo5WW98SSjrrwQqvmX9jTZY
         AE2rN6spWy4aFa+AMAwdrXPbc534Xa1YzuR6JnR4rvC0+m/Z47Lc0cIBv3+deUwNylnl
         zwgsxd/5HRy0bG+MezMxrGAP39zC/S8AH4X4AnzmWIKz0vUyOYVLdEXQXXauqe00apSy
         UkXQ==
X-Gm-Message-State: AOJu0YxK8jJllpWATfIwA26tvApdM/eW4eJMxpiiYbg+C5FLFVrkW1qx
	vr8eeqbviQTzV1toVO/dCvcztS3CgRHXIbbo+kLPZv18TE4i6c2KkJ87nkKoKJhJvH3w4i34wMr
	E
X-Gm-Gg: ASbGncvLKtMtwRpkOAw17uHd5f5ash23a62eu5k81+KCrQ0xJ3jyVAL76uyEuR94L1J
	ZY69X04inDfV5zPJSc2OM5hudwV9zjsaAvxpePwrhKuXD+5INSJ6nES6bnfMmvz5ChnDiUAPTfs
	w67xNVkdiCvWE5BOjWdAyrDsY9/Ny0yPZXAUIozsPplNfrUB2EkMt/WSjEcpYJmJdSYtdX1l2uS
	NQDCls1MPn7ij7vILSovjydQNJieL5GWcVNA9KayVE+E1spMqOYklzkGJAauKrgsipLMBGhuG8N
	cPBeKQDzDdSLVXSJUl4=
X-Google-Smtp-Source: AGHT+IGQwP26iaWul2WXZZ+sOJeN9eLNwM5hJvFky/SFh3rYj+ZXq9Usiz201RfC+aou4dLyIIMRoA==
X-Received: by 2002:a05:6000:154c:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f245035f5mr6958660f8f.31.1739520679351;
        Fri, 14 Feb 2025 00:11:19 -0800 (PST)
Received: from [147.215.40.84] ([147.215.40.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da784sm38771935e9.5.2025.02.14.00.11.18
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:11:18 -0800 (PST)
Message-ID: <0b3100d7-ba07-4839-88ad-2df1c367d094@esiee.fr>
Date: Fri, 14 Feb 2025 09:11:18 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
Content-Language: en-US, fr
From: =?UTF-8?Q?KOCIK_R=C3=A9my?= <remy.kocik@esiee.fr>
Subject: [Xenomai 4] Compilation issue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I am new to xenomai 4.

Following the information given on the xenomai 4 website, I installed 
linux-evl version v6.12.y and libevl version r50 on an Ubuntu 24.04 LTS.

With the kernel compiled and installed, I've managed to run evl test 
correctly.

I'm now trying to compile and run a very simple program given as an 
example on the site.

I don't know meson very well, so I've tried to compile the program with 
the following command:

gcc -o foo foo.c -I/opt/evl/include -L/opt/evl/lib -levl

I get the following error :

/opt/evl/include/evl/syscall.h:11:10: fatal error: evl/syscall-abi.h: 
Aucun fichier ou dossier de ce nom
    11 | #include <evl/syscall-abi.h>
       |          ^~~~~~~~~~~~~~~~~~~
compilation terminated.

In the evl include directory we find the following files:

drwxr-xr-x 3 root root  4096 févr. 12 11:52 .
drwxr-xr-x 3 root root  4096 févr. 12 09:42 ..
-rw-r--r-- 1 root root  1899 sept. 25 09:25 atomic.h
-rw-r--r-- 1 root root   675 sept. 25 09:25 clock.h
-rw-r--r-- 1 root root  1117 sept. 25 09:25 compat.h
-rw-r--r-- 1 root root  2439 sept. 25 09:25 compiler.h
-rw-r--r-- 1 root root  1782 sept. 25 09:25 event.h
-rw-r--r-- 1 root root   961 sept. 25 09:25 evl.h
-rw-r--r-- 1 root root  2413 sept. 25 09:25 flags.h
-rw-r--r-- 1 root root  4202 sept. 25 09:25 heap.h
-rw-r--r-- 1 root root  4873 sept. 25 09:25 list.h
-rw-r--r-- 1 root root  2128 sept. 25 09:25 mutex.h
drwxr-xr-x 2 root root  4096 févr. 12 11:52 net
-rw-r--r-- 1 root root   825 sept. 25 09:25 observable.h
-rw-r--r-- 1 root root   728 sept. 25 09:25 poll.h
-rw-r--r-- 1 root root  1043 sept. 25 09:25 proxy.h
-rw-r--r-- 1 root root 10460 sept. 25 09:25 ring_ptr.h
-rw-r--r-- 1 root root  1422 sept. 25 09:25 rwlock.h
-rw-r--r-- 1 root root   630 sept. 25 09:25 sched.h
-rw-r--r-- 1 root root  1774 sept. 25 09:25 sem.h
-rw-r--r-- 1 root root   462 sept. 25 09:25 syscall.h
-rw-r--r-- 1 root root   694 sept. 25 09:25 sys.h
-rw-r--r-- 1 root root  1311 sept. 25 09:25 thread.h
-rw-r--r-- 1 root root   465 sept. 25 09:25 timer.h
-rw-r--r-- 1 root root   560 sept. 25 09:25 xbuf.h


There is no syscall-abi.h file.

Is there a problem with my installation? I don't understand why this 
file is not in the directory.

Thanks for your help


Rémy

