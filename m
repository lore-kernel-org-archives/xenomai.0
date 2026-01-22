Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D442BD035
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112231; cv=none; b=EZIbKshNrD/VWwT6FNqWxiBwAEjsRbpMEBnDf/Z0rTivKaiWjSK3Bc0PEmse3weFoWbZUrBrAJEWXXXK86CwIjJO4tuqZEK7FTOuSoQTNWk3BuH1n2KSxfSpGgP+GYSfZ4ZHucDPNKqes+7czqYN0MOruUq+48/plVdMOlW6mlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112231; c=relaxed/simple;
	bh=8MvYfs7Gybpoh/TchwIOjv+QmystG/NL7Q74UzfoMAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P83o1TN/E9V1HedSzSx5UWC6O7NqeG8QUTrNLopnLd15ZxLb2ya+pGxDLUZC5mEvl5uVXMj3784qu8MazS/54lg+62bx8M1v4ohvQ4XValfoE0bASw5RtnAGeX94me6Iaj8n4C4reryNVfga4ZbHBoz15gRcDEaRYhoBRexyzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=SMV1Qqzd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="SMV1Qqzd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB76A44301;
	Thu, 22 Jan 2026 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769112224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdGod1860llBxSMcbJSlNa3AetId8LJFQkKVzVqIdoY=;
	b=SMV1QqzddGvEpRaOOMbdCUReEYXCPYTXK+DHbGy3JQrdoeQrNkmVFM3C22ZKvR0zFh86y1
	xHAegFP4fuk20x/drENV72VjTmhPbUjqPyL2/D8EbwQd+3mKKzxt53lamgFI/QX974DeG2
	HdASUpReb0HDc5Ub6CRwF9yN7aEgnlhXKFh/IKQUaaIlHTYsXsOL/xjplZP5XoMe/IFxDv
	blhb0Znwge6+PFnzsVgA6IAwQT+HU4pjdX3f8lTWBcKytguB00ejY3nytWwMrcxRF68gfT
	GXKx9VpLpJooRTH0Tx/tNZs3s/ZQpffhXmi0p9w3MT0M+M9syTCJ3nplIIjEdQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic testing
In-Reply-To: <fb746056-3527-4ae9-8cf1-dfc946118fd9@siemens.com> (Jan Kiszka's
	message of "Thu, 22 Jan 2026 12:56:17 +0100")
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
	<c607f371-4c22-4e27-a70f-6b7b379609ef@siemens.com>
	<ec542b43-9ddb-4211-b3cf-73360c0441b3@siemens.com>
	<fb746056-3527-4ae9-8cf1-dfc946118fd9@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 21:03:43 +0100
Message-ID: <87y0lph0tc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepveeujeeiteeggeeftddupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 22.01.26 12:09, Tobias Schaffner wrote:
>> 
>> 
>> On 1/22/26 11:46, Jan Kiszka wrote:
>>> On 22.01.26 11:39, Tobias Schaffner wrote:
>>>> Run the EVL test suite for some first smoke tests.
>>>>
>>>> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
>>>> the moment this is used to disable scheduling quota tests that fail on
>>>> virtual targets.
>>>
>>> And why do we disable them?
>> 
>> We only disable them on virtual targets not on physical ones.
>> 
>
> That is likely also the answer to my question below, right? I missed the
> "...on virtual targets" on first read.
>
>> These tests are expected to be unreliable with a virtualization layer in
>> between possibly causing delays aren't they?
>
> So, the evl testsuite is missing something like a --vm switch to relax
> timing tests? Would it make sense to add that so that at least the
> functional aspects of those tests are kept?
>

Yes, this would make sense to do that. We would still have to apply some
voodoo heuristics like in x3 to figure out the success/failure pattern
in a virtualized environment though (e.g. how many iterations could a
SCHED_TP thread execute within an allotted time window of 1sec, slowdown
included?). Maybe some calibration work like this already happens in
sched-quota-accuracy.

-- 
Philippe.
