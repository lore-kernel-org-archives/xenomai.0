Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849823C8BE
	for <xenomai@lists.linux.dev>; Tue, 18 Feb 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877290; cv=none; b=tyS/tPgjPXBVla/57KL4M3KxIwaQNBZUfCFyCBtyohtl+Itr3lJ3qA4OYqrA/GV79OzPE09eKhp68hr/PXjp3b0GMxvtggTV7WxIyO/E36/LWDcPLB/bbXi4x5NGmDaLXNCEY8Ma07vSz+dS7FKW7hN9O5QZ1jk1h392mbJDr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877290; c=relaxed/simple;
	bh=Guc+tyljzfoDizcrgKDyoZdCK2KxMXHzE0WUrL4i+xg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HUF6GUDqxjAp3C50LJQR0NNBJOp+GyVlOHoP+ByLxZhCnbaE+Tc2FcVWbugzYV7KeDWVvJoKv8ClVFp0TJ6lqTgAbSOkxwg5EpVHlyxjjWRIAguzmj2WCl96+QeQyDBdFj9tH/gTOE7H1lJ7GTME5o/QEJvcdkiFw5PhdnudeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1tkLUZ-000000004SK-1ZsC;
	Tue, 18 Feb 2025 12:10:19 +0100
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id 7F758FF8C3;
	Tue, 18 Feb 2025 12:10:25 +0100 (CET)
Message-ID: <c94f3dbe-5cee-4257-b325-88aa5aef63e4@eltropuls.de>
Date: Tue, 18 Feb 2025 12:10:24 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
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
 <6da320e9-ae7b-4c5e-8074-ca8f71a0a04b@eltropuls.de>
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
In-Reply-To: <6da320e9-ae7b-4c5e-8074-ca8f71a0a04b@eltropuls.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

On 18.02.25 11:57, Marc Strämke wrote:
> Hello Florian,
> 
> On 18.02.25 11:42, Florian Bezdeka wrote:
>> We're using Dovetail on x86, but: I think all of our boards are Intel
>> based while yours is an AMD. There might be a small but significant
>> difference (code wise) somewhere, but as a kvm / virtual target is also
>> affected that's kind of unlikely.
>>
>> Let me try to build one of your configurations that does not boot up on
>> top of KVM. Might take a couple of days...
> I finally got xenomai-images to build and the result boots on my 
> machine. I will try to figure out what the differences between both are 
> kernel wise.

I have to correct this: KVM runs with -cpu host , which was given by the 
script in xenomai-images but not by me. If i run qemu with kvm and -cpu 
host flag my kernel boots just fine.
