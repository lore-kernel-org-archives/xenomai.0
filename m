Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979301991A1
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.119.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778273; cv=none; b=fKQEEWtu8pZXXV0/UmHZRTUezM2LosOvqfLkJIrkezzKayLx44oyxj8ou4Tr2+tAz7x/IFBCpGrutUKcStEHVwQbMLncdTQzpTyPEVr5e6zcq+c/FbSAxcTuBo4ts6sItd6D0nDTOZC+j8xpVNCXUi96jbQPftu7lKzgHUUrDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778273; c=relaxed/simple;
	bh=uWueRi6tk49nfwa5RZGxgHVu4qHhRrhJ3a19YWNPNv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fSo6bVgHgvhzBaXgvqsG7lIrcKJWeYsIjGYVwFikxpG14++4bVFc82yisWhC+hbtEL4hNG20yfeJ0WjQae5bZhXlrV2Znhx04wFUgYO1GKiupJwOhIFz0Li7dCuJkOuHEhxzvlZz9o/q1bdFp0GnaM+xp6gdrFPG6RHqkWEmv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=134.119.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1tjvmk-000000000z2-0rig;
	Mon, 17 Feb 2025 08:43:22 +0100
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id EC147FFCB3;
	Mon, 17 Feb 2025 08:43:20 +0100 (CET)
Message-ID: <fac0181a-eee1-4820-ad8c-ea2b88629f5f@eltropuls.de>
Date: Mon, 17 Feb 2025 08:43:20 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
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
In-Reply-To: <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hi Florian,

i cannot seem to get any kernel to run in QEMU ,-) I will need some time 
to dig in to it.

Marc

On 14.02.25 16:34, Florian Bezdeka wrote:
> Hi Marc,
>
> On Fri, 2025-02-14 at 12:43 +0100, Marc Strämke wrote:
>> Hello Everyone,
>>
>> I am trying to move from kernel 5.4.228 with an IPIPE patch to a newer
>> kernel with dovetail. The config from xenomai-images works, my config
>> does not.
>>
>> The hardware platform is X86_64 on a Beckhoff Made CX20233 industrial PC
>> (CPUINFO model name      : AMD Ryzen Embedded V1202B with Radeon Vega Gfx)
>>
>> I tried bisecting the kernel version and basically the problem lies in
>> the switch to dovetail as far I could find out.
>>
>> Then i bisected the configs between my config and the one from
>> xenomai-images and got a strange result:
>>
>> The config setting which triggers the diff in the kernel configs is
>> CONFIG_SLUB_DEBUG_ON=y. With debug on the kernel runs, with debug off it
>> hangs.
>>
>> Any ideas how this debug setting can cause this issue? How should I
>> continue Debugging? I have some mistrust in the "working" kernel because
>> I cannot really understand how the SLUB debug setting could resolve that
>> issue.
> Nope, no idea so far. Could be everything...
>
> Does your problem also reproduce on qemu/kvm? That might help to
> simplify the debugging process.
>
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
>
>> Kind Regards
>>
>> Marc Strämke
>>
>
-- 
Dipl.-Ing. Marc Strämke
Geschäftsführer / CEO

ELTROPULS Anlagenbau GmbH
Arnold-Sommerfeld-Ring 3
52499 Baesweiler
Germany

Tel: +49 2401 - 80970
Fax: +49 2401 - 809715


Geschäftsführer: Dr.-Ing. S. Strämke, Dipl.-Ing. Marc Strämke
USt.-IdNr. 291 812 490 / Steuer-Nr. 202/5739/1186
Amtsgericht Aachen HRB 18539
www.eltropuls.de

Der Inhalt dieser E-Mail kann vertrauliche Informationen enthalten. Falls Sie nicht der angegebene Empfänger sind oder falls diese E-Mail irrtümlich an Sie adressiert wurde, verständigen Sie bitte sofort den Absender und löschen Sie diese E-Mail. Das unerlaubte Kopieren, sowie die unbefugte Übermittlung sind nicht gestattet.

The contents of this e-mail may be confidential. If you are not the named addressee or if this transmission has been addressed to you in error, please notify the sender immediately and then delete this e-mail. Any unauthorized copying and transmission is forbidden.

