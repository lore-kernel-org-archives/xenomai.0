Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99CD280CFB
	for <xenomai@lists.linux.dev>; Fri, 24 Apr 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042964; cv=none; b=jHI0fedNQ6HPDCXPpI2CWpyLCUsslxDsXKcz4iTYZJb0f8CCx3szNzHWQQRydMYUltiCwen7wzgm4OCsKmc8PeuhVJvdRJsefoX7N9xjUZLxeyLnjMhE3evczsAuyhNti7g3PAC4AOnqep9SpuH+/wfYHy8On6SG2B2NrbKGssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042964; c=relaxed/simple;
	bh=tzjKG3xNDTA9zsuMdtq8E85V8matAaP1G8nwcz7iyW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nb2HtwiWIvR4vgXMWHd9gIi2e/9Fj3O4E5npNH+wcTduzwJgTbYbI1tYzZ21Eh2LXEtPdsdMKy+e20mcEJIfTE+89A8zrq7v+lyj1vdK6WgEaRMrdfPrPCRGG/bpA3Iz0lWLD88TGbst0F3Uucm3t5iKbmmduK+HXYts9gmALt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MIE4B5v1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MIE4B5v1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 930E03EC56;
	Fri, 24 Apr 2026 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1777042953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbJARKizeySH4OfHjHSwKoaPcp4BDUkP1ZLG7p7rFWg=;
	b=MIE4B5v1z89QZ8sKVY6Z4pCNkn5q/SkJNXV2Nu8MJl9w6jmofSGmWu8OC+AguAuFu7QpnS
	kkJW1Jn/Rr0VoFfMPNsV/TDp0nHcCqLfCfjBpKXapkYSvLyeXJ/IHueRqg46N+bgDaEzaM
	dpV/T8eCQDjIGj8seThLyCnsUK37POkte8SieATIReCqHXnBpeVSN2i5ftqONwzHtaH6Iu
	m2LMvHVrddOEs9L8kt/2NUbCjx/VUNu6+t1vkYErp579Nw8Q1SwfTCvsBNBHdFgV94T1fH
	XhR0eUm4PgU6iRKB2xndPQsNxOp7Wc8+/5tlHRGkNfSkJ4aPamcjik33buuhIg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jesus Villena <j.villena@ecler.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL] element-visibility BROKEN
In-Reply-To: <AS8PR10MB7731181CFB7CA13EB3A8C4F7F92B2@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
	(Jesus Villena's message of "Fri, 24 Apr 2026 09:59:36 +0000")
References: <AS8PR10MB7731181CFB7CA13EB3A8C4F7F92B2@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 24 Apr 2026 17:02:28 +0200
Message-ID: <87fr4kqu4b.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFc75aWwl2ybB1B0MgqzMFUau/edF3SIENmqy8BIYLsxTZlth2RuIExWuwOAOFnAsrVnFxUnLEzVw1hpmx8MC1DpQsOdyJhOstInm8szL5Ie5vdyve1TBAIUcoRXaw1gdvHJhIQGr/ycJUuy6KZk+74jp6X3JY+Xy78ZjuSaX4CqBpX60zrr7GNAgd1zFUSCLwS59cBYhNtO3qA5237OGe6pEdrdEk8kC2TLqNxuhOlsk7sfMPXB/9RU6lLCvUfv0xCzAGaZheZpC6dtVhdaSFJX+88tKB5ZSOIbt5CUI6kbLtYDJ7DCsp3boAfca25PDzP9kbuEyjb0YDn2m7WB5KUjpd+Qy1O3JrPO5jc1sw2QwOzwf+yLNTiwPueTJjiFlWNyRv9jpWgG6c4d9OPcOzBKlN/Jm+3DdsRmleucm/6YFxRaxywU5Owai5NmzcWGLlfCRBjieppL39yte1rCHS2DjVLbr8hALQaoNHjuFkniDPPyvu+0dmZuvVNtFl2tnpovzKDh1DTu8wRtOdKWBRKfW7Zc4GDlqXrPMHoA+Cv+fiMo+oBQyq7ozd4wRwaQWTA2ZuP1Yf/V3pY4+PR4NJ0tgcdzOFTBQu5OiCi1OQdEDLRB53PerLdSkAg5PWnwk1Fu2DtsijExGfmyuck1Qk58r7iHB+c7UbooEWM9vkqvw

Jesus Villena <j.villena@ecler.com> writes:

> Hello,
>
> Trying to validate the latest evl linux kernel version 6.12 on a RPI CM4 based board (the v6.12.78-cip19-evl3-rebase) with the latest libevl revision (r56), I have found a test case with problems. Running the following command line:
>
>         evl test element-visibility
>
> The results are OK or BROKEN in an arbitrary way: sometimes it ends with OK:
>
>         element-visibility: OK
>
> other with FAILED:
>
>         ../libevl-r56/tests/element-visibility.c:60: FAILED: !element_is_public(path) (=false)
>         ** element-visibility: BROKEN
>
> Has someone discovered the cause of this wrong behavior?

The test was wrong actually. Fixed in -next branch of libevl (commit #3ddfd3f).

-- 
Philippe.
