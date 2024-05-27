Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D0169AFB
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825660; cv=none; b=aD9ymWCbof6d38GC/MgpvrzdkPbz3GeZ2KoU/bjBzAnJw9xFoEVyXtd1X0T2/8cSh9VxnpuHIyGxudQxpK4opW1zAa5ciVwF3TI2z2MYb8pbSVMMe5Ze0ErlkTMG293shm3YP1lcrCMVjbELwGCDwIqh3l2p4ktUyDFiNN4wlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825660; c=relaxed/simple;
	bh=gobkQhbFgJzdGqZJUQshRU2vbWqLrZkFCdkccIYz4jY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WZUCtzOUJuL95CLtuI6WKAop2WzJZS5srrtEmU7vm0Z2L4qwfANH/77pkzRZmpc398zvct+HQbOekSmaXclYhXfddC1IBNoTpvSytKvOPwnmGN7gY/TarP7alllLZSnsEwl9qlS33qQk1Vo/a2f5lCCHZwHPtEc0J7hfANLFdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 240446196364;
	Mon, 27 May 2024 18:00:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T9KMMc56Su0h; Mon, 27 May 2024 18:00:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B9E3B6196363;
	Mon, 27 May 2024 18:00:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id USYAI6GRxVZk; Mon, 27 May 2024 18:00:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 986FF6196361;
	Mon, 27 May 2024 18:00:55 +0200 (CEST)
Date: Mon, 27 May 2024 18:00:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, 
	upstream+xenomai <upstream+xenomai@sigma-star.at>
Message-ID: <73647592.154519.1716825655479.JavaMail.zimbra@nod.at>
In-Reply-To: <fdfbe0c8-42c9-440b-bd16-0834cad46645@siemens.com>
References: <20240525115806.12101-1-richard@nod.at> <20240525115806.12101-9-richard@nod.at> <fdfbe0c8-42c9-440b-bd16-0834cad46645@siemens.com>
Subject: Re: [PATCH 08/16] prepare-kernel.sh: Don't depend on bash
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: prepare-kernel.sh: Don't depend on bash
Thread-Index: UF4bIepUnWYRM3fMAOJy6gxV2BW4xA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>> index 3c13d471f..f7aca804f 100755
>> --- a/scripts/prepare-kernel.sh
>> +++ b/scripts/prepare-kernel.sh
>> @@ -1,4 +1,4 @@
>> -#! /bin/bash
>> +#!/bin/sh
>>  set -e
>> =20
>>  unset CDPATH
>> @@ -210,7 +210,7 @@ done
>>  # Infere the location of the Xenomai source tree from
>>  # the path of the current script.
>> =20
>> -script_path=3D`type -p $0`
>> +script_path=3D`realpath $0`
>>  xenomai_root=3D`dirname $script_path`/..
>>  xenomai_root=3D`cd $xenomai_root && pwd`
>> =20
>> @@ -220,6 +220,7 @@ default_linux_tree=3D/lib/modules/`uname -r`/source
>> =20
>>  while test x$linux_tree =3D x; do
>>  =09if test x$usedefault =3D x; then
>> +=09=09# shellcheck disable=3DSC3037
>>  =09=09echo -n "Linux tree [default $default_linux_tree]: "
>=20
> Better use printf instead.

Good point.
If you agree with "[PATCH 10/16] prepare-kernel.sh: Remove interactivity", =
we can drop this anyway.

Thanks,
//richard
