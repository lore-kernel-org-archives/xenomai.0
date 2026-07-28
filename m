Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC03546D6
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220669; cv=none; b=fSmOaLNS43FeESZG3VJSO/YeBa/ZduYEBoDFqbHm/ASpm55aQHvb7+6uXt3YQa4Uj1K6kCQijH6GTMOcQ/XGEznqrqbbQhT0YwIwYTPyfQq1Qw8PBYPE6WKSoNMKDTMiStw6mvVbzqgMhwzlC2e+rUXHCu20mnDvw5QBQc3uT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220669; c=relaxed/simple;
	bh=1vdex0HA1QFPlcXr473wT+E2Fa2Wp0XKtUyDtghY/dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smNBDAMvaQplxZeyF0ISLiI2oS1KQ56pErUoqROcKThluqjJAZoPzgLfYfwwZ4+/346MmqEXsofll+knXSFUHTUBqXLu3WhJeqazOIQEsjZ+oP9xDsNIqwpH4LMNq3gQzCGbUGNH24iuImMPmNIJ2fPTeRFzYHs1tahWS5qxNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=V2Zq0OGW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="V2Zq0OGW"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C080F3E9B3;
	Tue, 28 Jul 2026 06:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1785220665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xCHSnxc/RIaTRELKBTUzp2Q7e0pbthwUvg40SYXPLw=;
	b=V2Zq0OGWBfzpTv/jKD6XiPFc3+IQmMrDCHRlqztDPEWkRxaEZBlroi95gAgK5zXCPytwNG
	HS/ihwU0bLRbp+zJeu4cXvtMqfLo7dga4oN1Yz3BQLwwMaaekG5z8PvePriZprg6xb0kwB
	6ic1dIrSDNZ2Dp/a8Ae0/Hl2ZYahd9h+NzNdsnzYgNQn14+oT7DdLz3X7ngsXSlMteKf3w
	GVecG6eeM6JcGUNI42HfEpSlO5yhAYwVGf1mIaLSkFEZYXNwrkXOS4fxy8XO4s7gD4CFjF
	VFdz0lQ7jUrBPdq+/tm/v+ehQKNerJcuN0aRoiE/MfW6KAvua3msnzCrp4OIzA==
From: Philippe Gerum <rpm@xenomai.org>
To: Bryan Smith <bsmith@aerotech.com>
Cc: Kevin Strell <kstrell@aerotech.com>,  xenomai@lists.linux.dev
Subject: Re: Xenomai 4 Allocator Fragmentation Questions
In-Reply-To: <CABE=YNs=T-x2iyDjOMcuDzkEOx6EQCUeX7ivGy15O01cZ8682w@mail.gmail.com>
	(Bryan Smith's message of "Mon, 27 Jul 2026 17:55:13 -0400")
References: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
	<875x2gmuoo.fsf@xenomai.org>
	<CABE=YNs=T-x2iyDjOMcuDzkEOx6EQCUeX7ivGy15O01cZ8682w@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 28 Jul 2026 08:37:43 +0200
Message-ID: <87y0evvcug.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFVOnEfu3G8zJEqO03Nc+DHPYF+x8rx6Ux2UtNZF+swI2n2WFq+ie8Hr3LitLQkB+jflcMMwQjqfNBp7W/1XmUcV/5S0Ps5VyMZPaBU6f5SkDy39fjKb+eh/Jk+Rb0pO4dUag/t4EJWvRDuYYZVcuwlFdMmpMaHHALaCZNyODZ8ulJYpijg62Hm3/SpeX4bYfPDQE/zwe32Hp6rlMDV0FA/qDfnS0UF7RFYuX12EtX+k8xd3A1KIocyqBwdFG8IvSty7deQbDcMclQxgTCsxfbGjwhQJWNbLUNc2Rwl1GYF9buQB3Qe+8qLaGdFkRa008S9Sk4EIfbXXj7mu9RsJJSihubiOfWbTIihy6Bv+dwhxwYicZsQm3h+YW2VgN7fdd+9Bb1GIU+FON+7b2Ern4JJveeIjx1szfwzyFo84LiHtxcKeivjSdQLzYQS62fTWg6/LnGSseff15/iNGbAfaG2apASc3amE1k2c8WOYFs9liZzU2rQbmJUfVNzXJgG+SA3mNdIfrbWQ96mFXc3e63RD5HJJsOXhIsu88AjS7+a0uWFiVcZjCPFkG4GBvVRkEWVRWdjXNT6QLXo6rFmnSpw4xGwSyZVgPhQeCrwoymBIImnovdNLG5UWjpAtDrCFYFiaukivuorP6J3I4e+Hg1fot1FKGOxN0m6rqryK31+Tg

Bryan Smith <bsmith@aerotech.com> writes:

> Kevin Strell <kstrell@aerotech.com> writes:

> struct evl_heap heap;
> ret = evl_new_mutex(&heap.lock, "heap:%.3d", getpid())
> /* ... */
> ret = evl_init_heap_unlocked(&heap, mem, size);

Passing a NULL format should make the core pick a unique default name
for this private element, e.g. evl_new_mutex(&heap.lock, NULL);

> rpmalloc did end up meeting real-time performance requirements with
> the evaluation that we had done, but I believe that we are going to
> abandon this evaluation since the libevl serialized heap API works well
> for our use case.

Ok, good news. Thanks for the feedback.

-- 
Philippe.
