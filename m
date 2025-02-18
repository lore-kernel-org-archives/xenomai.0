Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.31.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16331A5BA7
	for <xenomai@lists.linux.dev>; Tue, 18 Feb 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877565; cv=none; b=NOjILK9qavP/KL2Q2S+E7SLmq6wr+BIgfJM1tl3ULl3LH6LfTdsu+wqm9fBHPv8joOVozNx7AVrgAs7XPT2C5VbKwLJsjNQGEVYuIWMFqxmsI+vbW+cVw53P0+uBJOB9/s12Nr2s1OvrEZ1n/89zgoL+ncQFZVwGiNDv2eblEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877565; c=relaxed/simple;
	bh=9tKt5BBmbcKSFeew69taMn0rljVf5FSIEICyqZmUvOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bO2eJj1SCYn18TRSMPF3v4xx/EN1IuWIfHG74/K/WyzaEUJPxOu3VyBKdIp0hgPZk8lKUrOCv6RalDS5TafBP27PQZJJCUs0+6xwJcYHHBTrDJ5cAzINouhuO1DgraHGkmyUC8aBnWa+FWVdf+qbDr5eDH5OMrER6U//EiwE5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.31.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1tkLHr-000000001Bp-1EG6;
	Tue, 18 Feb 2025 11:57:11 +0100
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id DD394FFBB2;
	Tue, 18 Feb 2025 11:57:36 +0100 (CET)
Message-ID: <6da320e9-ae7b-4c5e-8074-ca8f71a0a04b@eltropuls.de>
Date: Tue, 18 Feb 2025 11:57:36 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
 <fac0181a-eee1-4820-ad8c-ea2b88629f5f@eltropuls.de>
 <a398fe9f-d3c0-4254-8a9e-5fe0eff25f86@eltropuls.de>
 <23280aaa-d95d-4ae0-8ce4-ebfcdb857e44@siemens.com>
 <bb3d5883b5fadf01598a192c5afacdcbe66a0ce7.camel@siemens.com>
 <56ea2070-cfc5-4b03-b073-aef489932093@eltropuls.de>
 <d378d69ebda4a573066bf92154a2b8e8358f8aed.camel@siemens.com>
Content-Language: de-DE
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Autocrypt: addr=marc.straemke@eltropuls.de; keydata=
 xsDiBEFDEMkRBAC16/4AIsW+SGfNyPYZWX2h4zk8X2M3zI8EBDBvvXjYaDso1rMb2GneP5Gr
 Wpyw2GZXeStYInjohGDX8PHdHQHpc8+lOq/vcfH3saK17fPNuQRYf1i9W9dP4LaLoMCwXnaX
 0mE4jJdiDBY83qS6TJvqpjnpaarIp4IqrJRlmVj4awCg05qWgBgeLpCx3Xn2iAjRd+rnWYME
 AIprUD9u5sjHPxnpNIWfPv00kJA2vgF57Pj1e+4M1XwdwMPCSmr/rcMudctrfwr864pr8BOl
 g/Sh86a257U0QEZEP3XOAsim+E6q8nrXOFretWPSmm0xkscBXrxcPFShTifCFtMhgSTwIyCT
 owgsMwvhqL4xCAxK7NsR6G3tml+BBACxEEZpjFA5u9BiNQWMeKF7N5hq9kOk/LwIo1ittCuL
 QG6Rlst8GdfcJu4WLsi45SwofjOdVp0lumXPoD7gE3hGBsAmGsegd6sKMO2BrCv46SuIQSLT
 rBjXTV030etX28flziqrOLOWvR2aYF2z0Z1Z6edZGh2iDKAVT/zfx4nXOM07TWFyYyBTdHLD
 pG1rZSAoRmlybWVuYWRkcmVzc2UpIDxtYXJjLnN0cmFlbWtlQGVsdHJvcHVscy5kZT7CfgQT
 EQgAPgIbAwYLCQgHAwIDFQIDAxYCAQIeAQIXgAIZARYhBPEY2LrNuN7QCQ7Z5mx/6fLm8tJe
 BQJiSo3IBQkqbX5/AAoJEGx/6fLm8tJeiM8AoNEJjmUJu0CZTIQdo8eK5qUD/aixAJ9yh4Sh
 aCKFvM412AjW8rgbmuyDl87ATQRBQxDKEAQAuLxm9Eqp0KODFKkbH2YCSCr77MCfVAqmUb+V
 9IacY9SjCz3yQMVMuCCabAAx1VCWOnEkG9f1b7mCe1VRyFmnEWb3xP9DyBF2zEt2i1POpq5n
 HO255XVSm5QwQz6B4k0v6RbJaOJXpotLyn2c0YR5xSKVAed3XDldzjn6L/kyeh8AAwUEAIep
 mwJqAIpPCAXQ5UjWAt2fwyExCkI/1YP0R7yob45shvzzRwFabGzPTANGfHIKngnXs4Wby0/p
 8htzTj01eThKqGCv4SWMtovkAtZyLYf3sQhSItoM7rm/EI3vlOdFmk5/Glvqwh6OYSD2PDN/
 wv2aeXe1btDS4Mva2gNBADMFwmMEGBEIACMWIQTxGNi6zbje0AkO2eZsf+ny5vLSXgUCYkqN
 3AUJKm1+kgAKCRBsf+ny5vLSXsrbAKCQnWHw1QfHnQ+l+QYZfhzpcHuA9gCgr95BhmLo6Q3i
 bwTdu/yiVf4VDHk=
Organization: Eltropuls Anlagenbau GmbH
In-Reply-To: <d378d69ebda4a573066bf92154a2b8e8358f8aed.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hello Florian,

On 18.02.25 11:42, Florian Bezdeka wrote:
> We're using Dovetail on x86, but: I think all of our boards are Intel
> based while yours is an AMD. There might be a small but significant
> difference (code wise) somewhere, but as a kvm / virtual target is also
> affected that's kind of unlikely.
> 
> Let me try to build one of your configurations that does not boot up on
> top of KVM. Might take a couple of days...
I finally got xenomai-images to build and the result boots on my 
machine. I will try to figure out what the differences between both are 
kernel wise.
