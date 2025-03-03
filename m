Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA96210F6A
	for <xenomai@lists.linux.dev>; Mon,  3 Mar 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011105; cv=none; b=psqiidsRaysS6adm53hKmzXf7fv7gaj+erkHDE6uDXe6P1fPxlYLR7Ic3FDuUqQziQgKjSm5iRoBLd6TA51QVdh4L93muYHhzaT7/0l1V4AnG1o0LF59t9GzGXWpt+stBexV5RZDaq3KdFitU+eJfv5WtYL8dxxHb4/ocW9gjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011105; c=relaxed/simple;
	bh=Anzc8RxlqTG1K/9quBCGyJdM6XHuTzLQNPSM25noiHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdx1b7fY45duOpDlaWQ0QxIWdtUtW79mH1EZdHhAbvFqpQ5ftzBhkN9zFqMHgE38iQsECIsc6IdfyXRiQ75CztrOHHzKfAGIoxc3FYhqoeTJwDoCJ+C9KRmoxPft7nvPLIKQAZBI43zOINSmPeaAsh+mf5DlXDMLqJfMfMflIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=dl537tJk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="dl537tJk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2862440F6;
	Mon,  3 Mar 2025 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1741011101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PdPcp9QcFRKaoFNNPOky49kGOHAnGYpKD369D1dKF1M=;
	b=dl537tJkkgEmk0uFa4GjVdbZ0Id2OpEiB79ajK+tGo0CvVMauIYwQ9lrOoOZ9N2n1ivEcg
	e6Q9/mYL3P9KY7awDORwXMPUyA4zGFLewLlL96SDGYX+02MmyQHEvqIofWRPclKRdoJA5T
	u0BeKh9qc1XK2E9Mj0FpwzUgylccC8Nk05xQeUwgQIAihjguQKzCwpOB62+EjwBztwdxCp
	q6qK7oWnfy7pOazX/7PHYwRtpI66mCzaSeanucjHvXBO7HJlvvK2ZzA+a5YFfTl2xJ6z9O
	RYsWkkjjC6j5PfKYTn7kWpWRf3SWUHJbKt9x/BB1Zk8Mv9DpC2YJofyBjPBJNw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: [Dovetail] v6.14: fix up to oob page pool
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Mar 2025 15:11:40 +0100
Message-ID: <87ldtm2ogz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhephfegudfhteetheetudefieetvdefieffhfetfeefudegkeehteegveduudeuvdefnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org


Hi Florian,

For some reason, the hunk below disappeared from the Dovetail v6.13 code
when rebasing on v6.14-rc, this causes a crash at boot when
CONFIG_PAGE_POOL_OOB is turned on. This fix up should be merged to:

e4ecbcc40e7e6 net: dovetail: add infrastructure for oob device I/O

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7860c3a88c5d2..07ad13dd5ed2e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -563,7 +563,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 		return pool->alloc.cache[--pool->alloc.count];
 
 	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
-	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
+	memset(pool->alloc.cache, 0, sizeof(void *) * bulk);
 
 	nr_pages = alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
 					 (struct page **)pool->alloc.cache);

-- 
Philippe.
