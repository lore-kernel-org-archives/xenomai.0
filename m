Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D2441036
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328456; cv=none; b=cL0L0xsnf5VSRbTkcuW2tabj5IvhomYb2yyAKyAZyoM0QEQZtcVqG4erTwtcdObf7dBJvGVwT45bX+6e30VxnkqAlzz6iTiAWc2ZN422wPwvnSbKVXnftieYpiRM+YsmZ4s+B4RLvg4HmvxA3K8t9hS2AWwKECSxMCh+c7LZYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328456; c=relaxed/simple;
	bh=cvDmc/Hu8qxemDMlWXyN3a99Fn5Ujcr/lJFe1WENPgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rm9FlvI13DKlnLBTNrSpVUQoK5+LHY+KLofxG6UJ2biZrLC4mhDJA3cRJwSPly9Fyaz9wF7n0e415gfBB4fvsiM51steE48RsW1dgFh7ldZXiDbKUzKJgDupD1cxbrHx843Bpmv9tkdvbsQYE6kTjhhftG0Y2yQR9KIbQQRT/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OZdFJt3J; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OZdFJt3J"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C4B93EC0A;
	Mon,  6 Jul 2026 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783328446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0yOobwbiIm2W/FSZDe2F8bh8qB2Mx6mN6/gYkfJQMs=;
	b=OZdFJt3JaEwSsSFQurBIAlDbSN4aGD1jQCdCWWMjxzXGNlFy8VnFHcgC9/zHUKUacMnBxL
	EkzKwg7zeMuBaUN540K4y0ayOtK/SS5rtB4toqB2mQmGFASsoR7e6mjHlBdBqtpkXvJFOy
	0haUXVK5l9pjxE7/vHiJDpg7YKUJHxikqZ3i/irTXgHKHtUOCkBKZNtdc5h+RZ/uksmKYt
	96PkqyR2AEKjot9fzVztRPhUtx4CRpvy+vk5Bcjr8+4OIivTTARY6Lb4kUjNs0N6UXHU2t
	reKKRBnFztAC/UjEKeYKVqLGKRdeGp+En4iPA6fwjdWspgFEW+0pNcurxiwIEw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH libevl 2/4] evl-test: run latmus in the end of the test
 suite
In-Reply-To: <20260703122924.30212-3-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 3 Jul 2026 14:29:22 +0200")
References: <20260703122924.30212-1-tobias.schaffner@siemens.com>
	<20260703122924.30212-3-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 06 Jul 2026 11:00:45 +0200
Message-ID: <878q7oqypu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGA67d+OEZ84vUpqLGZa66ZED86TinVQsANIt5+IJoG3PJg2iK2HQprqX7N/AFIVDKV99WsuKc5HnysjUpjValdA2TuVdx98PQn78tJtkcqrPwxjamCM2yNrXl6mUMhpjHFJTBC5uWWoilaHgo+bhpkwVK2ZciLyc6BLJZz0fPusZv1kK+UIDkkFQmDIvDp9yqox+etIPd0gTBmFoKFEmjOoVjEIg+2x/drN8nZ5SAHMuvIG7zT3ZxsPCdCyyD16JNNZh2JnRgm9vQyDT1G5652uJIKW1pSjlfgWEikm8kN3Ev2CeG7AU+9UQM0g5gaDVYwMm+iA8IBGfeHrf+1E6VZLPrOQtdeTYAydqYOTed0q0z2xsEN6yAl40svJ4qjxSiQiEp2uYhmUK9cVult6iTeKmFghqVugSTjibxEjM6nzJHe0RjI0mI/7rCpV4shHjb3dvEIs76aqoz5GRaa82KB/JIllcLzJSdETDlQ/fVSMKzSeq6cbxQynXrFoX6M4AlfOKnB9iP+JWgdxyJQraIho7AqMEGm9YRp/TedtnbKgYxSU8m5UZd0nT40PzIedAExfrUBry9KslJerzfKOBC1LJ/tG0aLDHBV8GOtKngNbfnvi3yx4RFVsv2eByqqgPESjEq08iEZsB/rE3KPO+cZo9b5VJKoSbNbwW1CB4AaHA

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Run latmus at the end of the session, before tearing down, to allow measuring
> the worst-case latency under load if a stress-command is given.
>
> Add --latmus-args to pass extra arguments to latmus (e.g. -A threshold or -T to
> override the runtime).
>
> latmus runs quietly for 10 seconds by default; a runtime passed through
> --latmus-args takes precedence. Its own output is dropped by default and
> can be redirected with --latmus-out.
>
> Examples:
>   # default: tests + a 10s latmus run, latmus output discarded
>   evl test
>
>   # fail if worst-case latency exceeds 150us
>   evl test --latmus-args "-A 150"
>
>   # measure latency under load for 60s, save the report
>   evl test --stress-cmd "stress-ng --cpu 4" \
>            --latmus-args "-T 60 -A 200" --latmus-out /tmp/latmus.log
>

The purpose is fine by me, but the integration logic looks too
complicated. Would it be possible to simply have a 'latency' test (as a
shell script) available from $libexec/evl/tests, that would launch the
latmus executable under the hood with the provided arguments?

Spawning it would amount to using the common syntax:

$ evl test latency [-- latmus-args ...]

With this, we could achieve the same goal with no addition required to
evl-test whatsoever:

$ evl test -k
$ evl test latency -- -A 150 -T 10s > /tmp/latmus.log

-- 
Philippe.
