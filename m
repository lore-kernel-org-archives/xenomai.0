Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962842F717
	for <xenomai@lists.linux.dev>; Mon, 27 Jul 2026 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189345; cv=pass; b=XrTremJDkSzj7c8QreUj85vmkZcopyU4XuZggCjrT/5VG3o1BfI85SbDlcqwgYfvupxfFMKUt+BjZcjIFVkv9+liXS8RShP4tIgF224Gjnj9m6GYU8/FFCB2YDMHWpDav5//kgNEA2eh6AdIdl87L1hPJSzhiUtepp5aN89QOzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189345; c=relaxed/simple;
	bh=XteQ2Fk49g+AoC3Qrcsd/ZDjyaUSXo6v3x/endEBtMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckcxVjPkvPl2N5D9w2YIbil8C8Ad1YiYVj2sXJSamyANggQW234mYS5uKsw9YccBg98b0xuNhmMB04192TVbsY31LZ6ItQbgWmA63KEH96HXV29If7HN9TLceWYQblYCW2/QJnvBzTCzRNnv2pNARZnuAQCQ67HJ6o1+0fSymRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerotech.com; spf=pass smtp.mailfrom=aerotech.com; dkim=pass (1024-bit key) header.d=aerotech.com header.i=@aerotech.com header.b=A9Zu8nbQ; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerotech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerotech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aerotech.com header.i=@aerotech.com header.b="A9Zu8nbQ"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso27645261fa.1
        for <xenomai@lists.linux.dev>; Mon, 27 Jul 2026 14:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785189341; cv=none;
        d=google.com; s=arc-20260327;
        b=ro995he4xQKPeApwV6UKgjqWNPNcfQCr38dLWvZjUrTIgpvVeMl8xSQbMlWEoT4zKv
         nvOZQMS3nBL0Kr73QP1ZIuEW4jhFEQ8cvBH2NMESgY/D3vFclC57UNhBMDItS55i6rwt
         VRPE7YpjTqooqfyYlDmfMdWf3WsYXwVEe96qRxVTP3/El06mTK/25ID25ZRxzTzLFvZf
         gsYt9FpPI1+LSxqTVjrHJt6uv1HKDevcwR/vP87Lbj3zWti1oVGsm3PZtX62RsUAsy7G
         9fBmIB8yGlIB8TqyKSW58SQbv0xUMTwMwhV/ptN8Wuz8li81jibP25t85UI+GF94Gx1b
         6gYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XteQ2Fk49g+AoC3Qrcsd/ZDjyaUSXo6v3x/endEBtMY=;
        fh=F0UOB05iSMQ2//aX4IlbHvTY2trUj/GKP3p3txfepf4=;
        b=O2xFgNS2u6B1tBIG80DNXQtlNmHIiqKD1kwZMqpSivKZUYOwb5WyTsldxQEReXbccI
         z/FMJqt9V8EfqvHidQt5xV2B2GicNaQk+/+U0NwHxW2+EMFAH7KQNif7QGDrTIuJGcNN
         uchXly0d0/xxuJ8QVsmRJcn9GBKLCNrZi4io1S3g/gH6bUCx1aaeviXG3qA58psizyEO
         TvbfzxlDnKKBcQZ/s80QNvwDdz1Rr9kDoyLu7MMRXjzByx9/1n8vA5Yh6vXiCPRrbRys
         FF4LkpGUe+Wh4jYSQ6KBwTcuvv88mxZU3NVGzdUzFMnTqyNgzQAirrYQEEHn7PT6A59s
         2OaA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google; t=1785189341; x=1785794141; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XteQ2Fk49g+AoC3Qrcsd/ZDjyaUSXo6v3x/endEBtMY=;
        b=A9Zu8nbQgTsxm/hW++gQ4jIj0iOcsW89Ukpcu3/sI/9IOyXb3of6ojFfY+EHBr+WTS
         ZDrC3Qh18xiFrPPANG+UyYB/BpVng0cGXgvMki4VAPtyPR5M2OKI+/ZRI7uggD3ad7VN
         44+3iegWfXZlBvl4xu+Tt9B/zKsJi6zaDNrWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785189341; x=1785794141;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XteQ2Fk49g+AoC3Qrcsd/ZDjyaUSXo6v3x/endEBtMY=;
        b=ZqUg02i9TzJB2ISNHxywbCYpX999c+kzJ407xnLwJD2uBAdf8BYW63VAQM5z57YsG4
         MRKiHLdc9IIJRVSlfq4hGWm5eoHyZLO4vJRYPJ8rtizg8wXO/cazlFjso7QBfKSUqOy2
         GT567PvY5Aj1lM34VJQn3sdWbt1pL+gvb5s9+HX18zQ80g9QpX0/NnUI+sq01INBoBx7
         +u/DunTGRW7sR8IG45g5CYqg03WtHAyUxkgME6hQ5cAxwEqZmxljoiq+pr+QoJ1pBh5I
         vzK0ad3f1zgvutQbblMTjekMu3mFbsi3jJTmcKFZzQ7Bqt2N8BQBB1L7CVof5oPfNdQg
         bYAg==
X-Forwarded-Encrypted: i=1; AHgh+RqhdlXICzbEj4wl2iM6zlk7bvxpxEfGTo2rXgN+uowGIEUfm8nuDArluzeNTilkJeretEkV91s1@lists.linux.dev
X-Gm-Message-State: AOJu0YzF1n28YDI56I3JLF8t/EAypEt5RLHmLHFvcZH2NgV7QqgoOtKm
	Zf0WpulI1NC//bVSmfiDFaz72PQivN1qILd7l15rR4yHV9TkoG8ZfNR/Y1wyPoGkYlVpYoZzL0B
	l6aMNbtpe9NjFGs0FSLxgafmFHcVhxRvF9GOo8Ctl5GNHH27/37w5hl6lFhRfDZjzn9dogUKWc9
	glDf8XZT/o5wTOHyjuJZyDXZnEgFXQVhsGjAT8LvSkXqEN8dm2NjIz9RfifCdUeNFZiVnoQa/z+
	AdhN3cP3LeIVIwzWs8E5TAh/W58EFMUdNnIzhtufQ35gpyrEBGxOcORq8UHfw==
X-Gm-Gg: AR+sD13nO4M9oi3Y6zYMdMoD0iec6WxCTsSo+ZNMXMfPWLTH53uRkoG/NGaE5IfUB0/
	gdDmMDjkAMNOJqd3TsMIVP6FxT1ZiRhVZyulon94Adu9tBgiBD6oM/X8U7oNjmdSwdY2BW2L1/S
	vMNwLmW7V/x+speiAYgm8j8A186c55WPH53QzYlfJRPB1EJ+oyPm5jCqu7IH3UFR5hcqVmsRc76
	WpgwL89c6v8sjHUNz9/5I4Am7KhALVgHbEOY8oiDh1Ua/BW40LthvsPZjg=
X-Received: by 2002:a05:651c:2111:b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-39f28789884mr20825731fa.2.1785189341276; Mon, 27 Jul 2026
 14:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
 <875x2gmuoo.fsf@xenomai.org>
In-Reply-To: <875x2gmuoo.fsf@xenomai.org>
From: Bryan Smith <bsmith@aerotech.com>
Date: Mon, 27 Jul 2026 17:55:13 -0400
X-Gm-Features: AUfX_myKoYAm7Lu7XEMex2FN5lSkpCqN7QXZOfnkRfRJ41wpVrqPwpTq8u434AQ
Message-ID: <CABE=YNs=T-x2iyDjOMcuDzkEOx6EQCUeX7ivGy15O01cZ8682w@mail.gmail.com>
Subject: Re: Xenomai 4 Allocator Fragmentation Questions
To: Philippe Gerum <rpm@xenomai.org>
Cc: Kevin Strell <kstrell@aerotech.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: aerotech2,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

Philippe Gerum <rpm@xenomai.org> writes:

> Kevin Strell <kstrell@aerotech.com> writes:
>
> >
> > 1. Other than the compaction procedure, is there anything we can do
> > with the default Xenomai allocator to improve the performance in
> > regards to fragmentation?
>
> Use multiple heaps if possible, to confine the problematic allocation
> patterns.
>
> > 2. When is the correct time to run the compaction procedure in regards
> > to when we should call evl_init()?
>
> Those are unrelated issues.
>
> > 3. If the fragmentation is a known issue of the default allocator, is
> > there any other allocator that is recommended?
> >
>
> An allocator which meets real-time requirements while still limiting
> external fragmentation to the minimum may be difficult to find because
> both goals are somewhat conflicting (notably because garbage collection
> may not fit well when it comes to time complexity). You may want to have
> a look at respins of the TLSF allocator, some of them were designed to
> address the fragmentation issue the original one had - which was the
> reason for developing heapmem years ago.
>
> I'm interested by any result in this area, feedback welcome.

--

> Kevin Strell <kstrell@aerotech.com> writes:
>
> > We have been able to avoid the fragmentation problems by switching to
> > using the rpmalloc library (https://github.com/mjansson/rpmalloc)
>
> A note regarding this allocator, which documentation reads as follows
> under the "Worst case scenarios" section:
>
> "Since each heap maps a span of memory pages per page type, a thread
> that allocates just a few blocks of each size class (16, 32, ...) for
> many size classes will commit a memory page for each used size class,
> while only using a small fraction of the committed memory. However,
> memory pages are committed on demand and blocks are initialized only as
> needed, ..."
>
> Assuming that "committing pages" may mean mapping them to the current
> address space and/or performing some kind of memcontrol work (msync?),
> you may want to make sure that rpmalloc can pre-commit pages, so that
> this does not happen in time-critical work loops. Because rpmalloc
> operates on a per-thread basis, you would need to ensure this for each
> thread attached to the evl core specifically. Failing to do so would
> certainly cause those real-time threads to be demoted to the in-band
> stage. You may want to check this using the related health monitoring
> service [1] (EVL_HMDIAG_SYSDEMOTE).
>
> To sum up, rpmalloc addresses the fragmentation issue by dedicating each
> memory page to dealing with a particular block size, for allocation
> _and_ release, so it does not have to resort to dynamic garbage
> collection. However, in order to meet real-time requirements, you may
> want to make sure that alloc and release operations won't ever issue a
> regular system call under the hood.
>
> [1] https://v4.xenomai.org/core/user-api/thread/index.html#health-monitoring

Thank you for your feedback.

We originally had a process that used a single large heap that was
shared among multiple threads:

* Main thread: allocates upon initialization only.
* Lower-priority thread A: allocates/frees during normal operation.
* Lower-priority thread B: allocates/frees during normal operation.

Memory was allocated using the non-serializing/unlocked libevl heap
API, which was obviously problematic when threads A and B run
concurrently. We have historically avoided the use of mutexes and
similar mechanisms, so we attempted to continue using the unlocked API
with a large heap for the main thread and a smaller heap for one of the
lower-priority threads. The smaller heap was much more likely to be
fully consumed, which is where our concerns about fragmentation came
from.

When reverting to use a single large heap and the serializing libevl
heap API, we haven't seen any issues with memory allocation nor any
concerns about using mutexes. We had to use a small workaround because
there are multiple processes that each use their own `struct evl_heap`,
and the name of the mutex created internally by evl_init_heap() is only
unique within the same process (and not between multiple processes).

 struct evl_heap heap;
 ret = evl_new_mutex(&heap.lock, "heap:%.3d", getpid())
 /* ... */
 ret = evl_init_heap_unlocked(&heap, mem, size);

rpmalloc did end up meeting real-time performance requirements with
the evaluation that we had done, but I believe that we are going to
abandon this evaluation since the libevl serialized heap API works well
for our use case.

Regards,
Bryan
