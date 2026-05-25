Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDB3F54A0
	for <xenomai@lists.linux.dev>; Mon, 25 May 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727904; cv=none; b=P29JlZxMzPcQBu5i3MM4N9wqwsxNkCgBDdwVDoeB+FZmDvik2cKlVwMfOWxhkLAdLh3qw0D9USPqQBMWF5GsVUWwFhqVk8voGLVX8S7q0I9vDmdjuwuP93+SVjAv+5iIxWrU///7FAfzgC9A6z0ksc7fxVz1M9XWnFACoENz9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727904; c=relaxed/simple;
	bh=zmqJq6SsLhjOzKbnWDF3HILFmZBveGsYSM1ia6iD1iM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJpk61PMug1GoD4ThM0ONR8bTLjqFfe/ZCHV3mdwrUh/W37e1XcYCMnkYhBYC/RhnvKJ5ckkU1E9CG+N1KI4IxFGHIu2zz+JW00YA/VhKRTp7JWmzs4Cto2vIRG7EIvDy4OGVwtrhdrykxSOHEIWEAckjLzb0F9+eHumMwE5n9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VufmYowb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VufmYowb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E86C63ED65;
	Mon, 25 May 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779727895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKLfQ8zUjloD/yPjWIWfbYn/CypYo8U+R52pD37oec=;
	b=VufmYowbA4AjITvhJvLvEwisgSSyqDra7lbDmWKfwyupDdGz9BUTDLjVeI9ugh48Kqiitf
	MLB8RW10EGV4gqXnOD5uyiBWSEDdWtXMN0yVK96VSwiivvCcrKOhKr4+NULLEFLxiBKSmO
	0qslqU9GHi5gGaMwKMz1sNV7ykw1zmasN9gi/kfjGaciL8w9XbGAGSdJ2ZNKNdEw3oN35k
	0M56nXXS4fXu6Vl8Xj5VeDF5NIy36xOs2FNMjIU+f7nVOJ5XmBz5PCIHsqOVehLYTi4kEH
	LNRsiEdX5hYCbbHkSgDCX9O1hvWemJl3DnsJ8z88Bj0GJbOg22yzF6M0EvRuwg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] tidbits: net-udp: add server and client mode
In-Reply-To: <20260523201044.12938-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Sat, 23 May 2026 22:10:16 +0200")
References: <20260523201044.12938-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 25 May 2026 18:51:34 +0200
Message-ID: <87cxyjph49.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGJ8j07gcPTo1H6+0pWYQHFk1G5jJbYuLRevKjWQ9suG6Ul+mT/d/ozb/6z3zYnhET/unHEMdauF8AheuwXReapZehILLZh7rjd9CEphODUjdT4+SkmZMn9yNrKdQSeY9Mic45R354T6tAWf0R1NttZkVta8i+VnlJcjEWOodB7g7TS+jvgwa7qZdtGpoEDqFrdpG7CLMaYFj5qb5BNjuDxEIqOq2Pv2OUCghimcC4gNzkVWq7VqUgnfCVZPuLphPoTpoRpUT9mSEg684odc4aqAQ666HoXZdojwvo9+j5cP7oc5HkukPmDzsg90iMkSu9K/ZhYdh20/HwYgQfltYQHBAatgmmrXDWnnLXjq1Nbjpq7owjNZYIgG/OwioghFsWCTXdPW3/FF6g5+QBdsqMm23FnvPdxadMvb4dA+Zc0qAy1odr5Z9mv1UvIX53Ro6OdyeaZ5Wg6+SsDzPIWWtktV065wZ6Lq1PR0zPzPu1yhFZiiSw0BtOWzAUXNCOmj5TH4xoIqfGBj37PmPLicyGgHkuu23/7A4TiMmlZVPIbeKcng8seBCxYn2NcgSE7dt3KiPJ9ID/7DVw0AbQo1qxo7mneWzr87M05H9G7vLCiRbIBNCeuazxO+H6X3N0nAVpct0KB/ie+l53fSTdy8+M8rYfdtO5G9qJFFzrTICfNjQ
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Additionally, fix memory leaks
>
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 240 insertions(+), 18 deletions(-)
>

Merged, thanks. Would you mind sending a patch to update the related doc
on the website at [1], regarding the new -S mode? The pages can be
downloaded from [2].

[1] https://v4.xenomai.org/core/net/udp-demo/index.html
[2] https://gitlab.com/Xenomai/xenomai4/website.git

-- 
Philippe.
