Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A053F99EB
	for <xenomai@lists.linux.dev>; Wed, 25 Mar 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450697; cv=none; b=Z81oetLgQxfuGzw/DolIUZI0HdfIJJH/1F4yOlkgTxMguw4tILepifCqEiAPkjVVijZ6Qv0mOqUDg+JACykcCpJkRM3ZAMmNzx14hf1uj/GXfzv0ONAiWQV8YC0YqJljpLDKxzySrUHABhavrzBaWSzwnmp+0qJ4RBgLzTEB5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450697; c=relaxed/simple;
	bh=h8Knig4wMVfq01epsBHlqkk4iPSLtMPw7m1k8gYURjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mtf3wS4QYxgzaH84Jpoc344EVUnxB1wDUCWwKoa0rD66k+dk7SUyDKmT4PC0dhzDOfKc0ZcqZgABlJobcQ2KeZ7MrEuDqpPmZD/mpZpD+3VWhxYTT3ULprImy1WWIv6aiLj7KoSWgoAkobU2Ct5pgH7FbbVBHO9Sir4+NbIw7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=natzht5/; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="natzht5/"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 709E458027C
	for <xenomai@lists.linux.dev>; Wed, 25 Mar 2026 14:51:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8C1B3ED1E;
	Wed, 25 Mar 2026 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774450310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CnrSlzYjq7oAuG6cA1A6BsPTwzPU+s9+kNeFMuQNSYw=;
	b=natzht5/KltEAXdZSs9gqPcV3F3+S5DwG3bxMraEpOcTgdZSKTogHl1vEOp7gt9b1ELqSb
	caH2UFP7/KBh0uU+n5kaIe0reUMKWz6uLrzbyy2QpOE1su5DTCNvxRyMIY8un6D6PPJUJd
	N4NnCq0z/a/pnbOH2FpYfFw0d7LvXFNKLrSmRvhBao1PLCSZ0QJBn/fkDjmsUorYMp+5Nn
	ZB5U1D0nSoOZfcIxYRZZWtd9JHvmEctLgAZwQNZZIKRqHffjFV2ovjGM2boM6Ys5WExo94
	SycXmt744kbaO+gP2Q9aKKbiwDzFQkQNBQUeNr4OYfIZGbwPXIUc9AWnzPSYcA==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail] net: skbuff: add missing OOB stubs for
 !CONFIG_NET_OOB
In-Reply-To: <20260320211911.2151219-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 20 Mar 2026 22:19:11 +0100")
References: <20260320211911.2151219-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Mar 2026 15:51:46 +0100
Message-ID: <877br0j725.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfekveduueefgfffudfgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> skbuff.c calls skb_mark_oob() and variants behind runtime running_oob()
> checks but these are only implemented in the CONFIG_NET_OOB section.
>
> Add the missing stubs to the !CONFIG_NET_OOB section.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/linux/skbuff.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 73dd4a58d181..1278d0a58677 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5630,6 +5630,22 @@ static inline struct sk_buff *get_oob_skb(void)
>  	return __get_oob_skb();
>  }
>  
> +static inline void skb_mark_oob(struct sk_buff *skb)
> +{
> +}
> +
> +static inline void skb_mark_oob_released(struct sk_buff *skb)
> +{
> +}
> +
> +static inline void skb_mark_oob_timestamped(struct sk_buff *skb)
> +{
> +}
> +
> +static inline void skb_mark_oob_managed(struct sk_buff *skb)
> +{
> +}
> +
>  #endif	/* !CONFIG_NET_OOB */
>  
>  #endif	/* __KERNEL__ */

All current users of skb_oob_mark_*() calls are currently guarded by
CONFIG_NET_OOB sections, or enable CONFIG_NET_OOB, like the evl
core. Did you observe a build failure with CONFIG_NET_OOB=n, or is it
preventive fixup?

-- 
Philippe.
