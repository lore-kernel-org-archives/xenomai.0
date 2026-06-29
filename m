Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAE1F0E25
	for <xenomai@lists.linux.dev>; Mon, 29 Jun 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741390; cv=none; b=I92NGAN+zBeRWXe1WRoWpk8uBpNsnNfD37HSXkAs6F+d+DCECOoNHIbVxW4a7UJal09NUDMQ++z7BvuyDZfpTBWdF1p8scbdX79dByJw+ObK22DT5a81xgdOYvjoKEKbrFaoKmNJZAqXiMwESLtKNnXYVtJLKrn04+uqWyUKru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741390; c=relaxed/simple;
	bh=JwW718SrPkBT1Haq9LZwkxrbnuzQEGOOSPS6SAxTBGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ml7QCGiwWHI8AXmK+eONZqjE+2Ci/pr5E2KJMc9jM6PeVWwbFLQHt1Tcj19PipRl2LU4p6caDGViq1CDtrDpVqB+CzeAEBNgdpGCRn7v4hJoidiEt1nYBaF1Q1KVQgpJOIYoVyvnXmrnSBp9lx6mKMEBhoekXyK4T1ecb4XQg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=d1nKpIrO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="d1nKpIrO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C45C63EC69;
	Mon, 29 Jun 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782741381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGa8MseEpx+QQBvi9rBGZUBElat8BvT70bQC5RnnWUU=;
	b=d1nKpIrOD8ZMDAqYXDOECynOFy0cu8B65IAjhAP0N5aHkzWaoaN+CtyAPFymETFRV0SW6z
	6DAfLXzOGrXsPD5Q4/ZqmlnououwvzwG8xqeZJ2rPdfvZ0OAtgMRV7e9+0qyPvnaaJjaWF
	JnOkL9FUQ7FfOVLmDtRmm2KA9L46cVz/qnKqGm4zaky86F4vJfxQnYA8DIbAG8OY3gQW2p
	3Hlykj4QuXdejM8nAcGPzsE+BSrNWHjvhAGO51HDR2QhGhZa9oAsUAilUib8H1WBpEC+gU
	1/naTGVsK+FI1VzJiyq41cusZWJYsjFl6CD9fZ7q5PvBNVQuDB+yBrS88R5v9Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: guang_feng_wang@163.com,  florian.bezdeka@siemens.com,
  xenomai@lists.linux.dev
Subject: Re: [PATCH website v1 0/5] doc: refresh Cobalt installation guide
In-Reply-To: <832ca94d-d8c8-45d5-a8af-3f86baf44e1b@siemens.com> (Jan Kiszka's
	message of "Mon, 29 Jun 2026 15:36:28 +0200")
References: <cover.1782585785.git.guang_feng_wang@163.com>
	<832ca94d-d8c8-45d5-a8af-3f86baf44e1b@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 29 Jun 2026 15:56:16 +0200
Message-ID: <874iiltpq7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTF2sIt6a9gDPzU5ToYky7lflITQBVAhMqorEUiTK9nf+UT4SsvsMUEXYgCtyfMXvB2vbGDRnxNJPDqYq4wQdUqIUrWhX4sjaA6AnCLpilVNEMYRno+faUilBjipYZc6kpJDJJUv/BoXY1qK6tHH1iRiC/QFh6KP0klvEgSo0j/MAB/NWs0v+oK6oCjNFtxani2JGDaBT8RNdljVcpmxh95GqfOPipTEpIZ4GstZDSSluhdZE6ttIxC5BYhm3kn4fjpsQ5LI4u+lM4IUmzgIjW2j539FVFPoiSIo6y2ThKBACNQdB5++SOBG1gHaasDmGYVs200K22Wu0/GWHFvR/cg+QE7DAt6k/yti/3O9xzDOxATRuMEXqFEAghxP/esL6EGXiBennKfBS7OFOfz5o/Z++wLRwWciwDSeSZkNWY59E413NpY1KUCspkWdE0OaoIL8DwTTzcsue6phQ2yo98+rYiWRVPEgMaEe96aCrdDYBdT0GODqycH2EUJT4V+BsKEbbdYCKfnJZDG1eBC6ntwEgfDvNreLduzJSUlzsTp/YT1GFl5vfwZ9wn4YohC8dfEpNfq1eKvROTybqHWdBKjOuuNtQAWYpWgWTQTj/BM+3qVkaqGuVXlF/m+tG0w9XlKj1c1ud66pYzJ4t7+cMfDqFhF1fg7gdy4qgxagn0fsKg
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 28.06.26 06:50, guang_feng_wang@163.com wrote:
>> From: guang feng wang <guang_feng_wang@163.com>
>> 
>> Hi,
>> 
>> This series updates a few stale I-pipe-era references in the Xenomai 3
>> installation guide, mainly around the Cobalt setup path.
>> 
>> The page already documents Dovetail as a Cobalt-specific requirement,
>> but a few examples still refer to legacy I-pipe references.
>> 
>> The changes are limited to the following patches:
>> 
>> guang feng wang (5):
>>   doc: replace legacy I-pipe usage with Dovetail
>>   doc: update stale Cobalt kernel preparation example
>>   doc: mark old PowerPC and ARM build examples as historical
>>   doc: generalize ARM64 Cobalt build notes
>>   doc: update Cobalt boot log
>> 
>>  content/installation/_index.md | 39 ++++++++++++++++++++--------------
>>  1 file changed, 23 insertions(+), 16 deletions(-)
>> 
>
> Thanks for the changes already!
>
> I just realized that our repo is in some limbo state: Philippe, you once
> worked on that "v2" branch, IIRC to update the hugo theme. We never
> merged, and I forgot, why. Do you recall?
>

Lack of testing basically, I think. I applied the changes required for
upgrading the hugo+relearn-theme combo like I did for the v4 website,
but only tested the later.

-- 
Philippe.
