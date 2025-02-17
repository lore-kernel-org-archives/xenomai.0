Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.31.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1161B4155
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783549; cv=none; b=na3sBmdabywANdAHcY0xgqHDlVuwxMRcssgrrJlA8goFKQLKTCS/WNH96KVA+VKWhSSf1WUWlLaXO7agMa1tgzjlMk2QtmNY68sE+CDLIh+IwTvon7pI+i7LjIvSo2dVMkyuY8/DfTq3jYwIy1JVaNhcBp+hlXXIz7SzDXPjE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783549; c=relaxed/simple;
	bh=nDsOhD8osTmEVArxXt0+IpSclbqeXqH9HeKP8qrjkaU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=EVQRLgNFG1jwOlFJ3sZEhU+izJRjHcIXIfDhP2WomilSs1xIQmL9oQ5z3kEJbeV1XYpInfooF6ZoJ3IDHRHS8hvzmqcb7byJ9+earHV2xK7lJx9e/gkEtizS60GM4KWxmtV4WNAUQnpCD2gSQ37KyTgQC6oxZJnkwE9p+IZZius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.31.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1tjwpR-000000003Kz-2WzR
	for xenomai@lists.linux.dev;
	Mon, 17 Feb 2025 09:50:13 +0100
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id 878F4FFC30
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 09:50:16 +0100 (CET)
Message-ID: <108e740c-9919-4cec-afbc-0ae2f08922df@eltropuls.de>
Date: Mon, 17 Feb 2025 09:50:16 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Subject: Re: Problem with moving from Ipipe to dovetail
To: xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
Content-Language: de-DE
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
In-Reply-To: <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hello Florian,

On 14.02.25 16:34, Florian Bezdeka wrote:
> Does your problem also reproduce on qemu/kvm? That might help to
> simplify the debugging process.

Sadly the issue is not reproducible in QEMU Both the "bad kernel" and 
the good kernel boot just fine.

>> How would I get more information from the frozen system? I turned up all
>> debug settings and get basically no output. The IRQ Pipe torture tests
>> run ok. The problem only appears if xenomai  is started during boot. The
>> failing kernels do boot with xenomai.state=stopped as a parameter.
> Might be a bug in the IRQ pipeline that shows up as soon as you enable
> an oob stage. A boot log might help to get some more information about
> your system.
>
> Is that a boot time failure or something that happens later?
>
> Florian

Is there any other idea to try for debugging? There is no way to get a 
serial port for logging on my hardware..


Marc

