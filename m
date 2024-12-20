Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09341A707D
	for <xenomai@lists.linux.dev>; Fri, 20 Dec 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685168; cv=none; b=dST5QjkXjGAKWip4rMTTHPiiFLANGiqghIt92ciukH4Gb78f8+NnW1OWq2Jae/opuTiZF4wfofML7hv4yvivHRxYKM/8yRSA37XxEqt8emo3YXDKWDAmokFuSpDLqUZ1DQ1hefN9I0i4zoyUIfamzHse00/5GiBREuFcWWMlADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685168; c=relaxed/simple;
	bh=NRpSFgLxOmDtPFxRUP5ix5Qc/LjUMAnQpbP5N7rnoh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/AMripaRyvGVR/GA/vKtbtD3bxoGvlKN7laQ7ySyUgZkZqYRrUmBtz6UHrA/Yp5gXTVb7YwgKVevRRIh/qDRFJWAyieVnBhhmFmN/pbSC5dr2ExMLgZnqBALMW1M+YVymizkJHQ3/OkPgy/XphQGsS1cwH9tbEStIOdZJ/Ck1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMFWBGe5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMFWBGe5"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so1661252e87.3
        for <xenomai@lists.linux.dev>; Fri, 20 Dec 2024 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734685165; x=1735289965; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1k5HHReasJzn4jFaYY4UJugoCk4FFuJfYBWjQxEGmE=;
        b=PMFWBGe5/CXbmmv0+yCbaYQt7SUOeRuvrYZ8kUXksH0wM5UOxTcG4w2xerpKgY0l66
         h2zjMyog3uM72+HXbOlyGF9+muEMacpyHNhsTZkjE/agbs9pQw7rdfeCWNT+cv7Sh3C8
         Ls9Gt0wwt7QuLZCKGmhAfiHMTHARFd1BI57SHQG736XwYd30OqX1Fy7nsVaa60UU0Hfl
         zfN9TF8AHprbwNUdc8OYST//p1aeaKweZ/Slp9mGf1/kvZYRcIazelW+ySAslGwQxz3Z
         gmkLNoT8uB1RhpTWEk4NY+WtvPrt2MfdWDvegg5tgA9mxKhfFEtaSL5YJeIddlpkkIWS
         82DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685165; x=1735289965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1k5HHReasJzn4jFaYY4UJugoCk4FFuJfYBWjQxEGmE=;
        b=RXXg7/D6tnraZ+N+v5FDzUbXQB5i7G/ePXQBvaWNCGV8y0p7X196yMWTUq1xgJypjQ
         m5J+M12V8r/v6wz7mLV4sd02ZswUL8yTIsKA9Zz2CrHsCOXEA8TLGFe+JwW6eijeGy+j
         dgOxenMPJDCx8oWHDgojWXhS7kXLLtHeZreXDkcCDxlxoD92CkourtwKJb2lptesD+hQ
         V0acd0LTdRvDDaQbvAXO8lIqbE2winehYphYCc5S2L/HBxaSNqx3UEGrRiBAKjncv6rM
         aWL9YbIexZojneQOQ1IMURJdA4GFFtoU2vySQA37b+XN1pOWzHjDB7O+RKxp9qMoYj7T
         7yZw==
X-Gm-Message-State: AOJu0YzVbLBpBckskWLMsbRkKaTfakKq/wg7iA//8jb9K6c3RxWaor80
	QTl75Y4+RfYKBUAxzIoOFdhWEfwMjSYPZZ1fuTh1mYqCLeGF2ARGZ8hkswIiuWOI/Ny009bY5gu
	+MmmwgZigHQJiL3r7MQmZ4IMfPShdhkbPB3htnJoK
X-Gm-Gg: ASbGncutwnycLhAN8vJi9pTmCLNmmee4njkzzHhtqN0FqteisdSSqNrBTAY86aTRiMa
	SiG2j6RCKDkg/MgV1QyDXinsmyUKGrnWXihO1Apfm3ENV3jarDoUfedllxTggNzh1ki694w==
X-Google-Smtp-Source: AGHT+IFYnJ9/Ues7f3YZKlCj6WSqXi1p7z6J0m7BTdCK4LH8YVNkVW0PomlD1DDEG6WE7qHKkAqDHifzDBUVHcfPUuo=
X-Received: by 2002:a05:6512:3a8d:b0:542:29ec:d5be with SMTP id
 2adb3069b0e04-54229ecd70emr421045e87.10.1734685164586; Fri, 20 Dec 2024
 00:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241218122615.1974864-1-ruiqurm@gmail.com> <87v7vf1xw2.fsf@xenomai.org>
In-Reply-To: <87v7vf1xw2.fsf@xenomai.org>
From: Qichen Qiu <ruiqurm@gmail.com>
Date: Fri, 20 Dec 2024 16:59:14 +0800
Message-ID: <CAHR=ZXEL2xPWV0GkFc_Mr437R_5EjXTLkhQ_z+sv6EAjUBooiQ@mail.gmail.com>
Subject: Re: [Draft RFC] Bring POSIX signal to evl
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.
Thanks for your suggestions. It is really helpful.

> However, big CAVEAT: the EVL/x4 locking model is fine-grained like the
> one the regular kernel implements, unlike x3 which exhibits a single
> coarse 'superlock'. Porting will require to reconsider a significant
> portion of the original code under this new light.

Do you mean the `nklock` that is used in almost every syscall? I wonder
what the original purpose of this lock is. Is that a global lock like the B=
KL?


Philippe Gerum <rpm@xenomai.org> =E4=BA=8E2024=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Qichen Qiu <ruiqurm@gmail.com> writes:
>
> > Hi all,
> >
> > Currently, EVL does not support POSIX signals. To better align with
> > Xenomai and Cobalt (see the CXP [1]), we need to add POSIX signal
> > support to EVL. As far as I can tell, there may be two potential
> > approaches:
> >
> > # Approach 1: Adapt the current flags mechanism to POSIX signals
> >
> > EVL offers an alternative to signals called flags [1], which allows
> > sending a 32-bit word to another thread. The flags mainly offers the
> > service:
> > * use `evl_create_flags` or `evl_open_flags` to open a flag element.
> > * use `evl_wait_flags` to wait a specific bit and evl_post_flags to
> > post one or some bits.
> >
> > The mechanism is like a POSIX real-time signal without queueing.
> > However, there are notable differences between flags and POSIX signals
> > that would need to be addressed:
> > * Signal Capacity: Cobalt supports 63 signals (excluding pseudo
> > signals), while flags are limited to 32 due to the monitor's design.
> >
> > * Initialization: POSIX signals are pre-configured and require no
> > explicit initialization by the sender or receiver. In contrast, EVL's
> > flags require users to initialize and open them manually.
> >
> > * Target: In POSIX, signals can target either processes or threads,
> > whereas in EVL, the target mechanism is more limited.
> >
>
> Not really. The Cobalt implementation does not support process-oriented
> delivery either, only a limited notion of thread groups waiting for a
> given signal. x3 signals are fundamentally thread-directed.
>
> > * Sigqueue: POSIX signals can carry additional data (sigqueue), while
> > EVL flags are restricted to 4 bytes of payload.
> >
> > * Queueing: POSIX real-time signals are queued, whereas EVL flags only
> > store the most recent signal, making them more similar to standard
> > signals.
> >
> > While it is possible to adapt the current flags implementation to
> > address these differences, I believe doing so would overcomplicate the
> > existing mechanism. For this reason, I prefer an alternative approach:
> > migrating the Xenomai POSIX signal subsystem to EVL.
> >
>
> The semantics of the EVL flags way too distinct from the POSIX signals,
> so yeah, there is no point in trying to bend the implementation, that
> would not work for basic reasons.
>
> > # Approach 2: Migrate the Xenomai POSIX Signal Subsystem to EVL
> >
> > Xenomai implements a signal subsystem. For each Cobalt thread, it
> > maintains:
> > * A wait channel (sigwait) to sleep and wake up while waiting for a
> > signal.
> > * A sigqueue structure to store pending signals.
> > * A sigwait_context to hold the user-space waiting context.
> > * A field sigpending to track the current pending signal for the thread=
.
> >
>
> I definitely agree that the current signal implementation in x3 should
> be reused as much as possible, no need to reinvent that wheel, although
> as Jan mentioned already, we'd need to consider async delivery as well,
> which is not supported ATM. However, big CAVEAT: the EVL/x4 locking
> model is fine-grained like the one the regular kernel implements, unlike
> x3 which exhibits a single coarse 'superlock'. Porting will require to
> reconsider a significant portion of the original code under this new
> light.
>
> > Philippe once suggested that the new POSIX-like API "would be
> > implemented as a separate driver using the EVL kernel API" [3], meaning
> > the POSIX signal support would be loaded as an EVL driver. However,
> > since signal sending and receiving are per-thread or per-process
> > operations, the signal module would need to attach data to each EVL
> > thread. This integration seems challenging for a standalone driver.
> > Instead, I propose integrating the implementation directly into the
> > current kernel.
>
> There may be a better approach, keeping the POSIX specifics out of the
> EVL core, which was the fundamental reason behind the rewrite btw. I'm
> very concerned about bloating the core with POSIX specific stuff, or any
> other API flavor for that matter.
>
> A separate driver can implement POSIX support, providing one or more
> so-called EVL "elements", accessible as vnodes under /dev/evl, i.e. the
> entry point to so-called "factories".
>
> The attachment you mention is only a matter of opening a multiplex
> device created by such driver in the /dev/evl hierarchy when attaching a
> thread, see evl_create_element() in libevl. So basically, that would
> boil down to something like:
>
> __thread __attribute__ ((tls_model (EVL_TLS_MODEL)))
> int __evl_posix_efd =3D -1;
>
> int __evl_attach_posix()
> {
>         struct evl_element_ids eids;
>
>         ...
>         __evl_posix_efd =3D evl_create_element("posix", "signals",
>                 NULL, EVL_CLONE_PUBLIC, &eids);
>         ...
> }
>
> int evl_attach_thread(...)
> {
>         __evl_attach_posix();
> }
>
> Next, process-wide init chores could be called from evl_init() if the
> POSIX feature is enabled.
>
> Then you would use __evl_posix_efd to oob_read/write/ioctl requests
> to/from the current thread. The VFS would do all the magic about
> resource management, this is a plain regular fd. I can and will
> elaborate on this later on as we devise the final scheme.
>
> Bottom-line: some changes to the EVL core may be needed to facilitate
> the integration of POSIX, but I'm pretty sure this could be made by
> adding generic helpers, instead of dumping yet another API directly into
> a fairly streamlined core.
>
> --
> Philippe.
