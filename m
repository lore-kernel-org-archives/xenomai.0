Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70B1BF27
	for <xenomai@lists.linux.dev>; Thu, 25 Jan 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176232; cv=none; b=tsjdhobGzEpeOgnkRkTN1U+6TXJfBXAN0jkWftuZhDBr2AKsVxkA7MhQcdIhn9YIgYe71ETJf8jWRnc1QpbIyaCpmP6mxsdJZfDWxCnr8f1HYTNyxS0b1QRDIx3aAUuRFw38/XP2pYERgm/eiNXJzbJ2RksZ3XP17JQlQmxg8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176232; c=relaxed/simple;
	bh=B3NNa6ec29KOR8V2U2kFSn20WbuoDKc9eMv5pwRi/1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcs3HTw/MYG3dMyggDjDL3N7wjHwOsCbdtuo/Mn0FmvYWVL5uIFXuToK3hdbvp7F4cYwZ98NK6t/6gY+WLQ59Q0LUV4iCbsKhg8SjQHYAxthBc+7Cy68/ZInYf/N5zBC52tvs/PAZbg44RO90tPw9L3hjOfV5reAQwtoiNBfJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=TsBpZ4De; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="TsBpZ4De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706176217; x=1706781017; i=jan.kiszka@web.de;
	bh=B3NNa6ec29KOR8V2U2kFSn20WbuoDKc9eMv5pwRi/1s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TsBpZ4DeNEOZEHt3kVbS3fxskO1OjvTLteUMMB79nBCaXinfOjaNfyNdJ09VQORs
	 gdLHfWCOpJUqE9Q/Ki9gXmldgJyZHHx6aU6Rws591L6lo+1RL0e2BYxSVdvoTQ4Q5
	 TgPv+00z9kHB6PCFPl648ythG+aA6P9BgiiALgomZbZxOpHBy8a+MiZfKV+leusXu
	 zgmw8955rmOtZvnHwFNpDH6WZdCwFL3+nF3CbD263B4vm9Gt/2/UopZ1ZfKFg9zn8
	 ETwAWS5ypra24QdCFXVw4FIPru96xaMflh/386PTJ7HpU1XN0LeVo/CtgmPB3CQdo
	 T2/kcGg1FaOQvpqWjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.89.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1rLkJP2O3W-00BZqn; Thu, 25
 Jan 2024 10:50:17 +0100
Message-ID: <87ca0f83-bb2f-49fd-8e30-8873778cd8a9@web.de>
Date: Thu, 25 Jan 2024 10:50:17 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NX-protected page
Content-Language: en-US
To: JerryJun <jerryjun123@163.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
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
In-Reply-To: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VONpg7Cfr7Lf67Co4XEkd+AE8yFXHMY5ihRa/LNEJM9f7HZfVPP
 1Ux/9qOJ1nOaukBR7hrRMBKPNvp6Vxe8KLHIkeqXyHTUhIE+iveXU5tV3DGfljNc6wAG2wF
 v7mKDZ42QrWkr7Li1HgUO6dLYA3kBqgUz1ZorjP4sOliavGuV0eaUFGUudrhqhk0NjHedrE
 OyGEIMADgFwe5mWYqM4Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rzqezokVTxA=;5U3+U7CC2hRskkDSn2TLOfm5QNh
 xwdi/iASziqQOYYk/6banZuNpwyL124zF8+Jmpk0H+jQsjEneKeEFVYN5l+mqOItocWiekQAF
 tnkqyGoYQ1oV0K95JgrjJr7X5NloA+fpf2aX2weVPkYnDFYtlT/Bc7MAf8jpYdvfTcEnAVoue
 t47aUNK34RbGNGJzDudXvJpSh/vFE1w6oVXZkRBBrPFwbQDbN6UeRX1lU2OWIY0B174PdhquU
 QxT6nznMV4/ahW3qWYKbzR7YZp1rsN5SkyjmyWwf+lI7z59cbB5rlrQSrBFHTUNVa9DGdhDxU
 /WyGXPWgDFiMyEWYJ6VmzM6KB3fbUhE08aUFlYg0M9VNRo6qZdw+uUreqNn9ZKQ4z/o0AXlOL
 vOgS5/4VDl9/qxE4s9iUliSMbKANtz/O2peq9sUaePNQRqfDrVkzD3weMUA/9ARjDAc4nuRpY
 1XlV6TXUFWNASN0SiIIRnW1upAweKgDGGwPODOnrNytozwqnQDBTjaQyRzpF1Dbq/fQ/8BYWo
 Uz7o6IdQHh1GBevfCBNSLnP2mv+SSSeuxdXpU6zNTTqo39HMtafQP7NDr79D/jOJSJmUjlqMZ
 Z+Q+nDM/i/PJ9BwHFtIn6qPSTJ3gL0SLWvVyA54PAt6oDnGcAzkV1BnL3l2BBF6zp15hPCi+u
 o+oDfccu1kyZzYf+20ZSIb6q9kcmd0WJ2MQa9ERHi+m42euYxToaFV5g+535KE7vFbkQv3gs7
 1RISrsfePYcFxshYDeHYoxmOyTU+b+QOeFx1R818sZQpnjUftuu4O4qstLsK1OEMxvnuTU1UH
 Tc8S2gi3h3YOc1aFrTE5SIlrB8ZXo1uZH8I27KjC5D+enrh4g6b3Xqc0YuUk/nRAVeKdtJC3a
 MQBxtGD4gsReBoDU/leJJj8F3hgvYZOX8y8WNc7tE5PFV4Z1W8PNe2hH3Xez/ehIj3PYKhmmN
 JSscyw==

On 22.01.24 04:10, JerryJun wrote:
> hi,=C2=A0xenomai:
>
> we=C2=A0use=C2=A0a=C2=A0small=C2=A0xenomai=C2=A0application=C2=A0reprodu=
ct=C2=A0NX-protected=C2=A0page=C2=A0question=C2=A0,=C2=A0it=C2=A0will=C2=
=A0appear=C2=A0within=C2=A012=C2=A0hours.=C2=A0please=C2=A0give=C2=A0me=C2=
=A0a=C2=A0hint;=C2=A0
>
> the=C2=A0application=C2=A0is=C2=A0implemented=C2=A0to=C2=A0create=C2=A0m=
ultiple=C2=A0RT=C2=A0task=C2=A0which=C2=A0set=C2=A0affinity=C2=A0of=C2=A0t=
he=C2=A02=C2=A0cpu,=C2=A0prio=C2=A090=C2=A0and=C2=A0manual=C2=A0bootstrap=
=C2=A0,=C2=A0perform=C2=A0FFT=C2=A0only=C2=A0occuiped=C2=A0CPU=C2=A0with=
=C2=A0rt_sleep,=C2=A0which=C2=A0be=C2=A0killed=C2=A0a=C2=A0few=C2=A0second=
s=C2=A0later.=C2=A0
>
> the=C2=A0kernel=C2=A0oops=C2=A0appear=C2=A0when=C2=A0kill=C2=A0the=C2=A0=
application.
>

What exactly needs to be done to reproduce the issue with your code?

Also, does the hardware play a role, or can you reproduce it in a
qemu-amd64 instance as well?

Already checked if there are differences when using [1] from xenomai-image=
s?

Thanks,
Jan

[1]
https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel=
/linux/files/amd64_defconfig?ref_type=3Dheads
