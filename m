Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E4257F
	for <xenomai@lists.linux.dev>; Sun, 10 Sep 2023 17:38:32 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31DC8E0003;
	Sun, 10 Sep 2023 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1694367503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PFOgXPdZFtWbCM9OCRDAqhtsWjAhC5r4cLfjrgW/c+w=;
	b=O4bkTnpsjFt4JkGXxEB7UNLv5E66pWIebiVAl3Z1xUMzxS+psdZ9jW+42Uloo8cDBR34xr
	f9zyuVG9ytl3xYO97TKHhq9wICheH6Ols3IxN/RAEOF+j8JwJiWcyWmjWN+Ibef24n9iKT
	0iRvyrwDwpxf4n+qal29x8+9yn4JWeBfoQ2TdTy4bik2xscwOoq04uvodzXD/tIFKB9nzn
	XWAvdk150RFhIYvudGaee+zRMVkkq2gh2JSkn/P6vFt+655hyoxdOz9pX9MRrrd79sz3dy
	/scEPu8Q+LeiNUnPxmEkn98Wac/8oKYO4jBVRlxT/XfzDcFFe1SpdqHiZm04hw==
References: <a59cde89-8bf6-4f94-814d-20c3456cab05@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Johannes Kirchmair
 <johannes.kirchmair@sigmatek.at>
Subject: Re: [RFC][PATCH v2] x86: dovetail: add dovetail signal setup function
Date: Sun, 10 Sep 2023 19:02:04 +0200
In-reply-to: <a59cde89-8bf6-4f94-814d-20c3456cab05@siemens.com>
Message-ID: <87y1hevshd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>
> add an interface to dovetail for signal frame setup and restoring.
>
> This is useful for implementing rt signals within Xenomai.
>
> The interface makes it possible to use the setup use functions provided
> by Linux.
>
> This is just a proof of concept using a very naive approach using most
> of the code provided by Linux to setup signals.
> The patch should be discussed, especially considering if using the
> Linux functions is viable in a rt context.
>
> Also to discuss would be the interface itself,
> for convenience I used the kernels struct ksignal for testing. But maybe
> we should maintain our own struct, that is not that feature rich.
>
> <missing signed-off by Johannes>
> [Jan: moved everything into x86, fixed might_sleep issues, return code massaging]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Philippe, this is not yet final, but the question is already if we are 
> at the right abstraction level with this - and if the EVL core would 
> consider implementing RT fault signals on top of that as well.
>

Regarding EVL, I'm not opposed to implementing oob-delivered signals
(anymore) for the purpose of dealing with the critical error recovery
path Johannes and yourself mentioned during the early discussion about
this, which sounds right.

However, the whole idea of duplicating the frame setup logic does not
look right to me, at the very least this goes the opposite way to what
I've been trying to achieve with the Dovetail rewrite: a saner
integration of the oob services into the regular kernel in order to keep
the maintenance task tractable - which worked fairly well so far. To me,
the ultimate scarecrow would the stratospheric mess we reached,
afterburner fully engaged, with thread switching [1] until xenomai3
moved to Dovetail.

More investigation is required to find out whether making the
setup_rt_frame() and friends oob-capable is possible though, at least
for the code paths we are interested in. I believe that we have enough
infrastructure in place to detect invalid use of vanilla code from the
oob stage, in case upstream changes the signal related code we'd want to
reuse. Duplicating that code instead would cause those changes to go
unnoticed: I'd rather fix an obvious merge conflict in Dovetail compared
to a tricky mismatch arising between a Xenomai-specific frame builder
and parts of the common code (e.g. signal-aware stack unwinding in
*libc?).

So far, it seems to me that we _might_ be able to reuse the common setup
frames, provided alternate stack support is disabled for oob-delivered
signals. This still needs some work and a proof of concept to make sure
though.

[1]
https://source.denx.de/Xenomai/xenomai/-/blob/stable/v3.1.x/kernel/cobalt/arch/x86/thread.c?ref_type=heads

-- 
Philippe.
