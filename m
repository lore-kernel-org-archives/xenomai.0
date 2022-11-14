Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395318490
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 22:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D751063E5143;
	Mon, 14 Nov 2022 23:13:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fmFB4khjB9w9; Mon, 14 Nov 2022 23:13:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6AABB63E5144;
	Mon, 14 Nov 2022 23:13:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3mR4U7YnQLdR; Mon, 14 Nov 2022 23:13:46 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4DA5A63E5143;
	Mon, 14 Nov 2022 23:13:46 +0100 (CET)
Date: Mon, 14 Nov 2022 23:13:46 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1928318389.237050.1668464026185.JavaMail.zimbra@nod.at>
In-Reply-To: <ac07d7ec-415d-6571-1c71-7c2aa9917ac9@siemens.com>
References: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at> <ac07d7ec-415d-6571-1c71-7c2aa9917ac9@siemens.com>
Subject: Re: rtser_config and compat userspace
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: rtser_config and compat userspace
Thread-Index: JjpJAoe9xDtTctuR0EhKOzVz3PflFg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> There are two unmodifiable truths right now: 64-on-64 bit and 32-on-32
> bit. The 64-bit kernel must present the same ABI to a 32-bit application
> than the 32-bit kernel does. Only that will permit existing 32-bit apps
> to run over 64-bit. Data structures used for that need to be modeled
> accordingly. That may mean defining a special in-kernel compat version
> of the structure that models 32-bit layout (as expected by 32-bit
> userspace) on 64-bit kernels.

So Xenomai follows the rules of Linux and does not break ABI. :-)

Thanks,
//richard
