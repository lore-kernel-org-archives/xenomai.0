Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CD282F5
	for <xenomai@lists.linux.dev>; Wed, 23 Jul 2025 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311801; cv=none; b=ZJTQUg5/zL/h2LdAYNjfeiLGqWkKAYFIkMWUHfZ8OA8gecrtR1+2K6IZG0TiebUk86hSnaybgqdV2btD+TYCekGfzJoVbInLfriu7gMRlCGTRg25/vn+vsiK1iLEEgyqal/Ri46D0SKCtdY2wvQD2zDZbEeogmn9i5vuuQH6iFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311801; c=relaxed/simple;
	bh=XMToJsyg3ll5jNbwvFplqO/u+UtMkrHzm6MmURNM82w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5YHElcz8ZNQmw7oiGsE8VoqtI82Q74AXO+aEojx7XOf5Mk3xA8151oLR7UFj3Ak9u1u6m1DGt6p19amOOMCo2EhQ5QNXtbmV8VYMXyAaXSG0+8McN+7OpUufEWMvZyxl+R4c67E/q1I1NTdvxjL2O/pZW0aP/EaqdTwvh9eABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=JkCuNe0K; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="JkCuNe0K"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A62FFF9E5;
	Thu, 24 Jul 2025 00:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1753311282;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZVtXl2lD24B7aRm/+uIip3dCCcw26Eet3LLucqFfyvc=;
	b=JkCuNe0KCiz6pYCbknpyVx90ERBUUlpIcLr/Bb9t8QxfxMvf5sYn8CB94NNcCz4PgLqQMG
	VyUIFV86wfYTmYe9/KyW4yHA8s7irR9xmboirSvoOlL5l0tDIvp8y9BN1sIwY+Eg2mQFN8
	EU8cqRa2GAsJEBJO5zWh2Pd5LgtBinNYRIoGf+Ik+0NVsTK6BlCa/AxbOZW7/2jgUEX5VJ
	HBNxlMcO4G/Hyic+4dfkYx7o4+GqEYf8MvKDjh+Pr0wnfJpWfnk9bITaZKrjsAOw7Il3dV
	2OHHn2NjWzafA5n44RbhOEKkKxyBsFrTYfsa1+pzDdSeU1ehrjy4SrbSJyd7Sg==
Message-ID: <3fe17e00-5a49-4c1d-adc5-fcc3e5713c7f@nabladev.com>
Date: Thu, 24 Jul 2025 00:54:39 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai.org down?
To: Jan Kiszka <jan.kiszka@web.de>, Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Luis <luis@apue.org>
Cc: xenomai <xenomai@lists.linux.dev>
References: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
 <CAFc1U0v7ENaCASVAje4CdEoJ7xP1GmM13StK4rVCt9T88mBGSg@mail.gmail.com>
 <f616e74e-2df6-494f-9017-201e5825ab4d@web.de>
Content-Language: en-US
From: Stefano Babic <sbabic@nabladev.com>
In-Reply-To: <f616e74e-2df6-494f-9017-201e5825ab4d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

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

I could have access the server and I fix this, it is online again.

Stefano

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com

