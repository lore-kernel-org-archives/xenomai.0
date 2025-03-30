Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BE1E0DD9
	for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354240; cv=none; b=RT9qFcvp7encBKFTT9kUgmWLub0FFM1TIkO97dSUfqZQA4jH+egh2IdoIhnPzlgPp2MWybGBcffhGyCftUnQ4tdsPWf3a/GQLQ+1/zJs8RfjajjIFB7ztVtJhqEjm3UehP/Bc4LK+bSxnb9GYUYFzJ+L6TeuhQ1TtEbtOIBN7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354240; c=relaxed/simple;
	bh=YWxMKGXzqNFzTDqVCuGX47G7ZTRJyiFYMVaEaZtoQKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEmrPGo4q7FFLykmz/OzCWoUBMFrT2aCUAK45g/AuloipPR48iAcx6S93KAFrtTEPS7bKrTbQlio/Y4/Ho7KTga6GoyVXUPLtFJyp3eYI4jgtXX6V3lLyeNJA/WNRQv1yjDATUGrYEyi9lSQc0KQTl9kCD1cWRJkT4MtzAB7Q14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=f5lLFidn; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="f5lLFidn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743354235; x=1743959035; i=jan.kiszka@web.de;
	bh=RokA+iixcLBb5RSeZKb3AQKiikgBnTdbWUYpJTLkhd8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f5lLFidnDYQeiZNQnWDEHpqVXErf87KOSWYxE2HGWY9g3qL06mVmbNUVj8BV9RCH
	 GGl2Le1XInx8qaR8hhehIgPyOpSGNb285Uy22xE9kjblJujLDaAHdRvD6eqP0I0oG
	 t9HvRnm3FXJDOAbDJa3iu8NobJcFzEq+zd+Ng2neW4mk9MVBMp0glf0sga7HH6v+o
	 4F7EuDrKUQu/f5rh5LQzG5YMzoI0qrLpl+b49dPKBEa2zLz/aNDBWAPUBAo3xJeql
	 vM+izeeO4BgTuvjYXBwM17l9Aob4rmMpA3a32zzYN6DP/29z/6b7FuKuBKqVijGJU
	 6Rb2GKVcnwjWgUivyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.11.10] ([95.157.49.24]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1tspKi45kY-000yVc; Sun, 30
 Mar 2025 18:58:51 +0200
Message-ID: <d24db917-b4c0-415d-a008-ad4404491d22@web.de>
Date: Sun, 30 Mar 2025 18:58:49 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Building SDK in xenomai-images
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0scz6GaCTgaoXFzq_KEtNw-GAeJNbQnMR5qeSw2Y0fOHg@mail.gmail.com>
 <5bbb0060-6d26-4b3a-9022-fea5b73c1a26@web.de>
 <CAFc1U0sZrzQy9Rf4VJYJtOVE4P5h0GN7peSbQ56nXkipmbPnCw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <CAFc1U0sZrzQy9Rf4VJYJtOVE4P5h0GN7peSbQ56nXkipmbPnCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CrqFg3ToQkg2P66iNVqLmrojuKZvsAB0xFVVFks7S3GmfzgHlhs
 4Us3J7TVGjKQdndmKLUb9P1nxMOrrx9Iy2qQjQS9rtmM3bl4Cf9dSQrCiSrRt/TJ/wwzOJD
 wUC724caNhxCMyvyx164mfnLquzBTTnJ5hCIggpj6jKxpQasxMA1V6CUBavkaImOsUF9bbv
 hHZCgL6qPhwydXZMqHNzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SoplChrJ+Cg=;+H+83ZO/o/3CUEj5XzWRf7f4EIY
 wqx/cb3ECUcyPTZH0ZqdryeON9Yg0ZIdhIKyDrh+dsRMjxecWP9lkBN2fBCOdiKTVi9vfS0sT
 Xfdn7MRoIrtvogzLPVQl5pSvqXrINGjEb153fcH4zL9RFYh1rAn2+WwyIQ4wHVVfG1bqW7kgV
 NKCtMqARsFQxODOe6keLkLzw4WjZ5s8csl1VUYt5rS7BH/xj7yTNQzeIh10jm7MHtyO3fQbWE
 ZNt47lLG8Hz1IjqfcnTf5N1ppe7fs8v6Rsypw7MN38laG+adXPeV5FAQLuuPVFOufll2wF4D8
 C3rSDTPytlWyOtcaPRWesSdYGzP6gm+MT2QFVtin+HggAFoRAebUJlgQOMZu7KWNBf0ON9BoF
 egEB5Ify8+wWVgbtoguxfJgL+1xZ6xs9a8or0JSUmmc1ynaZLrPQ/ABeEAtdMspc2n1SZKyRI
 +TI0u3fKSy3qxRF+/y+Dj9i6+/wUGGYPgTLxqwO1+GQktTw7Dli7fCgOI5KDnr5tVh+wAMoFg
 887boWmGK+lEJnGzPXr8Sg/Yhp/wXMiZA/ChCA4ORwEUAs5PMzY0O3faJVGuBS5ker+cOSdLC
 repBCh5wZWkWZLKBqTxYoMIDyYUvdYwwsBSjf3azc9u6hnWfJxg2ugqdhYy5WD9vUGHkPcjWC
 dZAU0iQzgNotyRJgQ5OMgYgbWB06VXdW94MKh2C7AnyN/HfHCcmuMVDbfgHrTfFF3tZ8AxyWg
 qKcIIn/qykTEqSt4EFmW1DhoWYx0c2i5EuucF+7leVCL/yJC/f4VBBdwv1kYPQ2nEknst+7yR
 PtNeCPufPv16Ww5SzAnOHnAfmWthgzXpGuWXtbN87IioJUQ0WOr5PMpPtwydyHmXiSXnQt7Jb
 d1DeA3PEK9cwKcefBF9lpkWLVyUzVWXpip4JrejlzAYNUbo6cFBB/+rRdprtUHCqyo3ayqwWa
 iFfIoPlTd7vBayp8Wh/JI+ZtNeyXVjCBTIc8EkZzyEZtsHmNf4W4JJ3YCWjW4uSIMrlfHLcV8
 QWXxN6xCk1vWvQ2BBlDBQItL53J+M+fU8IMwGjT0f4tlt77hojX7lvGU+WVm09Bfpl9udMJ33
 2MmqdYfMDtDXzJAFr6sVPmTJgNYiTisE6ZsZ36G3Ig7fL9VJFeQJKHxdAWBBffrWIySqbgE1u
 93Z2aQ5lcRiIIQx/Vh2Wcj7i5GrFcVjq8MY9A50yZ3oZ9cZ1sOzqUBz86V/xOjeoIiCSfL8UB
 rSSY3kIdexsDmP3dnAzmTMcd5w6JmgtzpOgkCDbj2qcBAgdLPwHLX7CptZjpd13UmQ0fqR+V1
 OK4tcyR4Fxvj0wTJ8vDmMoE9TelDEB9agNuX9zyMJKMKWeAQMkSQkjXvk5mG5+MDxF3/iR0wJ
 E5LMbbHwa/oBukiaQBl1cQZx5o4vKLoMhSS2bIZK75wOBQ/BYlfB++7ONkrL6a0kidbspB29Q
 9nzgydx1DNorxFRa48Tth9lj4KMw=

On 30.03.25 13:25, Pierre FICHEUX wrote:
> OK I will do it, thx.
>
> So after applying the patch I can do "bitbake -c populate_sdk demo-image=
" ?
>

You could have done that before. However, isar cannot automatically
retrieve the devel packages you may need in the SDK, and so some key
packages were missing there so far.

Let us know if the generated SDK worked, then we can merge this change
officially, maybe even document the feature.

Ja

> Le dim. 30 mars 2025 =C3=A0 10:17, Jan Kiszka <jan.kiszka@web.de> a =C3=
=A9crit :
>>
>> On 30.03.25 09:20, Pierre FICHEUX wrote:
>>> Hi,
>>>
>>> Is there a way to build a SDK for the target selected in
>>> xenomai-images? Such as the following command in Yocto :
>>>
>>> $ bitbake -c populate_sdk <image-recipe>
>>>
>>
>> Not tested yet, but something like this will likely be needed:
>>
>> diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.c=
onf
>> index d1b24b7..a113a54 100644
>> --- a/conf/distro/xenomai-demo.conf
>> +++ b/conf/distro/xenomai-demo.conf
>> @@ -23,6 +23,9 @@ PREFERRED_VERSION_libevl ?=3D "4%"
>>
>>  KERNEL_NAME =3D "xenomai-${XENOMAI_MAJOR_VERSION}"
>>
>> +SDK_INSTALL +=3D "linux-headers-${KERNEL_NAME}"
>> +SDK_INSTALL +=3D "${@'libevl' if d.getVar('XENOMAI_MAJOR_VERSION') =3D=
=3D '4' else 'libxenomai-dev'}"
>> +
>>  WKS_FILE =3D "${MACHINE}.wks"
>>
>>  USERS +=3D "root"
>>
>>
>> Jan
>
>
>

