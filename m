Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023D626
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 07:49:22 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 07498200002;
	Mon, 26 Sep 2022 07:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664178554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQOgqxjTJcvwr/NqBigRUosgTpv+d8We8gP5Yiox31c=;
	b=Z7C4O8y2csPjwG22hq074ks4bDJCpAVTCKDxDKTeMdeL4yORqiczUoWZVABarHl2FLT+4t
	/gU8EL4HKZZvJLVSZTtBvngXsRqZBthar32kYElNn9QSGzWUTjgYTQKd9wj/GpaZRwJ1K6
	3CqGFLAXMrvHOwJ86LoUF6SmQDoa1QxMDw4iCLC+pvG0dch4cyWZqtvYbVkdafuucnMFsp
	plPJVoRiwYNoeE85SJIQ+g0lIh0ePYXkQXU8cHJykUUz+htUwLO8Oq5Ggg6HcfSYaqygk7
	vzmQNfZv4NZjIoZfrKneBTyIV9ylNvJDYK+5grZrOyoNp+Yd//lO77AH9uqnGg==
References: <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jussi Viiri <ilmai@iki.fi>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] revl: Add sched() to thread::Builder
Date: Mon, 26 Sep 2022 09:46:00 +0200
In-reply-to: <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
Message-ID: <87czbishhj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jussi Viiri <ilmai@iki.fi> writes:

> When spawning threads with Builder, it wasn't possible to set the scheduling policy of the spawned thread as you don't have access to the Thread object after spawning. Added that option to Builder.

Thread::attach() returns Result<Self, Error>, so you could still invoke
Thread::attach().unwrap().set_sched(...) afterwards, I believe.

-- 
Philippe.
