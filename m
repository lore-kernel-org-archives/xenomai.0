Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71009279918
	for <xenomai@lists.linux.dev>; Sun, 12 Oct 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280295; cv=none; b=f/7ysboJ4yY5gWD17iGJvqS1JaX+lQzr1xksz7WXa45ZGG24+FoOUj6Oblr+yeZCQuMoO0BxD52uHZeAW51NvGDseHmOkaBiQFkfyC8WvKZYOBLdYCYaQZ+SPSR8UAcslyizufOkSI1Gh1awyUi96s4/wdoqB/Vq31EH7oRgkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280295; c=relaxed/simple;
	bh=p7vY3F2okgqBGqgwz33t3YtnFfkXuhmJiNU1V705zG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/wF8MpSDPQcp3Hocsim9Dm8/QTsFz7n5wbKShsI2529H7E7vyS2IwQeTTYLYuTtBq6AUpSiINyjOo8s/LO9CT7lYKavRXObAx702moVSODtEKzk3HAKeo4R5e6Ga/Ar6qojk5dQkAJzUc1FrhygEqJzbn10FrYvmNCm+TnzD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=g03f3Pp/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="g03f3Pp/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AA70442D1;
	Sun, 12 Oct 2025 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760280290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwLMQjREZswm+VQeOCNJM86D3FR6U4qXX1bh0WZID9A=;
	b=g03f3Pp/f0M9A1vDeffJYVZ9fCOMZSra+2hpC7YiJmS5lvUOIi2ogPLOzx31/hw9ec7p3j
	69B0q7Hj9l9EpbP4mKuQ4JLm1WGdYaUL/EwmT2tuPyfaX+QqYDXl8ImjpIjO4l7sKvSK3g
	TC65GTPE5BSrAHAXscEokDbawgzGTAjpt4i5VJhRjbHAiWVlZPBTZxJxNEBF27s1lXfoBu
	N/W0iEOUS+aUxW6sX7G6BQlybqAPkRRVshq6NhfxbRewXfFW4KFbGSOgUy+Zh5o6aVLUYy
	9nRwBsIutScQiGOqogOUekWkd/Mt4q+aNS8SEImixEGjyDDvayxdCCeV/qzVKg==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <be366ae4-b0c3-d6b5-25f2-813424f47c3c@bela.io> (Giulio Moro's
	message of "Sat, 11 Oct 2025 14:46:56 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<874is5s6kw.fsf@xenomai.org>
	<be366ae4-b0c3-d6b5-25f2-813424f47c3c@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 12 Oct 2025 16:44:49 +0200
Message-ID: <874is4i3ha.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

>> Quick check: does "evl check" run without any output (as expected)?
>
> Yes
>
> Further update: tested v6.16-evl-rebase and it seems to have the same in-band switching issue. So far the only good one was v6.1.y-cip-evl-rebase.
>
>> Meanwhile, I've been trying to reproduce on x86 and armv8 (odroid c4) using the posted recipe, no luck so far.
>
> Thanks for giving it a try. Wanna have a look at/try my config? https://github.com/giuliomoro/linux/blob/v6.12.y-evl-rebase/.config

I could not reproduce this issue yet, neither on x86 nor arm64, trying a
bunch of configurations of linux-evl/v6.12.49. At this point, the best
approach would be to track down the latency spot on the TI board using
the 'latspot' (f)tracepoint which latmus triggers each time a new
latency maximum is reached, so that we might find out the reason for
taking those minor faults which are causing in-band switches. There is
some documentation about its usage at [1].

[1] https://v4.xenomai.org/core/commands/index.html

-- 
Philippe.
