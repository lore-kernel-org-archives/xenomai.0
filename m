Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.29.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD019212D6C
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.29.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784494; cv=none; b=TFhBdfKmOwm4kjOIKMn7Idk2RUBk65aAD+mO7ZUwT967HUItu9yPwC/Inoko4rUP7MeqoU6sdgPZiOHYbeBFHlj31448FKYnhnLStcWJ98QcvQD2RtFLa2D3IyXB9nl6zrm0pFKUgZoJiQAK3kLK+xNg4l05f1vWxdkMD35Sc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784494; c=relaxed/simple;
	bh=1485PP4a7aZvUWx6NVbOMUdu6/mvaEFdPUd/mVlUmCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fg+0RQR2o+/1gcqXziWERD/6Vp2TUHu1R3RC5bWlT7+Q+Ii+wvnesfs8WFf+wxUVhBEInQCbWNPDooyLo7G+JiZviZMFytn5zISslGlvC/31DZzirrBH732uxDPwtWHgXqftp1RlZQg0ZMuAt1ankAAAZIPXjy8sA346CqFCwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.29.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1tjxPu-000000002xG-1X9d;
	Mon, 17 Feb 2025 10:27:54 +0100
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id 588A5FF8C3;
	Mon, 17 Feb 2025 10:28:10 +0100 (CET)
Message-ID: <7cc859fd-d627-4eb1-8618-fab8d4ef57d9@eltropuls.de>
Date: Mon, 17 Feb 2025 10:28:09 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
 <108e740c-9919-4cec-afbc-0ae2f08922df@eltropuls.de>
 <67a95cb5-71d9-417a-93fd-62c9a4de60a3@siemens.com>
Content-Language: de-DE, en-US
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
In-Reply-To: <67a95cb5-71d9-417a-93fd-62c9a4de60a3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Good Morning Jan,

On 17.02.25 10:21, Jan Kiszka wrote:
>> Is there any other idea to try for debugging? There is no way to get a
>> serial port for logging on my hardware..
>>
> Hardware debugger? More a rhetorical suggestion. I suppose some JTAG
> interface is also missing.
> 
> If your development hardware even lacks a UART, someone tried to save
> money on the wrong end.
> 
> Jan
I do understand that Jan.

I will get an PCIe UART extension for the machine, but it will take a 
few days. We have moved from older hardware during production to this 
newer one and it never gave issues with the IPIPE kernel. So I do not 
have dedicated development hardware of this newer kind...



Kind Regards

Marc




