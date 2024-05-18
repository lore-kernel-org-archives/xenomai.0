Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E28EDE
	for <xenomai@lists.linux.dev>; Sat, 18 May 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716031881; cv=none; b=knA30GAH7p7DXkMXSzahicIcaEq/8DwWDbMBKreLPoYwgq9ssavEu8HTDDVSCGvjyvZXZzQdDJcO4kJxPIaqzerGah5G4w3ChG4D8TnpI4x9jW3HpxDeSBICXZfovhWbfKmif9aNfbXRYAaWn0qBUeyR1IjNqROtWG5P0cBmsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716031881; c=relaxed/simple;
	bh=01eTD78Iywu5i1cEqfr94WAGKptVDpOe+dXMoD7x/Is=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tTTBIK/zdimsFwakqWjIpolyO//eYVHNmbVFwv69X6mkvol1yUMvBGVbVKpW4VNLh/OKMzj3z8WCLLsvnOmbN8Wed+JnGKIulVyrqwCNyvwpUk1RXnFvAcOMlcxZ8MHOzt8gsjMaK5RSiN5glTKtSSOD4mgodiJahyX6Bz77bUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 14CA963D93A4;
	Sat, 18 May 2024 13:31:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7ZvIMB6gNGL7; Sat, 18 May 2024 13:31:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BD0516093341;
	Sat, 18 May 2024 13:31:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qk5Ck02DkrfK; Sat, 18 May 2024 13:31:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9C85B647A819;
	Sat, 18 May 2024 13:31:16 +0200 (CEST)
Date: Sat, 18 May 2024 13:31:16 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <969808028.118837.1716031876478.JavaMail.zimbra@nod.at>
In-Reply-To: <8a950188-ce63-42cf-96e2-ea767fee9c47@siemens.com>
References: <20240517133603.17554-1-richard@nod.at> <8a950188-ce63-42cf-96e2-ea767fee9c47@siemens.com>
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Emit architecture agnostic
 changes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: prepare-kernel.sh: Emit architecture agnostic changes
Thread-Index: Kj34pfbgeO+ka5DzC5JC56f7U5Nw4g==

----- Urspr=C3=BCngliche Mail -----
>>  if XENOMAI
>> -source "arch/@SRCARCH@/xenomai/Kconfig"
>> +source "arch/$(SRCARCH)/xenomai/Kconfig"
>=20
> That was likely there for historical reasons. Removing it makes things
> only simpler.

You mean removing the whole line or just @SRCARCH@?
=20
>>  endif
>> =20
>>  if MIGRATION
>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>> index c9aeeb4fa..25f3b4a7c 100755
>> --- a/scripts/prepare-kernel.sh
>> +++ b/scripts/prepare-kernel.sh
>> @@ -249,37 +249,24 @@ if test "x$output_patch" !=3D "x"; then
>> =20
>>  fi
>> =20
>> -# Infer the default architecture if unspecified.
>> -
>> -if test x$linux_arch =3D x; then
>> -   build_arch=3D`$xenomai_root/config/config.guess`
>> -   default_linux_arch=3D`echo $build_arch|cut -f1 -d-`
>> -fi
>> -
>>  while : ; do
>>     if test x$linux_arch =3D x; then
>> -      if test x$usedefault =3D x; then
>> -         echo -n "Target architecture [default $default_linux_arch]: "
>> -         read linux_arch
>> -      fi
>> -      if test "x$linux_arch" =3D x; then
>> -         linux_arch=3D$default_linux_arch
>> -      fi
>> +      target_linux_archs=3D(x86 arm arm64)
>=20
> Is there a particular advantage to use a bash array for that, rather
> than just a plain space-separated list?

Hmm. In this case not really. Since the architecture names will
never contain spaces nor special characters.

Thanks,
//richard
