Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7ED1CF95
	for <xenomai@lists.linux.dev>; Thu, 25 Jan 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175534; cv=none; b=dNN5YWh+tl2VfiPgIG1KJct8tgJWzbc3emtNLw/NefuisdoUkPhj2+lr88iF3i1e1ZAU5nA66OXk7Q/LdkUPlFZBpeH+ZX0IgYHXawaCw4/NWzr5/Uavku3ZAQmOZxmXp3sIMuIQcpVBCvCVO6mKwZ+WRfm3fplQ7dht0lelmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175534; c=relaxed/simple;
	bh=FbzhhNmUZUxamYb30CGpQ4koHNrNqplfaiLYSIco8ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=holFuWzhwlPqS2q5I1Q6N3MpWm7e2Fi86qlBjQJ6V1s+n0tWd5mDeblRBbORpc2hFvx3u05fbErZBTC5sXOQcQjplxMpUMkfurLurozx/uz7LHRrSMqFigPCTkhzN36QT1gzwbdEGiBAThOC/DVr4hLE+1XCNt5BPlSm6yfoKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=j/bXikBh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="j/bXikBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706175518; x=1706780318; i=jan.kiszka@web.de;
	bh=FbzhhNmUZUxamYb30CGpQ4koHNrNqplfaiLYSIco8ic=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=j/bXikBh4uyE6pmQa0pzKBQj29eO0qU1U5PMERNe+gZUXomfsP9J9DBR1LKINIfw
	 17Vq2NDhOXh10zNm2akcWAJeieWezV9zY1c8ganKQLmU2jnj2AZybMbrCTlB08TQI
	 ZpcKwaE8k0BGHHZZFXftM5rUoZyvZOZJYrQncavX5xGDsr+oIBtAlq94qiJojBJ7q
	 YpXG/W7xKy5BhceQFv9XvTKbligH/s40xVAkpvEOqpWzui3e0TRRxJ2YakyvK0m4+
	 tyhKwQ1TDsn8CLqCnvrRpYrxEP+Tt5tjcZdqAhDjLU0m5CFWAPs+3hoKMpCih6MQd
	 aim0Zoz5kusOqDs8Qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.89.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1rHMfs1aiA-00Fwzb; Thu, 25
 Jan 2024 10:38:38 +0100
Message-ID: <eeca8d27-c3b7-4a89-8bbb-55a5a188a287@web.de>
Date: Thu, 25 Jan 2024 10:38:37 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: latency: pthread_create(latency): Operation not permitted
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 mars_liu2023 <mars_liu2023@163.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
 <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
 <5da66ea7.23e4.18d2c1eddae.Coremail.mars_liu2023@163.com>
 <9933892442fcf9195f1ac75e23b9fee46b830ef2.camel@siemens.com>
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
In-Reply-To: <9933892442fcf9195f1ac75e23b9fee46b830ef2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vurRJoKg6B9Yl0rMK2IGGQP7RWwzu7OAl1YUkSmTfLc10W4TQC5
 KkFC1LNqI8YN4RXdFeMMHLHEn398SnSeDT3kv4yu49/UGQvZCriV5Bf9Qi4lX09sCyeI7i5
 A7EvWtFYbCs9nSbORiUJfF55swD28Y3PoAysl07nCp7FC1j18m1tvbYczF7gqFjUKtndfb6
 ljb+4xSATf1FpwBTe/WEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6hhHS0eFVY=;HSStzvaFbNw7ZH/GkokWGriG8V/
 9dXy5pDEGOd4310jME6PSzHnJSuVjOyiTlS4QL785bg/KkQlW9vCLjSOnCXVSZin1fKcG/RVb
 nEPClWhna1x1tuTPde/sIwPId2qZSUZBlZ736cfbhttnnBFEPTP0bL4i1i0K7iheg5hkmHVXP
 25HyaJFBQ/Kj+X0Y3BwL1opG4eOewHfRCL0gVVb0KEg+SkH8/H+QHp1U/ZiFRZ7uYkCSTqJhK
 3OFWi1k+iEPBbIcv1iVyKl2OZRuET8/Av2m3D2Bhgf6LSWa0NZ+pksCrFBP6rpMH1KdBoSiBF
 FzZHcCV6njlrxdILfG80tUzkMXHqCT08FgKabV1nJugTESXA/Yb26yHNPdq3nrr5nNbMhlHf9
 UrDt3bXo5RmoO/yGi9mcsifPLqFXAA44SQ3/LTEnrU/ec3UwAoxkvGh5wvmb8MrID+o17q48l
 SED3t4ulyspYL1varmvyaK5GitWpd3DnvqxJ37D/jbcKr81V35maOvjpt6eZUvZgoQtNHAT5y
 lH4WpckyP9OBpZwDCo+uTEepp1Zy/Mi3RYs0PTg00awSd7+O8Z4OagBn4WqzNA5/RYeeXIjx6
 xI0k6oTXds6X5zbt6QBGoP+RAEgDhSZAVCs7ZH6DXMhM+wS6gL/Dw0sAdj6PKjdeHPL1d6BoR
 aYuTr3YxVJAcBy0xtI59CRIyNi39rpQZZiLJwQw7CeFfUtMhgp4dVGkIOPfuslwUFC5vlCwqO
 O/mJ9XVv5OU6g2xoT+U6/LyPRlMOgC3QDOIEn44omWY2wraILknB4uKJGwzvs0QX/gKgz5goe
 Lramm62fTOdNpL/xQhLRgSVqTCtiuc6LwL/PjkUW+DPH94PMJhiZFtWOtHQdIPubt9wbu4+ge
 7kuZfhwCHtLfVI/8gza45Cl5I1c9NhJefjZmyXPF1dzfABQHirBSFW9ymKaplqVxT9BnhoTth
 icp/RsTtNVgjrVqawNQJ6jphAgM=

On 24.01.24 17:39, Florian Bezdeka wrote:
> On Sun, 2024-01-21 at 21:03 +0800, mars_liu2023 wrote:
>>
>> To=C2=A0Florian
>> This error is running the latency=C2=A0utility=C2=A0outside the contain=
er.
>> I installed the containerd.io package through the dpkg -i command =EF=
=BC=8Cthen running latency utility=C2=A0 outside the container and this er=
ror will occur.
>>
>
> I tried to reproduce that here in three different combinations:
>
> a)
> - docker 20.10.24+dfsg1 (docker.io package from Debian 12)
> - Xenomai 3.2.4
> - Dovetail/Kernel 5.10.
>
> b)
> - Dovetail/Kernel 6.1 instead of 5.10
>
> c)
> - Xenomai 3.3-dev (next branch) instead of stable
> - Dovetail/Kernel 6.6 instead of 6.1/5.10
>
> a) is running fine here
> b) showed the problem
>    /usr/lib/xenomai/testsuite/latency: pthread_create(latency): Operatio=
n not permitted
> c) Same result as b)
>
> Disabling the systemd units docker, docker.socket and containerd
> followed by a reboot "solves" this problem. I have no idea what's going
> on, but I guess it's something related to cgroups or any resource limit
> that is changed by one of the daemons on startup.
>
> Further investigations necessary, unclear if I will look into that
> soon.

I vaguely recall such an issue... Once you run a docker runtime, there
is a policy change applied that even prevents normal cyclictest to be
started under preempt-rt outside of any container. I don't recall the
needed changes to make that work again ATM.

Jan

