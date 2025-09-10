Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9641494CC
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510432; cv=none; b=eM6sz8CEgsY+cB0tOQg16Krjalj9FNeTMoUfp8obqjMRKjLqTTHNqYKFgTB9rAhG1wPpOr3+ztoYIzUM+nEuwvRWOMf53ChcT0Ndpin3hnDVDi9/2lhSIEKSMwKmDU2Wddwpoi1C3rymROitqrc9zdyv1wa9ftCcvcZV564UxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510432; c=relaxed/simple;
	bh=NRwh7OgYBmSA/iqJGVcAYEIkHb7uiOiZH3U+qimNmNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=adh0z5il9Qm7BO1qH3BLiXdEycV/FZkurWkO7N+ZXT1wZA6Nk6UR2WmjrcdEaj8f3D68d+VSrsl5Le8MK/Hx7jbJH9cfbHG5LVCC//bbsGQKcQgoID8jl2cM3giBUd1ZVGxFblEvis2kOzygptlnV9hbgKaZl5XnMlj07dOCyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=hIdRY5It; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="hIdRY5It"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69D3244124;
	Wed, 10 Sep 2025 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757510422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8swxVKsaKW23vI1no3sxjBUqek0BCnJg6cPw6yAb6s=;
	b=hIdRY5ItwMUhFeetgwsKDx2dq9ObVxcF1Kt+Oou4SaiaNAil8NWnHkmuhTVvRpKeuD+RrV
	oorNFZFDhsfsdfIKsYmDLDillp2eueIBo8hgEsmErApPLDd8SAdcyY5XfwYFVh6BMFE3RY
	Oy7IqXtlckHL3xZs4Srs3oq958Wab5lGJFR0ULQSePvf8dA1sd9+BdOGQh+useTKVIACPN
	/iD5yT/e4cxPQGzWZiY4U43hnhnHwjJrjoQvnuOtaTnfH3qK4M+/BX7zPhbvMS6JaztQKO
	YpT6LA48eNsQKGgRb+9Jvzr7vnoIwiw4P+4HZyvTHr9GCvtra+k3r1S0X+ITmQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  "Schaffner, Tobias (T CED SES-DE)"
 <tobias.schaffner@siemens.com>
Subject: Re: [PATCH libevl] utils: net: Add missing initialization of
 query_type
In-Reply-To: <505fd322-a1c6-44f3-b31b-0be7c7bbb108@siemens.com> (Jan Kiszka's
	message of "Wed, 10 Sep 2025 15:03:43 +0200")
References: <0b07213a-d4d6-415a-9179-b9a632a78aac@siemens.com>
	<87plbyxy08.fsf@xenomai.org>
	<505fd322-a1c6-44f3-b31b-0be7c7bbb108@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 10 Sep 2025 15:20:21 +0200
Message-ID: <87jz26xx4a.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 10.09.25 15:01, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Fixes
>>>
>>> In function =E2=80=98query_oob_port=E2=80=99,
>>>     inlined from =E2=80=98main=E2=80=99 at ../utils/evl-net.c:483:3:
>>> ../utils/evl-net.c:157:24: error: =E2=80=98query_type=E2=80=99 may be u=
sed uninitialized [-Werror=3Dmaybe-uninitialized]
>>>   157 |         if (!which || !*which) {
>>>       |                        ^~~~~~
>>> ../utils/evl-net.c: In function =E2=80=98main=E2=80=99:
>>> ../utils/evl-net.c:371:18: note: =E2=80=98query_type=E2=80=99 was decla=
red here
>>>   371 |                 *query_type, *vlan_list =3D NULL;
>>>       |                  ^~~~~~~~~~
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> We are missing CI for Xenomai 4 to catch such simple issues. Tobias=20
>>> suggested to add at least a build pipeline to xenomai-images, until we=
=20
>>> finally have automated on-device tests. Looking into that, also to keep=
=20
>>> xenomai-images itself up-to-date with evl (we had recipe issues on top).
>>>
>>>  utils/evl-net.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/utils/evl-net.c b/utils/evl-net.c
>>> index b45fa60..b1d06a1 100644
>>> --- a/utils/evl-net.c
>>> +++ b/utils/evl-net.c
>>> @@ -368,7 +368,7 @@ static void bad_usage(const char *arg0)
>>>  int main(int argc, char *argv[])
>>>  {
>>>  	const char *netif =3D NULL, *modpath =3D NULL, *ipaddr =3D NULL,
>>> -		*query_type, *vlan_list =3D NULL;
>>> +		*query_type =3D NULL, *vlan_list =3D NULL;
>>>  	bool set_filter =3D false, solicit =3D false, permanent =3D false,
>>>  		enable =3D false, disable =3D false, query =3D false,
>>>  		allow_routing =3D false, set_vlans =3D false,
>>=20
>> Merged, thanks.
>>=20
>
> That was quick.
>
> But be warned: your master !=3D next now, commit-wise, not code-wise.
>

That's fine.

--=20
Philippe.
