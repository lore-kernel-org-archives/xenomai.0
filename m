Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88313B293
	for <xenomai@lists.linux.dev>; Mon,  3 Nov 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179323; cv=none; b=Nnq7u9jEZoV4NFq6G6uibbx/W7j4sZK0xoaxLSmjeo26bPJVpC7EvLw6lsieOhHIurfBngX//yNU3O9/dLzWLy7iRmJ2AzFySz3dmlcLHiYtNXDHYwNMcVNwQPkvWspcM7piQj0v6Y+J9uOjeL6wNmmA9vYycTLjkn2ECifV5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179323; c=relaxed/simple;
	bh=Oj8TIcowaCPGB4I1KVwlM1xBTAbemXe8vYU27KXmWJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ALERuAfgQA3slXAQBSEVmrq3QpNYt1WgB34T6P1LPEEieUybnPr7mZhWT2EpaECYGvUSskXiExbLlX108vX1Q5hWMa8ixa4bodQz9+exe+fKNsmfGrz+Hb+8yHLT3z14v2ucb7waBAIn9QYGknL2/aMsyqtpEoGVVNaJFyDDoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=grs2xKUa; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="grs2xKUa"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 48F49581A18
	for <xenomai@lists.linux.dev>; Mon,  3 Nov 2025 14:06:30 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9C544326A;
	Mon,  3 Nov 2025 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1762178783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLei5HccQ3sKmGNSRcGBSkp0ScdGe97Y1Le2EbFtB84=;
	b=grs2xKUa5Y1PAgt3lg3uO1gB1ry/1IO1In1I+ni5SdUsolajA0kwxJE7AnubC7NXqaSHtw
	RAdDTv+ReoJY4f4xkAXywUTh1nRqJOwwpvykLE4d7iRr0h//6nAwgqrFpy82RjrgSortYX
	og8erZKVa5ccv70BKBNf4ZLC8OLUdoF6a+JHREGXnIQVVIlu5gf04cDr4z1GIX5SfGk2Um
	6hZotwQpLLRpQQXyf4WFnhSo2lS2el9wkP2JvRUv1vj8bo4uwW+dNB52UWOICSagR04Vyt
	6G/FVnGXkZQM/EPLC3JNZQ0Wg8vQUW829sS5gYvxXB+8+3xghoxa9KCDaWwarg==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <58fcd922-3a50-74c5-bfee-01cbcb7e1e6d@bela.io> (Giulio Moro's
	message of "Sat, 1 Nov 2025 11:33:35 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org> <20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk> <875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk> <20251030132602.2d1ccfcc@wsk>
	<87qzukuzy5.fsf@xenomai.org> <20251031165615.2c9f72f5@wsk>
	<87bjlnc9u5.fsf@xenomai.org> <20251101165957.12432bf4@wsk>
	<58fcd922-3a50-74c5-bfee-01cbcb7e1e6d@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 03 Nov 2025 15:06:22 +0100
Message-ID: <87cy5znrc1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhukhhmrgesnhgrsghlrgguvghvrdgtohhmpdhrtghpthhtohepghhiuhhlihhosegsvghlrgdrihho
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

> Hi everyone,
>
>> CONFIG_COMPACTION=n - it also automatically set CONFIG_MIGRATION=n
>>  From the Kconfig dependencies CONFIG_MIGRATION=n -> !PREEMPT_RT
>> [=n]
>> (i.e. it can be only enabled when PREEMPT_RT is NOT)
>> I've just set CONFIG_COMPACTION=n (which also disabled the
>> CONFIG_MIGRATION) and now I cannot reproduce the issue on my setup (i.e.
>> v6.6.) anymore.
>> It looks like those (enabled by default) config options have slipped
>> in
>> silently and introduced the issue...
>> 
>
> I can confirm disabling CONFIG_COMPACTION and CONFIG_MIGRATION fixed the issue for me as well. Fun fact is that I started looking over these options when I first raised the issue, but then realised that evl check did not flag them as problematic, giving me a false sense of security ...
> Without knowing much about the internals, in hindsight it makes perfect sense that the process was more likely to fail early on in the lifteime of the process and/or of the kernel than after it had been running for a long time: once the memory layout has settled, it's unlikely it will get moved again.
>
> By the way, I was thinking that replacing an in-menuconfig warning (a
> la Xenomai-3) would be nice to have, instead of having to manually run
> evl check on the config file.

Actually, we want both. Some automated configuration process may not
give us any hint loud enough, a runtime check is always welcome,
especially when providing support.

-- 
Philippe.
