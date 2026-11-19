Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115701;
	b=obqIgqKkX0ONuSV0BNXFUyQy/G/Pd8M0/EqTlZ24NNIM5ZG8rrN/Y1CTx7rEc7tMQaIL
	 i40o4jYVLsCQln+TXfgs6GmhGyjmDI0NsuBNKYk1l8fbvD2EaL71TH7Ozinw1ZRYsEbV5
	 HGzcgLqvbgWHDw2XrU0GK+y0ALywWQyc7JG6X6d/GaZXSxr0hWXCLOjFoiOPsnwfmN62u
	 OO6i1iU3gKKtk46HeaCbka5A/XHwmZTE+fGtaWPvm6l8nKd5/RW2xcx2zDEp9dQEW/3OL
	 rGdaTUKYgkE0en3kKZtjP0Ye7aORw9DxsJr/45pZKD0qiMLjrg/wJ+P2Ovbbq369nog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115701;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=Z6zShrd8I4FJ723hx9Cqnci9FaoZMNLIdXj2Hk1OH3Y=;
	b=nT5vaaM4U3fGR5oxWb2MBeXd941UVkXVxt5Yi3XSjKONnFQsFbhXMUb7uSqjpKq2eo/L
	 EeAh/23jfzaa9CN5IF8Nu7jFWaiD7IUzKRPV/9/r5hUjpL3nyTuhzYt5JB01EFeLJ5OJg
	 /Gr1XD9ubN7CZxY1Jmm6uEHgV4gN4nhEsG62BAlU1H8FINMV4AIbkPIem3RtxWX/sUilN
	 g5HXSSeAmYE2NEJVvtSxniqvSHqLpqTvpzK9uisVRZXTbHGwXM01Io1zMEO3TIlxWayNs
	 ystT6Br5SmcpC2Fz75qMP9D9FMZ75z0dKa2uR/QbdKMDJMbydAbsJL12fYO1yNh8ymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=kDUnuGqw;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8896606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 19:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8896606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=kDUnuGqw
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A7FD3E9B9;
	Thu, 19 Nov 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795115692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6zShrd8I4FJ723hx9Cqnci9FaoZMNLIdXj2Hk1OH3Y=;
	b=kDUnuGqw96w4HGIWg5c2mI6GJIu7vch6lHLz7pRVKW0lMF/hdq0ooIuidEwTJlRU9nNQMF
	XDEgkxpfZjqZlTyia8UWCsIo2OLF9g23sooGVgpoYE8oub/NGz+AoYfE0p3CSloJvQ8UDR
	lzFiYGJUPerRC41bZhoT6Cy3apAedNkT3rZz54P+w1rx+lCgAsRUd78gpt9fzGUbhzTi82
	oqqa5PUpgWNUixGKBQmq4bvjfJDNZ9PgDAjwlVs2t5u1rOGy0K8kAw7bWuxieW+NI8gp5x
	q/Jpbu76x7AgHx25OLzm/hJ+gBgtd3c6P1ox4fu3cXuAk8gbl3jVlSzwZ+oAmw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [RFC PATCH dovetail 0/7] rv: runtime verification monitors for
 Dovetail
In-Reply-To: <20261110180847.633167-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Tue, 10 Nov 2026 19:08:40 +0100")
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 20:14:51 +0100
Message-ID: <875wxsocpg.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTETkH4H+AxZ8QTFfNshQXFDPfPfmOEDJZkSdmDhN1H0DEGgfke2CfCoPIvWibA0XVBBRCDww6XTIuEL9YbAG+iCFYSLOU+UuSKzc+/KEvV858pSIaJpgmqj/usQD1u/dg6xg5lhGWhMH859ASYKbk1bl89QYy36ymR5H9yxeelUPJLuqMj4OzYzuEtNlygO3Ot9sqFxUi4cE2QIKrM7DA8ohUHwLXKFA4CPalKZIk9a6WbSpy+d+XOC2weZ+XLB+guVcLbMhvsLU1PCvNsqnivqwCx7h3pTP6IkixjnmvgxL90hY2UeTnO9dhdmcr1SCgNokiZHAU1mEVFmRoc58i2Wq2i9cbB7HS7ffuzN0I41mTyzQx6hGsH+Mle2KAT3S+o97rFzX2Xkw2QKByINpvlpljAxLJfKo9DgMJ/jyH5snJpc7QilkKAKDDwhTOocsGw5UHIrTMvf+Atag2yk2bGcUXm06pbvZibTjgf+By2N8dnn33l0T7sUXa7cSeAR/45Aa14cdWlcraYZpeeKpo5hOwbeb8YOgwVyQDVFtb+bRRVn5077vEf0GulZ3Mn5xEB3GuoDwZUBxaKPYxUPrHp1zMrnJJUH1ttibQhPxoIZOAFg+RNUE1n1aee+9gQiTlIcGGSNrysZYLwcMJVdGKPAtWfITYy6KBNPdyHJ57EyTA
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi all,
>
> with this RFC I would like to propose using the Linux kernel Runtime
> Verification (RV) system [1] for runtime verification of Dovetail based
> cokernels.
>
> Running a system with RV monitors active should ensure that the system
> behaves as described in the model. As this is checked at runtime we can
> verify if the system is even behaving as inteded when it is running the
> real workload.
>
> My ultimate goal is not only to use it for verification but also for wakeup
> latency tracing and decomposition in EVL by describing the whole wakeup
> path. I am working on upstreaming dwell time measurements in the RV system
> in parallel for that [2].
>
> This would allow us not only to get a worst case latency and decomposition
> for a latency evaluation tool like latmus but to get a worst case latency
> for any load applied to the system (e.g. the real application of the user).
>
> This patch set proposes three Dovetail monitors bundled in one container:
>
>  * offstage checks that Linux leaves a task alone while it runs out-of-band. It
> must neither schedule the task nor let it raise a signal on itself.
>
>  * oob_trap checks that every out-of-band trap notification is unwound for the
> same trap before the task goes out-of-band again.
>
>  * oob_signal checks that a task receiving a signal out-of-band is kicked
> in-band. Once the cokernel handled the notification, the task must not return
> to user mode out-of-band without a mayday pending. I think his monitor found
> a present bug in EVL: since "evl/sched: get rid of this_evl_rq_thread()"
> evl_kick_thread() skips the mayday for a thread running out-of-band on a
> remote CPU, so the thread ignores all signals, even SIGKILL.
>

That one was bad indeed.

> For the monitors the series adds a few bare tracepoints to Dovetail. They are
> not exposed in tracefs.
>
> The monitors can be built by setting CONFIG_RV_DOVETAIL, which enables RV,
> the monitors and the printk reactor. oob_signal is not available on 32-bit
> arm yet, as the out-of-band syscall fast path there is written in assembly.
>
> To execute them:
>
>   # cd /sys/kernel/tracing/rv
>   # echo printk > monitors/dovetail/reactors
>   # echo 1 > monitors/dovetail/enable
>
> Looking forward to your feedback, input and ideas on how to use and improve
> this further.
>

Did I already say this is insanely nice and useful work? Hopefully, I
did. I'm looking forward to merge RV support into the EVL core and
libevl.

-- 
Philippe.
