Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55AC2C3
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 09:51:12 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6339020004;
	Sun, 16 Apr 2023 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1681638663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7P8yZRZtWMksH8QyAS0hJb7w8JklHrtV70/vr6S61Xs=;
	b=hxI7iMwVJkgJCnX2Pq8jvTLUrZlc86st7tq4zVHgU91Z3zk8DCfmSQeH24seOmtDDi6d7V
	7CFnnOm3kPeVbjtnDmVXdEvY8Tsl3UeUApetJSuY3GmftcmM050S7kYPeQVt/jTLPHkNzH
	r1Bq0oavVADonCjORG1VO/qGa/2kLHxjHoBVdhWHzcIxIM7Rf3fYyG6YamGgeqCunlMBym
	y8VVW/s+ZJpjY6tg69cDmoltCVH+22Wtmu0Zn0Q14hHJ7stZ48DC3ZBohg0FOj+tz1ifuz
	fUlSBuDVPuiZvHfU2rYDL6E/rSfKQD/F9lzd3u4gLw1DlDzvdnifGK3eeLZHBQ==
References: <d9608046-cbd4-ebd2-c440-d668e47c471f@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: tracing: irq_pipeline: skip RCU check if oob
Date: Sun, 16 Apr 2023 10:59:35 +0200
In-reply-to: <d9608046-cbd4-ebd2-c440-d668e47c471f@siemens.com>
Message-ID: <875y9w9mux.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> I just found changes like [1] in dovetail, something I did for I-pipe as
> well [2]. But, as I wrote in the I-pipe commit, there it was laziness
> combined with carefulness. I don't think we need that laziness at least
> in dovetail and fix that issue properly (rcu_nmi_enter/exit on oob
> entry/exit?). Or what were your thoughts?

Currently, when running oob, RCU is forced to watch by rcu_read_lock()
which calls ct_nmi_enter() as its prologue, hence the laziness in the
tracepoint.

But, this somewhat defeats the "lightest-weight conceivable read-side
primitives" mantra of RCU, this looks more of a workaround than a fix,
so I'm not happy with that stuff.  We should rather make the inband
kernel consider the oob context on a CPU as an ongoing read-side
critical section RCU-wise, just like common preemption-disabled sections
are these days. This would have two upsides:

- making all these oob-specific exceptions to checking that RCU is
  watching plain useless, by telling RCU to _always_ watch an oob
  context as an ongoing NMI, not solely while running a pipeline entry
  like today.

- generally enabling the read-side protection for the oob context, while
  leaving the QSBR work to the in-band context.

However, we must be sure not to leak oob read-side sections into the
inband context, i.e. being cautious about oob -> inband transitions, and
perhaps more tricky issues.

-- 
Philippe.
