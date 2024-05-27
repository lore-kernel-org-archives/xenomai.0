Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331917E91C
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824550; cv=none; b=Fdc0r30E1r1U6hofexwERz+qPSZPtTEYlC0acRN9AnQE17OpZV6GsukQ+OpARSdCmS1Qmpovu4xzQx0cugHrpRQJNxrOg4wQiaDzgMoyuxNTqILk1vVvQUU6wMtsQQIfhh3cYYP08lQYu9HC4vXGUx0qC8JX0J2aiyrBfljnKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824550; c=relaxed/simple;
	bh=28FmaNaCjE0elO/iRTMp0OiBVo0Hx4KNcyRan4yjbDI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XwT0VTJ1pqBsi6Esen3GI8rUUP81dqcYBO/yBFkUSoOnmlukEbSDPG1zzxNT/ftuDqv4OdzGrHvXI6Cbt76yP0OwtD7dTbQpLfmzzkX5XRIa9yUs38Rl3t/2C0tbofAbhxJ6CCv5sH/N5B2qHWLSG2oePc8vT65d2AFg0iybmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 02FC06195FF9;
	Mon, 27 May 2024 17:42:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LlCAy6Iho8sa; Mon, 27 May 2024 17:42:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4187B647A806;
	Mon, 27 May 2024 17:42:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 561CBRCjFhmw; Mon, 27 May 2024 17:42:18 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 230316195FF9;
	Mon, 27 May 2024 17:42:18 +0200 (CEST)
Date: Mon, 27 May 2024 17:42:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, upstream+xenomai@sigma-star.at
Message-ID: <591173911.154468.1716824538053.JavaMail.zimbra@nod.at>
In-Reply-To: <25810d15-a929-496f-b3c1-6ca60caf0242@siemens.com>
References: <20240525115806.12101-1-richard@nod.at> <20240525115806.12101-5-richard@nod.at> <25810d15-a929-496f-b3c1-6ca60caf0242@siemens.com>
Subject: Re: [PATCH 04/16] prepare-kernel.sh: Improve kernel tree check
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: prepare-kernel.sh: Improve kernel tree check
Thread-Index: t2Jbonc4CTlfMQ4LlSqWGPUX4gpCcA==

----- Urspr=C3=BCngliche Mail -----
>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>> index 534531e2b..800528058 100755
>> --- a/scripts/prepare-kernel.sh
>> +++ b/scripts/prepare-kernel.sh
>> @@ -237,7 +237,7 @@ done
>> =20
>>  linux_tree=3D`cd $linux_tree && pwd`
>> =20
>> -if test \! -r $linux_tree/Makefile; then
>> +if test \! -r $linux_tree/kernel/kallsyms.c; then
>=20
> Fine with checking for a real kernel, but this here is not my favorite
> method. How about
>=20
> test "$(head -1 README)" =3D "Linux kernel"
>=20
> instead?

My idea was that kernel/kallsyms.c is an old file which is unlikely to
get renamed soon.

It came via:
commit e42f617ecdfc68e68b0108cd337d30224b541352
Author: Ingo Molnar <mingo@elte.hu>
Date:   Thu Sep 26 03:31:07 2002 -0700

    [PATCH] kksymoops-2.5.38-C9
   =20
    Make the kernel print out symbolic bactraces if symbol table informatio=
n
    is available (CONFIG_KALLSYMS)

and was never renamed since.

README, one other hand, saw more changes.
In it's current form it looks more stable, though.

So, I don't have a strong opinion on this.

Thanks,
//richard
