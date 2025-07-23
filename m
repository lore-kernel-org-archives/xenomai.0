Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE23282F5
	for <xenomai@lists.linux.dev>; Wed, 23 Jul 2025 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311789; cv=none; b=nVMU/er05qajGByLkZm1IKU27LjCladhH6IEtvpqukZW/Iu+3ajIp+/LZm0QathIpaCLqMLydzxx26cbZXtwoo9voh1sp27Lsg33UAn0NhTPFaxX7WQ6T+FGSf57IGQB6Av5bq9xvER3NXFEKrfjeZTtfy+4Qvq/nAjx5jf8Iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311789; c=relaxed/simple;
	bh=ir8NjjuIOWtpbCv/476ywVT1znnbVVYBxHgRtmWvCpg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UkdWaJWG2KaI/J9n734ISvsl3d+UXOXBRBBPAyCTTinhLN76Z9eznE7a4/qZuGHETQ90sZhga9xfkivPwRcP5ZtAaa7RZNeX9XumZgz3LiEaupdQ8qlVfwKylBr00mSgtUqzgnT0Gsl02fyHM7MLaRl0f1ArnAQPwFcXAqVdDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=babic.homelinux.org; spf=none smtp.mailfrom=babic.homelinux.org; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=babic.homelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=babic.homelinux.org
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bnTzh1HhCz1sFNb;
	Thu, 24 Jul 2025 00:57:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bnTzg1FbWz1qqlY;
	Thu, 24 Jul 2025 00:57:19 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id ZChw0zx0iqZm; Thu, 24 Jul 2025 00:57:06 +0200 (CEST)
Received: from babic.homelinux.org (host-88-217-136-221.customer.m-online.net [88.217.136.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPS;
	Thu, 24 Jul 2025 00:57:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by babic.homelinux.org (Postfix) with ESMTP id 083D6420137;
	Wed, 23 Jul 2025 22:57:05 +0000 (UTC)
Received: from babic.homelinux.org ([127.0.0.1])
	by localhost (mail.babic.homelinux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12zwHdMNqG1M; Wed, 23 Jul 2025 22:57:04 +0000 (UTC)
Received: from [192.168.178.132] (unknown [192.168.178.132])
	by babic.homelinux.org (Postfix) with ESMTP id CFF65420127;
	Wed, 23 Jul 2025 22:57:04 +0000 (UTC)
Message-ID: <ff2d19f5-ae8c-4db3-904c-c5498733e9c8@babic.homelinux.org>
Date: Thu, 24 Jul 2025 00:57:04 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefano Babic <stefano.babic@babic.homelinux.org>
Subject: Re: xenomai.org down?
To: Jan Kiszka <jan.kiszka@web.de>, Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Luis <luis@apue.org>
Cc: xenomai <xenomai@lists.linux.dev>
References: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
 <CAFc1U0v7ENaCASVAje4CdEoJ7xP1GmM13StK4rVCt9T88mBGSg@mail.gmail.com>
 <f616e74e-2df6-494f-9017-201e5825ab4d@web.de>
Content-Language: en-US
In-Reply-To: <f616e74e-2df6-494f-9017-201e5825ab4d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 21.07.25 18:33, Jan Kiszka wrote:
> On 21.07.25 17:34, Pierre FICHEUX wrote:
>> Same for me.
>>
>>
>> Le lun. 21 juil. 2025 à 04:45, Luis <luis@apue.org> a écrit :
>>>
>>> https://xenomai.org
>>>
>>> GitLab Logo
>>> 502
>>> Whoops, something went wrong on our end.
>>> Try refreshing the page, or going back and attempting the action again.
>>>
>>> Please contact your GitLab administrator if this problem persists.
>>>
>>> Go back
>>
>>
>>
> 
> Thanks all for the heads-up, I've informed the admin of source.denx.de,
> our host.
> 

I could have access to the server and I fix this, it is online again.

Stefano

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com

