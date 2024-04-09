Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6912F598
	for <xenomai@lists.linux.dev>; Tue,  9 Apr 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672705; cv=none; b=SpM9JyFJaFrmKkA6RrBTCkHnasW+r4HNiKJwDedTzA3Q08Pueytl6zKoWo0pPXOcJkBCOCTEOMq8hOAkZC+wJfBoq0C4PWm/X2MBvDpSS7/hXQNNl//nGxmuZfbi2zzu5QhEK3zM77HZVyDzS8FaK+Q+APdo049Q9Gs4uWgGbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672705; c=relaxed/simple;
	bh=21WnAQ8mspMI9QxHtNk73fsLgi/PZp8k0wBCeBv0+E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g520FqDjZDHfDzaH2QRs+HkB6KF/jk+ceVVvhYjFfJ0j+8+saYRyx1elnuyYeWtdX/s4M5DTEtnU6fP4CWytYg8NaZNVSG6AQLzjlrVVBeSwQj6JTOBhXd4N44xY1ach56s8mq2IiSQ/nClAe5eL7I4sRlgmm/2mg/XzrinbWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0zzbjrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0zzbjrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCD8C433F1;
	Tue,  9 Apr 2024 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712672704;
	bh=21WnAQ8mspMI9QxHtNk73fsLgi/PZp8k0wBCeBv0+E0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m0zzbjrxemhI3cBZCo2EsQTNjcU9a0gQKNFSmIusZVUVKDJCDPJeHC6kTG6ZGOZap
	 bMKHpE0A5crbfHExvnIJ+7C7n72yFoppN9lWhdMCsm/LITvNo8Ajhl9FkVTZFaoGiQ
	 mjUxq5AGQvtK4B0THMw2AgXPEQG+Ro8dtL8tVdw5q8dVP0p0lwoW6C/oXTgwJzucWQ
	 gKRK9xA+5l+uahkr4/UhuZN2on9PbkQ7kZm/Y7d2438Q/IVd82hDLsGp3pAFl9h9gH
	 9Og7/4DiKE9pRYkhoKzHVM8CQZf4SzUI/shJpRA+4ZGFAb+wr9kuGuqqj7K4OXfAmw
	 snpsZEsB4RnyQ==
Message-ID: <12cd99c2-3942-415d-934a-4e39e239dfea@kernel.org>
Date: Tue, 9 Apr 2024 16:25:01 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux Plumbers conference
Content-Language: en-US, pt-BR, it-IT
To: Richard Weinberger <richard.weinberger@gmail.com>,
 "Kowalsky, Clara" <clara.kowalsky@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>
References: <AS5PR10MB8173D2257B87726D7E4A9B6593002@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
 <CAFLxGvwWy9YCOOBQmHcPjGmFa+aSGNgtSaLsXhPTYJBuLdZ_WA@mail.gmail.com>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAFLxGvwWy9YCOOBQmHcPjGmFa+aSGNgtSaLsXhPTYJBuLdZ_WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/24 13:44, Richard Weinberger wrote:
> Clara,
> 
> On Mon, Apr 8, 2024 at 1:03 PM Kowalsky, Clara
> <clara.kowalsky@siemens.com> wrote:
>>
>> Hi Richard,
>>
>> regarding the Linux Plumbers conference this year, I heard from Jan Kiszka that you had the idea to submit a proposal for a microconference on Xenomai?
>> Could you give a status update on this?
> 
> I had a brief chat with Steven and Daniel, we are invited to submit
> talks to the realtime Linux micro conference since it covers
> any kind of realtime solution for Linux, not just PREEMPT_RT.
> 

Right! on the topics for the RT MC proposal I added this phrase:

- Other RT operating systems that run in parallel with Linux and the integration with Linux

To things like xenomai, jail house or anything similar :-)

-- Daniel



