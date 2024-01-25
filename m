Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81D1CAA9
	for <xenomai@lists.linux.dev>; Thu, 25 Jan 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175712; cv=none; b=fBGYQXXsdtcBM57206A6W3RppZT+G5BksbjPVHnuiKD8r6Eyaqv3h1pmq9AZQ/2BufPVwbqzuepXtTOh2f6XrKdJQ1lNZtj9MqWH9+r7+sttiiYxB3U9I1SYE79tCcktRKYYpan/sM4B67ObcepYgQxtNwNwRoGL7xVHHIkNkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175712; c=relaxed/simple;
	bh=NlhFb72o3WRWBdOYFx0gmaIan3UN/qCmhKvW54XOrsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZJ0r9rCoCZQK4GDyl3kx7ZKKyTGFzw6zR44yOtSgg6Q0lDjLK0p3dQv0ZIbeJsOwttaJCiJyMWuPtJ7oYjNMcKabEgBV4XpW2YqNhcdMxeYbJ7vFI+tIrxld22Fr2PD8Az8zjMA/RbNgNYr5Yelb5CwS4j/UilziCwRWii6I+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=I34RaFl0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="I34RaFl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706175708; x=1706780508; i=jan.kiszka@web.de;
	bh=NlhFb72o3WRWBdOYFx0gmaIan3UN/qCmhKvW54XOrsU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=I34RaFl0sxzcQzt2YMPMwWfxM1hw9RtymszvHpgSTfThVM8xnoEsLB5NjVEnYSG6
	 RkzFxrt+B+FAMsLfz1FlaouZukHztvoMuDWw1yc25bnVWb9QhXzFBez2ysueLQCtz
	 xFoNndTo1FeNhRF4ihmJeB79ArVp59ffNnMTISF80TvJMMs2msSuTA2bxGRi3/7Uq
	 5welkqfReFxukKf38XgKU/DCXWFGP+jv2dYSspdlIravCpf8esvKju8XcN57OEjLO
	 AhwzgY4cuBT2lJ/Ok7MI5kosgTG3ao1nhWvaEuL3NVUStModWwPwo/nORKFcAYQbM
	 aNwsS4HK7HR5eftGVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.89.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1qg7693y7e-00nQVp; Thu, 25
 Jan 2024 10:41:48 +0100
Message-ID: <d3fe414e-b82a-47c3-89c9-0b5ae1a4fc78@web.de>
Date: Thu, 25 Jan 2024 10:41:46 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Troubleshooting x86_64 evl bootup
Content-Language: en-US
To: ivan@rtxi.org
Cc: xenomai@lists.linux.dev
References: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
 <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
 <e70b0272-8c4a-479e-b7f9-2dbfc6771389@siemens.com>
 <ce6d6d1504bb7d589daa14d03fd81d76@rtxi.org>
 <4e81f900746c1d6580e4d2711782cd25@rtxi.org>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
In-Reply-To: <4e81f900746c1d6580e4d2711782cd25@rtxi.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pLLicU+XjVujxPysO6/6/0ip1V4X+mFpUbJ2ouq+mNhHS41I/en
 zbaAKO6xczcxLXpiP+I03FQsICsc4dhdINNthapt+l70VRnL/Ise3u4h/kJT9beH0GW9ezv
 gIV987FdykrAuq4S0ZrrNw/ZSQwOmNJf1nPwkpNyLv933c+3Gef6UsKNMLcvVFiu0KVYr4x
 swQ0D7UnPXiQplSsO2p8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ef+tGNd0G0o=;znBS72nUZXHtK1b8kpt+RYf/ZxX
 bx0TovvkSltibNss298uo0TnqIjlCYi92sOInak5Jke5GrhbSO9AsrSPhv7lk/192kLZa7rGV
 H0Vngc4Y7rGu5GhemehESYcGICZ/g029prC5Ce9iUP8AT/toCMl6mWM2LMVvsCk+bSfV/iMmH
 AWiohYZgZ0kERmeBygx6eA44Nyn9vV7NJPGD2rPVeRpWpbB+7jb0BJPnt0aar+x27YNH7XEU7
 D3YeTg+US2E/3BPqwoBYV3rJPGdTw0QwHb+AAhD3km02LsK8hCDOC2tUYixgV+uBrGU2rGizX
 UNV5KYPkVhKn6qgeZjYM7O6vSkWsflOhZkLw/BIhNEtk1J1QWdLDv8SxL45Rj+rDMiykfDJX5
 u4eUz3/172CNDID28oOg99/gKW3bEOgFluNqYmYYT+S2zdbxy56nf+mImjYAHpG7VSfnpDfwA
 m7qsUHym38wrqh+4UIQTpp44XY9s9d9bjppQge9jNEMxGHhyuZlXPzojPMQ+/09lMSzTiOqYT
 1v5enz5VIEEGxwwq9dwwC0aAtyOGNkYoc7z5Udg7uVqvVpEARVQY+BNwVg7I77+Nw0ph71TOy
 EOVz51iHxkqKpQu8g2r+an3iKIy+29XqAzOeVn2nymK6o+40ap0tMJHBJlapC426TqPowXP04
 dh31AvwkyHKb2WwAABYqMQd3TzuBY8/sn7zcML0fGeVlkmG4Vc/X8vNvwSg5XtO1pIkz10LLC
 WN2rcNcVhCytOgAVZaKK/8/53rPApRysh7gmHCczUCqqbyswBcW3EG661C3AuZSPAVFY1eHAF
 vDDFnLU5Pc6YvEmTD2Hd3/3b7UOWbdgijrxThCM3WL/VRBcZdbZRr0Jk6ex3yg9MFH/5rLX4j
 Klfg3ts77o6c+PKFmoy4lWS5tTUQFJfLxPENZpx7+xOLuCzjclIwulZ/QTWOJA7PtRymUvsRY
 hFuimg==

On 22.01.24 20:40, ivan@rtxi.org wrote:
> Hello,
>
> I used the config from xenomai-images suggested with EVL enabled and
> that reached the login screen! It is obvious from this that some
> configuration or module is the problem, but I don't know what it could b=
e.
>
> What should I do next? The only thing I can think of is slowly start
> enabling any drivers I need until I hit a problem, but that seems like a
> crude way to find the problem. Any suggestions?
>

Finding the needed configs switches to make something work can be
tedious work. You need to diff the configs, first focus on "suspicious"
switches and throw them on one of the configs to see if they
resolve/create the issue. If there is no obvious switch, copy in have of
the remaining delta, bisecting to the triggering switch. Note that there
might be multiple switches needed in case of dependencies of multiple
features missing.

Jan

