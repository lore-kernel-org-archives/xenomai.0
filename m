Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EE263F29
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.119.228.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539641; cv=none; b=CfDWI8NsunZDSERfEBp2mpXGRTyzYNQ5KW96UkGOuNqqwh3ymBHv1/zdZZcRdV8sucoyASPAk7aA3HE3J7HyBLI5ff6vwMLp4cQAClJXQ7vXcZU2A3Lkv2QfJ1Etrw0uPERSe+vAUqoSepdyBAQzi/eR2weZYhbEAp7lgOc3RKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539641; c=relaxed/simple;
	bh=mizIxKs8DWM2dCf2qE8uTgyBFDMmyLplupnWyHa8e7Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bB0KHDq5BSLyyXfm+6VTgTLhH5L//onwzqV6feYtR5ZrljZMI5Qo3yvRs8MU/u/AKhO2fWaAGPWIHSIrsig7dAd6sA0SnY4inf60IeqSmDsvsjwcJz+SHzriOqLD3kUW6fGsyIQKfCO41qUmmTg3uL02zc9BkFk/qChhE9uRFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=134.119.228.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1tiu6Z-000000005Ea-1GkQ
	for xenomai@lists.linux.dev;
	Fri, 14 Feb 2025 12:43:35 +0100
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id 42C77FFB39
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 12:43:34 +0100 (CET)
Message-ID: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
Date: Fri, 14 Feb 2025 12:43:33 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
Content-Language: de-DE, en-US
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Subject: Problem with moving from Ipipe to dovetail
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hello Everyone,

I am trying to move from kernel 5.4.228 with an IPIPE patch to a newer 
kernel with dovetail. The config from xenomai-images works, my config 
does not.

The hardware platform is X86_64 on a Beckhoff Made CX20233 industrial PC 
(CPUINFO model name      : AMD Ryzen Embedded V1202B with Radeon Vega Gfx)

I tried bisecting the kernel version and basically the problem lies in 
the switch to dovetail as far I could find out.

Then i bisected the configs between my config and the one from 
xenomai-images and got a strange result:

The config setting which triggers the diff in the kernel configs is 
CONFIG_SLUB_DEBUG_ON=y. With debug on the kernel runs, with debug off it 
hangs.

Any ideas how this debug setting can cause this issue? How should I 
continue Debugging? I have some mistrust in the "working" kernel because 
I cannot really understand how the SLUB debug setting could resolve that 
issue.

How would I get more information from the frozen system? I turned up all 
debug settings and get basically no output. The IRQ Pipe torture tests 
run ok. The problem only appears if xenomai  is started during boot. The 
failing kernels do boot with xenomai.state=stopped as a parameter.

Kind Regards

Marc Strämke

-- 
Marc Strämke

