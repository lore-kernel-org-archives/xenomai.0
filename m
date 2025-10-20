Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5C31DDB7
	for <xenomai@lists.linux.dev>; Mon, 20 Oct 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968883; cv=none; b=TkxYYe53xB6ET6Q7jBjFzz6/5Hjelj8bx1cx3fbACAqpxPlfsiyzL6nuAoXGiOg+V8wFYLDJlPQYXLO7fbw4ZQEw3FBVSwiZWuvtzukkTjIDtB8SMi0MsculHJ5AABoBm2410MJHWOA+MgU+ocR1+EJOL73Pz9rBkYEHu1pwuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968883; c=relaxed/simple;
	bh=ntXSCNGYX0a/iE+f1vGSEeA+9203zKvj4Wpwqqc6iMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTTAO6/Zfn/9Xy/4dNZen+Tvi1b1tHF5gzpbWL6DPTv9zBounlJQ1bvFFs0E3sfGBY3wI2iCyCLp5xPpB9tTLoMJ/HrUrS2bIm/tY171R8eOY5levMOwtbJuJMP4dnOT0abl2UDlFt5peOYVoUjY9hJBBS8uhgwLiFRNsgBhpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bzFVaWTo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bzFVaWTo"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C433C43A8E;
	Mon, 20 Oct 2025 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760968873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntXSCNGYX0a/iE+f1vGSEeA+9203zKvj4Wpwqqc6iMA=;
	b=bzFVaWToW0Ef5/bTs+5Q5PGypSTrShPVW7iw5IDrTjoozeTbbTbQe8x4HPfFcKdVdiFDz6
	R86mJoOJ1h051P+PbnBF9ViK4cERPpMUi0oFLMDilp5q9Q9ICjm47I0ytdvSgJFu6+mBg7
	oV3fTJeCqjirw4GGEuXs6zeP7JnOrxbFfYLR90uH2MDTcMo+ssD0xL8MappPmxVgBbQjaa
	1cH9Bgkk28hkHnY+e5Ko3yeEEAfKcCCRLJxXu3AKVbm3migi2i9/X0ynjs0wnrZbTZZjaM
	PjUXssjDrC9oW+AmU+m3ZF44IMTFG8Dd5GFsbyrK8xabQMkvYQlJ2BZ+oEEs4g==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io> (Giulio Moro's
	message of "Mon, 20 Oct 2025 07:46:10 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 20 Oct 2025 16:01:12 +0200
Message-ID: <87o6q1ad07.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

> =C5=81ukasz Majewski wrote on 20/10/2025 02:47:
>
>> Could you share which version of libevl do you use?
>
> I was using the latest release of libevl that was compatible with the ker=
nel UAPI.
> Sorry I haven't provided more details on the issue; I am focusing on buil=
ding an image around 6.1 for a deadline coming up next month so I haven't b=
een able to get into tracing yet.
>
> The only additional finding I have so far is that there seems to be
> something on the Linux side that "breaks real-time" which affects both
> linux and evl. In the below list, "evl bad" means that the above
> mentioned ISW are observed. "Linux bad" means that I see a
> disproportionate number of underruns under stress on a Linux program
> running with SCHED_FIFO and priority 95 with a period of 360us. I
> understand "disproportionate" is a very subjective term but, to give
> an idea, over a 10 minutes test I get a couple of underruns with
> "linux good" and I get hundreds of underruns with "linux good"
>
> v6.12.y-evl-rebase: evl bad, linux bad
> v6.11.y-evl-rebase: evl bad, linux untested
> v6.10.y-evl-rebase: evl bad, linux untested
> v6.9.y-evl-rebase: evl bad, linux bad
> v6.6.y-evl-rebase: evl bad, linux bad
> v6.3.y-evl-rebase: evl bad, linux bad on startup only
> v6.2.y-evl-rebase: libevl r42, evl good, linux good
> v6.1.y-cip-evl-rebase: libevl master, evl good, linux good
>
> Not sure if this is of any help; I hope to be able to get back on this so=
on.
> Best,
> Giulio

If someone could send me the relevant portion of a trace file with a
'latspot' tracepoint triggered on a latmus run, I could investigate this
issue. I'd need the function tracer active on all CPUs, with all traces
dumped to a single trace file ('evl trace -ef' should do).

--=20
Philippe.
