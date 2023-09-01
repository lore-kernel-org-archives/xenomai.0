Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D09BE4D
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:26:18 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id EAA8B613E
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:26:17 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com EAA8B613E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1693574777; bh=4ER1daXRX3jAbF4sWC/VZoUfMVvAQ0sdLT+k8fLjEUw=;
	h=Date:From:To:From;
	b=sUieNtQfj4PDNpM7NRTvRVkfORP4S8ihFnracfyjL5vLj3pCl3gfYGpzTdcEbNV9w
	 NcTpmk53wy+34sO5ybxmS7jXuOpaPizqSmlXkOTqYGH87AV6mbqCP5cEGg9sTqziOW
	 NXfB6gFjYcyG7xESY7rnUyVVUJmeFXWfUNZ7oDfE=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id E4739300053
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:26:17 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id DF73C1006A8
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:26:17 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id C9CFD1006AA
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:26:17 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com C9CFD1006AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1693574777;
	bh=4ER1daXRX3jAbF4sWC/VZoUfMVvAQ0sdLT+k8fLjEUw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=CScBwmL+bZDOMZnYQ+vtI5oqj6A7ZrtX86mbIrr1+iYxUas8NLoDdI7so6AbAGfBp
	 dFmnl3ngTRAPKU2EC4Xu6hHqtmJzUwZEqYdHpRYPB2oEcJfEHNws57ToSzIbYIhiM+
	 hM4jvLfPDRwRLJ6qS9/tvEyC9Y14CDUhVrOhDtSaj9nQ/zgqv4qYXZcO/UuomQdcMe
	 AOOEj5TwSBuv1+4e4xTkkW4O3D53Bc85Ae3ua4jk2D9kjpw+DU9uFcW8+4SNWxC8UF
	 2kAOoRE5/Bo5cJWeKULToecqifvk1QbZbA8Nj5bQbqOGFp26pwpwYuSNadmfQVYts7
	 YcnkIIFh+FFNg==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9jmieE4PRKhR for <xenomai@lists.linux.dev>;
	Fri,  1 Sep 2023 08:26:17 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id B9C961006A8
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:26:17 -0500 (CDT)
Date: Fri, 1 Sep 2023 08:26:17 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <340325180.1522934.1693574777740.JavaMail.zimbra@wolfram.com>
Subject: Status of Xenomai-images
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [46.59.13.250]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC116 (Linux)/9.0.0_GA_4478)
Thread-Index: Hdoi+24XfcBzMXDjRJK6UNYLsiFkyg==
Thread-Topic: Status of Xenomai-images

Hello list

I just tried out the xenomai-images [1] but I couldn't make the images boot=
 on my hardware. The qemu variants worked.

I used "kas-container menu" without any changes and tried a few combination=
s like

* Generic x86-64 EFI target
* Latest 3.2.x release / Head of stable/v3.2.x branch
* Latest 4.19-cip I-pipe version / Latest 5.4 I-pipe version / Latest 5.10 =
Dovetail version

The hardware I tried so far were PCs with intel core i3 or AMD Ryzen based =
architectures. I managed to get my USB stick flashed with the wic-file and =
boot into grub. But then it hung with a blinking cursor when trying to boot=
 the linux kernel.=20

Am I making some sort of silly mistake ?=20

[1] https://source.denx.de/Xenomai/xenomai-images

Per =C3=96berg=20

