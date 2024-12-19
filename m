Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD513D279
	for <xenomai@lists.linux.dev>; Thu, 19 Dec 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623027; cv=none; b=bzfQK0J4o0J2EXtCc1qBjXjxSpR8ln153RSpEkOH5pKwXu/8ijPnlnVmXTPCFOH3UN0AQKxkDWQF5nNBhOCGtjNn02oGbgrAoSnqQpjhGxDc7Bf0fEU7TbDj+skHsHtudsBSH9ViKDcC3CletXoeCLmBA+5stp9DpOngmyRnCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623027; c=relaxed/simple;
	bh=D6iEgPp2fgjWxz3qFAIeVfpXnLwTcC2fqhftRIcIs7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCbX2MSjG+RBLxAvdDDLOBJmf6WaExXUIXv8GxupqI0XNh+aJw4jzOTiV7Wyvs/jPJxKTz118494Bv2pnXmLsEtHs7FMWW9fYMRFwULdA6XlFhXYpbASqRwzeKivBVatopt7dZIpDB6sajtSVj7aCAzZ/GBBKP7kMqYiKJbA1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434e3953b65so6851525e9.1
        for <xenomai@lists.linux.dev>; Thu, 19 Dec 2024 07:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623023; x=1735227823;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu2hAbL3G6wFRL2M8KPH5cX+VhfC0Zmr1pgYC3ca5Mo=;
        b=oW8M6YNMtPATmwWvzCUGKohOoZ6zEsibTkUNVZNK+DuJSp8qTCuzxbXwgxqoA7M9FW
         nPcjCHeoW1xuluZlcDkeDZxv39DQD9DZRrObVhd6YlnuBFRJHLTUGlJTQcPF89ldy9i2
         oq+FrWtb1Kj9q0+oVhMs1TI5ENwY9cwKrXVKz10FyDQb1kb3aT2gZmoChntC1fuKSDwN
         hL5o9oDSsrzzIzBdQl/oZKiZeyXJGiBnRg/ILTRq6ZCtVRfxC+zUEFnD6cvVeC6rVqau
         31WW2cFE7mAUK//ImodzzanVhYh9mbW74Nmq/IqSCUd6ttNJmL65tywlyCeHbO1+69ml
         JzCA==
X-Gm-Message-State: AOJu0YymmCsvS4ULCaHbc+/80bU2mtzZMf2Cd4vhUkDGHHcAHX5m2dL9
	MILv2djvra3JzkwTUQEeTZdAwxtc1ccDpz0ytVZNsQHFTkGKFPhSJhxvvA==
X-Gm-Gg: ASbGncv2B9pmSXSr63Ev6qv0YgcKbmKAU5CmEv6qDZZkVamgxcmPVecIv/2eFDe2ONa
	nPwfZ2FX4p31FxnUxNXi6iIv+LK6dHWgK/hNr6K1CijpNHOuzS6NTO67Vhj1ytE5JYtMb94f50B
	yVeq9Y51QgRN/YC1y4Bnv9n1GerGYuUKVMfk4dWykZnSGy65s2+JN0KLLpqoAQREK4hRviXWdql
	7VcvJTMHwwiG6/8ZbGsLemlVSAgA4/IdMfJQCq3Ag==
X-Google-Smtp-Source: AGHT+IEE57DJHlbM+Gn1dNYId/T67xQsmmeVQ0BSP119Zsob7zLHtZHdMgf4d6VStNybzNfePyQ02w==
X-Received: by 2002:a05:6000:144b:b0:386:3684:c97e with SMTP id ffacd0b85a97d-388e4d84969mr7649865f8f.23.1734623022976;
        Thu, 19 Dec 2024 07:43:42 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b2afsm56563095e9.35.2024.12.19.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:43:42 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [Draft RFC] Bring POSIX signal to evl
In-Reply-To: <20241218122615.1974864-1-ruiqurm@gmail.com> (Qichen Qiu's
	message of "Wed, 18 Dec 2024 12:26:15 +0000")
References: <20241218122615.1974864-1-ruiqurm@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 19 Dec 2024 16:43:41 +0100
Message-ID: <87v7vf1xw2.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Qichen Qiu <ruiqurm@gmail.com> writes:

> Hi all, 
>
> Currently, EVL does not support POSIX signals. To better align with 
> Xenomai and Cobalt (see the CXP [1]), we need to add POSIX signal 
> support to EVL. As far as I can tell, there may be two potential 
> approaches: 
>
> # Approach 1: Adapt the current flags mechanism to POSIX signals 
>
> EVL offers an alternative to signals called flags [1], which allows 
> sending a 32-bit word to another thread. The flags mainly offers the
> service:
> * use `evl_create_flags` or `evl_open_flags` to open a flag element. 
> * use `evl_wait_flags` to wait a specific bit and evl_post_flags to 
> post one or some bits. 
>
> The mechanism is like a POSIX real-time signal without queueing. 
> However, there are notable differences between flags and POSIX signals 
> that would need to be addressed:
> * Signal Capacity: Cobalt supports 63 signals (excluding pseudo 
> signals), while flags are limited to 32 due to the monitor's design. 
>
> * Initialization: POSIX signals are pre-configured and require no 
> explicit initialization by the sender or receiver. In contrast, EVL's 
> flags require users to initialize and open them manually. 
>
> * Target: In POSIX, signals can target either processes or threads, 
> whereas in EVL, the target mechanism is more limited. 
>

Not really. The Cobalt implementation does not support process-oriented
delivery either, only a limited notion of thread groups waiting for a
given signal. x3 signals are fundamentally thread-directed.

> * Sigqueue: POSIX signals can carry additional data (sigqueue), while 
> EVL flags are restricted to 4 bytes of payload. 
>
> * Queueing: POSIX real-time signals are queued, whereas EVL flags only 
> store the most recent signal, making them more similar to standard 
> signals. 
>
> While it is possible to adapt the current flags implementation to 
> address these differences, I believe doing so would overcomplicate the 
> existing mechanism. For this reason, I prefer an alternative approach: 
> migrating the Xenomai POSIX signal subsystem to EVL. 
>

The semantics of the EVL flags way too distinct from the POSIX signals,
so yeah, there is no point in trying to bend the implementation, that
would not work for basic reasons.

> # Approach 2: Migrate the Xenomai POSIX Signal Subsystem to EVL 
>
> Xenomai implements a signal subsystem. For each Cobalt thread, it 
> maintains:
> * A wait channel (sigwait) to sleep and wake up while waiting for a 
> signal. 
> * A sigqueue structure to store pending signals. 
> * A sigwait_context to hold the user-space waiting context. 
> * A field sigpending to track the current pending signal for the thread.
>

I definitely agree that the current signal implementation in x3 should
be reused as much as possible, no need to reinvent that wheel, although
as Jan mentioned already, we'd need to consider async delivery as well,
which is not supported ATM. However, big CAVEAT: the EVL/x4 locking
model is fine-grained like the one the regular kernel implements, unlike
x3 which exhibits a single coarse 'superlock'. Porting will require to
reconsider a significant portion of the original code under this new
light.

> Philippe once suggested that the new POSIX-like API "would be 
> implemented as a separate driver using the EVL kernel API" [3], meaning
> the POSIX signal support would be loaded as an EVL driver. However, 
> since signal sending and receiving are per-thread or per-process 
> operations, the signal module would need to attach data to each EVL 
> thread. This integration seems challenging for a standalone driver. 
> Instead, I propose integrating the implementation directly into the 
> current kernel.

There may be a better approach, keeping the POSIX specifics out of the
EVL core, which was the fundamental reason behind the rewrite btw. I'm
very concerned about bloating the core with POSIX specific stuff, or any
other API flavor for that matter.

A separate driver can implement POSIX support, providing one or more
so-called EVL "elements", accessible as vnodes under /dev/evl, i.e. the
entry point to so-called "factories".

The attachment you mention is only a matter of opening a multiplex
device created by such driver in the /dev/evl hierarchy when attaching a
thread, see evl_create_element() in libevl. So basically, that would
boil down to something like:

__thread __attribute__ ((tls_model (EVL_TLS_MODEL)))
int __evl_posix_efd = -1;

int __evl_attach_posix()
{
        struct evl_element_ids eids;
       
        ...
        __evl_posix_efd = evl_create_element("posix", "signals",
                NULL, EVL_CLONE_PUBLIC, &eids);
        ...
}

int evl_attach_thread(...)
{
        __evl_attach_posix();
}

Next, process-wide init chores could be called from evl_init() if the
POSIX feature is enabled. 

Then you would use __evl_posix_efd to oob_read/write/ioctl requests
to/from the current thread. The VFS would do all the magic about
resource management, this is a plain regular fd. I can and will
elaborate on this later on as we devise the final scheme.

Bottom-line: some changes to the EVL core may be needed to facilitate
the integration of POSIX, but I'm pretty sure this could be made by
adding generic helpers, instead of dumping yet another API directly into
a fairly streamlined core.

-- 
Philippe.
