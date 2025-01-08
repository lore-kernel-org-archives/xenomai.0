Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBF1F3D3E
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328969; cv=none; b=tERP7fc1KT/KKmiYqJiEAP9jcCGdlC2ftO1zbNQWPiiwHvooJP9rycg1EykmaK0d6bMNxMS7lgO5QXLSsvFbfsacuddhWzYzRRdxYVrQccJT3HMCigommVkT6QAqRN7PpSjScOdSWJiCtysHDSB9NR09XKwFV3pwn5HGiViZTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328969; c=relaxed/simple;
	bh=o2nzQOdAOT9mWQO7O5orp5YlVZAYh2ukKH7dRHJcfLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SH5cuscwOhuY1qL5MK1Ggi1M0HyBll/JJDxA/lCYIKfnQB4bQfT/zSH2irR865+liYrcPgOxcTr/5LnIPvqa0/+guTVYfwqXW5+794kBd52QC4rUivWph33acOHSZiK+XPw/dzDwVYjih3uR7YVxfJMZs0Vvef07qGYaxRZdJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43634b570c1so118167725e9.0
        for <xenomai@lists.linux.dev>; Wed, 08 Jan 2025 01:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736328965; x=1736933765;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAnZeNCuLLWM/9B0G8vlAv0nhvmOKPOjP06y/BjF3g8=;
        b=U7rZt1GWIg5iHWS8no7ApL9AVomOQE/fL/LaZXCvJ/48d/u031W9uU1YweUdQqWkby
         sY3CTiz8yg8jBa/agZ+WKD+GKzlZirhvEB22oTRJQ1mIh4RgmqhEZt3T1LeZ73ONV/+A
         eyl6I/6YpHMrP3+zr3WkOSsF2pfIKZwn4LmYImTxrtvVJdtCbfrHqt8qRmzqamr39A/R
         PBaO/YZ/X6V4PyBZSkGh6yOR18FCwVx8b9+k25sKP8Hc+0AHYEEZAQ5TllphW+ilopbr
         O36bVkbf/dweocMf4MiPmYMYHFNWdAw6MZgVfaPc0VoZptp58+8BistTYh0yMyEGzgqu
         O3pw==
X-Gm-Message-State: AOJu0Ywwvgz2Xi7/5AN3MkLnQHdoCUqzhGVa84xDlwzPLbojZ0Tkmqdi
	sUZ8nd4tjyPjgzoQ/jGSWxJ3MgU1okCU0MaftgncP6YBw1qDbmbBTOyFng==
X-Gm-Gg: ASbGnctpKjZapffU+hTndmabZOjFs08yjKA0wSxznGHDR0czkmpYH+iwXcwFTl8Nlte
	eT3Zb/NcwSLhH7yMMycEYPsqaVMgH15k7zAEzgtAI7rjUIhQ3ynHvyd2EZ9VVyQ3WyQLUyQHbvU
	I0mN/xjg6rvXsE5m3MdmafMu49+YlABCfn5svjmMT2jl0vIgr8TB0RB6GUSYljVe8useKmPpw4e
	6VR3dMICbr1bzQLNZHAbf8SiLinXeRxdhBM4iPkTw==
X-Google-Smtp-Source: AGHT+IEIvbBzM3eA1dJuogcZ8Vh0lSDV8u8NYMlYGg6i73N74g0kE5Vw+3B9n7KsKeGT5+XafYLGIQ==
X-Received: by 2002:a05:6000:1446:b0:385:fc97:9c76 with SMTP id ffacd0b85a97d-38a872f7fd9mr1629923f8f.3.1736328965098;
        Wed, 08 Jan 2025 01:36:05 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc1763sm14476495e9.12.2025.01.08.01.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:36:04 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: "Rosenow, James" <jim.rosenow@mts.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Relax tracing not working for me
In-Reply-To: <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
	(James Rosenow's message of "Tue, 7 Jan 2025 22:51:10 +0000")
References: <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 08 Jan 2025 10:36:00 +0100
Message-ID: <87r05dve9r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Rosenow, James" <jim.rosenow@mts.com> writes:

> I am using Xenomai v3.2.1 on 5.15.57-dovetail and I have selected the following kernel configuration option.
>
> .config - Linux/x86 5.15.57 Kernel Configuration
>  Xenomai/cobalt > Debug support
> [*]   Trace relax requests
>
> When I run my application, I am getting MSW's on one of my real-time tasks, i.e. seqTask-00 (below).
>
> Every 10.0s: cat /proc/xenomai/sched/stat                                 test: Tue Jan  7 16:32:14 2025
> CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
>   0  0      0          3526511    0          0     00018000   99.8  [ROOT/0]
>   1  0      0          22166547   0          0     00018000   98.7  [ROOT/1]
>   2  0      0          6          0          0     00018000  100.0  [ROOT/2]
>   3  0      0          0          0          0     00018000  100.0  [ROOT/3]
>   4  0      0          12         0          0     00018000  100.0  [ROOT/4]
>   5  0      0          0          0          0     00018000  100.0  [ROOT/5]
>   0  311    0          2          0          0     00000042    0.0  [rtnet-stack]
>   0  312    0          2          0          0     00020042    0.0  [rtnet-rtpc]
>   0  34201  8          8          54         0     000480c0    0.0  coops_target_main
>   0  34203  714420     714421     1429756    0     000480c0    0.2  userCycle
>   1  34204  2          2          571184     0     000480c0    0.0  clockInterrupt
>   1  34205  1          571183     1356559    0     00048042    0.4  dispatch
>   1  34206  571182     1142364    713982     0     00048042    0.5  seqTask-00
>   1  34207  1          285594     356993     0     00048042    0.3  seqTask-01
>   1  34208  1          142798     180963     0     00048042    0.1  seqTask-02
>   1  34209  1          2          3          0     00048042    0.0  seqTask-03
>   1  34210  1          2          3          0     00048042    0.0  seqTask-04
>
> This is an iterative task that is executing at 2000Hz, I get 1 additional MSW for each run iteration.  As you can see there are many MSW's.  Shouldn't the trace buffer be full of these relaxations?  If I cat the buffer, I see nothing.
>
> test@test:~$ cat /proc/xenomai/debug/relax
> test@test:~$
>
> What am I doing wrong?
>

In short, you may want to make sure that PTHREAD_WARNSW is set for
'seqTask-00'. The STAT field for that task reveals that it's not (0x4000
is clear there).

Why? Because the logic of MSW tracing is as follows when
CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is set:

1. On MSW detected by the core for the current thread _and only if_
PTHREAD_WARNSW is set for such thread (which is running a syscall), the
latter is immediately sent SIGWINCH(aka SIGSHADOW), with
info=SIGSHADOW_ACTION_BACKTRACE (xnthread_relax ->
xndebug_notify_relax).

2. The pre-defined SIGSHADOW handler in libcobalt.so (see
lib/cobalt/sigshadow.c) runs, taking a snapshot of the current stack
backtrace, then sends it to the core via Cobalt's 'backtrace' system
call. Since we are not using alternate stacks, the code which caused the
MSW must appear somewhere in the lower frames below the current signal
frame. This location is figured out by the slackspot utility when
analyzing the captured frames.

3. The core receives the backtrace data, then logs it into the
appropriate trace buffer which is behind /proc/xenomai/debug/relax
(backtrace -> xndebug_trace_relax, cobalt/posix/syscall.c).

HTH,

-- 
Philippe.
