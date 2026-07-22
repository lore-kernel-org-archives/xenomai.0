Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468A355F22
	for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729462; cv=none; b=VPuqq7MLQb/y+gc9c2bb25szU/F6fNyhAMs+NrDeBGDtTJYcR3+EucsG7c1p4V0cp3aD60P5qgE6xKSJYakhi/6VyJvk9wxsxRjo6ExibyUJAZpinTTlGF/+IWtBtUL3/UGpRfpkBYXImGW4ntaFKftYgqBYlwJd6Fpg+btnsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729462; c=relaxed/simple;
	bh=+ne3dxANzIoS2bWXJoKXyW0mBLldlIPbRdQjqIkC/5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmGM6q0ovghsTDKOZWcni1pFgDbqrDNesBrRQSMtBExOnN83BE2GR9crWvO3sftU9DY6sEJuMYW6K0pJMX23ARCZCtFoBeD9XvFkvHa1PnmS32/F1jQZxsj7qt2Q0PUXy/tIgGP5HXC/ORt/SswF5168eq6hbClWIDkJqXXpnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob1bpC54; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob1bpC54"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f71156e1aso1962565f8f.3
        for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784729459; x=1785334259; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AoQcASPQnUPcBmYAmN6VxhtM3tOBc7vUDBhQk0RHdE=;
        b=Ob1bpC54cERm4HALBqXdBV00mvkhHkgNB0oD7LmZBuQ5ViiKeWTumr568wFcsYEVyb
         RGI1VxUHxSiM8+7JsifTyUcmXL7JNzcX3AupBREKK4Ly2npvx06jey2AkX+Zvx+Am9LN
         I82CMqGPheRiW84Vow0Ze18tSI2ZUDffPb35ZddBmy+fdJnh//vLKM2j7A2p4tDl2WWl
         fiG9ASSPvnSJ1o/grieK1x7XnUg3PS/cjZ5DMXHtFukY8vQmdn7Zc1yOlBSZul3fBbtm
         T8mvFvdd7URhPYR4ozSwlgLxCaHcDnjAFWgBYBFOIverEj2zZmnpB/pU3aBZTOQn7M9C
         qyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729459; x=1785334259;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+AoQcASPQnUPcBmYAmN6VxhtM3tOBc7vUDBhQk0RHdE=;
        b=QnyjdNF6uM5/F7JAW0fPsYYV0msI9cIRcYdqHH+COiG7sGD+g3n7QodzCZmTO4FLri
         jRZ5FvMt2TFfw0eiEf0sZqA5U19s14VhlfGY6BVRZdQCyUphBbopuwhYtJX1U5ssHM/t
         lz/eZWEzkIMnDL0qirPVIZriehWERUJrMfiGONNSz2lUSWkmZ47MBkbVgr5BjkdP0zOs
         KjQG2Z9ugYiqqXoieF5otEDA5hf27bUBumbmnUs+MrFA0G04nM+EG2fLFeqbJsgPmzba
         eyNzybcZDWl9NDs2QTFzgN20a8KdRO1v+T1ybF1Bp9Z+ttGFX0uwmAZoHXY+jw1jPHAk
         /DQg==
X-Forwarded-Encrypted: i=1; AHgh+Rqprnp+1yextzSvuSnh6Hg4GIty9bqJ+IwH33m7Kjx0ciGjJI6MV/zqGpyvdXXcD/wVMML+lM/W@lists.linux.dev
X-Gm-Message-State: AOJu0Yyar0cC0+7c3DnTytSktJYTjMDmDFQ4KsQPF+l2bvbsnyUTy+aJ
	JGpijD2qkGjde2rR7g1yBTHjVbTwdWKek0SVNQ7xKOTPkTr45IrkT2rE
X-Gm-Gg: AR+sD131w7aDuhIcC/gwnMf6DFVBXXJXs+LT6tzSJgxF6WTxpHkLFIfb2og5dLn7QnK
	pKZgSMyw1xyj/rPTidnS+P9wKFkdao5W1vHqNchTgzSrdNwr4UttlpriugkuCC9WeIp2lnDPLpf
	X+mR1RB5Ts3NxXJiJHVqbz27errAdaZydKhwc0nuqhPGuxSqer9nCYf1dO0JMtsrE+4awv5Uays
	8TPCyfc2TJpW5RKijtA6ynGYxD6TFLPHG9f/iBQtQvdhEDrVXiDM1LNGzSzbzFpy2WDZDMFMUAU
	555/M+2B19CKL8TJlxn/XJdjmw6K5HkkbKTt5e85E0LaPGdxxfPws5Pn4IPuB5xdFgYmxWIV0Iu
	rBF0660ApPsL1E9viIeq2GCsGxTquSZJgtD8h0emB5VL+DS1xLHuFqlFeV7J0qkfNlrrs1PgFaY
	LR3IAhTl2t7w==
X-Received: by 2002:a05:600c:1d1e:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-4954a3d0cc7mr249683225e9.2.1784729458891;
        Wed, 22 Jul 2026 07:10:58 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653731b2sm151866145e9.4.2026.07.22.07.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 07:10:58 -0700 (PDT)
Message-ID: <f3629913-ab62-4b72-a725-14a466a87084@gmail.com>
Date: Wed, 22 Jul 2026 16:10:57 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] libevl: Add debian package config
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
 <60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
 <2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com> <87mrvkkbfh.fsf@xenomai.org>
Content-Language: en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87mrvkkbfh.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 21.07.26 um 10:13 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>
>> Version 59 is not really correct. The kernel has EVL ABI 45. Libevl has API 36, needs API >= 45.
>> For kernel dependency's, the ABI version is important, right?
> 
> We have two distinct revision levels:
> 
> - the ABI level between kernel and userland (syscalls and definitions).
> 
> - the API level which is specific to libevl, allowing apps to determine
>    whether some feature/routine/behavior is present or not. This is more
>    of a source-level thing. Multiple API revisions may be compatible with
>    a single ABI revision, and conversely.
> 
> You will find EVL_ABI_PREREQ in include/evl/version.h, this is the
> minimum ABI revision which that particular instance of libevl can work
> with. This is what you need to keep in sync with the core available from
> the kernel part.
> 

Yes, you mentioned this in an other thread.

So this versioning would make the most sense I think, right?

application depends libevl >= 36
libevl version 36 recommends kernel-evl >= 45
libevl-dev version 36 depends linux-libc-evl-dev >= 45

For the library, it is simple. However, for the kernel
it is a bit annoying do to kernel packages have the kernel
version (6.12.90 for example) as default version. I'm still
thinking how to solve this the proper way. Might be this can
be solved by Provides: kernel-evl 45

An other topic: With the udev rules (90-libevl.rules) provided
in this patch, I now got latmus now running without root.

diff --git a/latmus/latmus.c b/latmus/latmus.c
index 9b3ed1e..4e88326 100644
--- a/latmus/latmus.c
+++ b/latmus/latmus.c
@@ -868,7 +868,7 @@ int main(int argc, char *const argv[])
                                "period=%d microseconds (may take a while)\n",
                                 get_refclock_name(), period_usecs);
  
-               ret = evl_attach_self("/clock-tuner:%d", getpid());
+               ret = evl_attach_self("clock-tuner:%d", getpid());
                 if (ret < 0)
                         error(1, -ret, "evl_attach_self() failed");
  
diff --git a/latmus/timer.c b/latmus/timer.c
index b84c71c..322511d 100644
--- a/latmus/timer.c
+++ b/latmus/timer.c
@@ -36,7 +36,7 @@ void *timer_responder(void *arg)
         int ret, efd;
  
         /* Make it a public thread only for demo purpose. */
-       efd = evl_attach_self("/timer-responder:%d", getpid());
+       efd = evl_attach_self("timer-responder:%d", getpid());
         if (efd < 0)
                 error(1, -efd, "evl_attach_self() failed");

sudo setcap cap_sys_nice+ep latmus

Now latmus works as user.

It looks like according to [1], the / forces EVL_CLONE_PUBLIC. Somehow,
EVL_CLONE_PUBLIC does only work with root. Looks like there is a
race condition between the device file creation and setting the
access rules.

I did some tests: As long as user access is given, it works but
if only group access is given, it fails. user is member of evl group.

chown -R root:evl /dev/evl/ -> Fail
chown -R root:user /dev/evl/ -> Fail
chown -R user:user /dev/evl/ -> Ok

This fixes it but it's not nice:

diff --git a/lib/sys.c b/lib/sys.c
index f7fde82..ff6b95f 100644
--- a/lib/sys.c
+++ b/lib/sys.c
@@ -334,6 +334,7 @@ int evl_create_element(const char *type, const char *name,
                         goto out_new;
                 }
  
+               for(volatile int i=0;i<1000000000;i++);
                 efd = open(edevname, O_RDWR);
                 if (efd < 0) {
                         ret = -errno;



[1] https://v4.xenomai.org/core/user-api/thread/index.html#evl_attach_self

