Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27187B
	for <xenomai@lists.linux.dev>; Fri, 21 Oct 2022 12:21:21 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id pq16so2323663pjb.2
        for <xenomai@lists.linux.dev>; Fri, 21 Oct 2022 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t6adMWkQZy3x1JBq/HcRucekjJY07/zQWFgK7eespPQ=;
        b=ZFe+q38Vo/ywf3Zbd//YKKlQjn0QyaFRZZhBO8RwdCcdoNdyEkuVAyUKPzf8oj7ZgU
         879ol6KHD9wxLEbnpfXMmAjNBvxDSnk2GTTzJMT63GjSHDDD9m8juf4pcBq7A5voJCJU
         Jd+WUlPE16l/sC/HyIoOGU4jHJDlw1Rdk649GRz3t4vrf2LaAt1iFyksou2FkO6qrZvx
         4QD8WXjeA1oZtMZw6DqoSztHS4m4CzMXp9pLA27IzIslN8kf94fxZGyK4xIsQAgngHdU
         a64ACdJTyr1Hg46PEGRLzt3RzQ3YW8ZFQuDgRc1Y1yZcib7WTVQ5oYFJEp16BPXNdAAS
         zMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6adMWkQZy3x1JBq/HcRucekjJY07/zQWFgK7eespPQ=;
        b=uGfHipoSsgUB0zDYBU288fb4B9kJ0+wJli1FBj2bVFxPsaq+9kGZrqrQyK8H0bBRkJ
         oKKZJoRWKAMpgis2XEwJdCdwQEVfsJh23EIF2HSAUh+NwWAy/1Q9BFGlL0HsyoP3E6ym
         p+jdvpwTT6GPm1a7phMRPGXBh1MXhTm2sR3AZnKuffiIeieeXLm1qvaxh9Tc6awJvs6J
         CbY4hwzyahuzb8kEPivKy7dLkBN69cKfgDvx/YV7++qQGtq8UiYnNFwTQpyLgsVixHm7
         2fxMS995v+FZm9Xk0MFoaAj9WuZtLLftbCjN6jNMtnYdg4YqzheNA7gRQ62TZKJVLsiE
         /UTA==
X-Gm-Message-State: ACrzQf3SsCRy3188yRy2aa0kBSfbyWmtMCiXnA0d6gLvTYRCfUTwHwnE
	HqnbSKRfi6A4AsJISQwNu6V1ASTVDYf9t3YR3yHDDgjOZVE=
X-Google-Smtp-Source: AMsMyM6JHWWkMWs80dV9AzG6iVWZ54ZmhrVeOI/CLzOVllCJ/gXeO4SNflmHNDljUah+gilbfj/N7WKTw6o4hGMohAI=
X-Received: by 2002:a17:902:d2c6:b0:17f:592b:35dd with SMTP id
 n6-20020a170902d2c600b0017f592b35ddmr19104833plc.172.1666354881290; Fri, 21
 Oct 2022 05:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Fri, 21 Oct 2022 14:21:10 +0200
Message-ID: <CAH0t8y31sXMGTmmAvLc5Z=wRYNbZoNhiv-KCRj5b941QSJmt=A@mail.gmail.com>
Subject: I need advice on thread scheduling policy.
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear All,

I am using Xenomai 3.2.1 and a Dovetail patched kernel on an x86 PC.

My application has about 30 threads. 3 of them are time critical. The
low priority threads are interact with the time critical ones, using
semaphores for data synchronization. The scheduling policy of these
time critical threads are SCHED_RR to be Xenomai threads. The others
are SCHED_OTHER so (in my understanding) handled by the Linux
scheduler.

Is this the right solution, or should I make all threads to be Xenomai threads?

What is the best practice to get the lowest latency for the time
critical threads? To get some load off of the Xenomai scheduler (by
removing the not time critical threads to Linux scheduler) or keep all
threads as Xenomai threads?

Thank you,
Tamas
