Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DC28F8
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 08:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 46A946453E8F;
	Tue, 10 Jan 2023 09:05:33 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5pPRGlQsY1TB; Tue, 10 Jan 2023 09:05:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D15356453EA8;
	Tue, 10 Jan 2023 09:05:32 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qOE8ylPcb9wA; Tue, 10 Jan 2023 09:05:32 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B4C876453E8F;
	Tue, 10 Jan 2023 09:05:32 +0100 (CET)
Date: Tue, 10 Jan 2023 09:05:32 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, aaron <aaron@sigma-star.at>, 
	xenomai <xenomai@lists.linux.dev>
Message-ID: <185592575.18229.1673337932640.JavaMail.zimbra@nod.at>
In-Reply-To: <6d0898de-f2fb-b0da-dc05-33e0dfdce1d3@siemens.com>
References: <20220330201614.31083-1-richard@nod.at> <20230109162528.26749-1-aaron@sigma-star.at> <78c09769-8f4e-a352-5d6a-4f46f326434b@siemens.com> <17333422-b80e-3442-674f-6780073a40e3@siemens.com> <6d0898de-f2fb-b0da-dc05-33e0dfdce1d3@siemens.com>
Subject: Re: [PATCH v2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
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
Thread-Topic: Alchemy: Fix rt_task_unblock() for RT_MUTEX
Thread-Index: vrPn7MJsmAUyMcLBboL24fezYloj/A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> LGTM as well, but: What about testing? Shouldn't we add a test case for
>> that, making sure we do not break it again?
>>=20
>=20
> Ack -> lib/alchemy/testsuite/, likely.

Time to exhume my test suite cleanup patches. :-D

Thanks,
//richard
