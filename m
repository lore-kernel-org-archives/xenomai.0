Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77E3AF65A
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494329; cv=none; b=DQHr8M1gZE5EmhTs/6c2ribEHCI5GjfmdBsRRfmP8mXZwqTP5S87kTSSXz1lBS0rC+uR6HQdyZCVNCObDGta6MPWt9mzJTtlUkWz53qQr8rKseLOB4knLIulUIigXsGNc1F7OeBCYGc13LE+7N3sQ1fiGt9FRgg25+a4PNraRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494329; c=relaxed/simple;
	bh=MDJmJLe+FQXsSFGa8Zgb4SY/DRp3ZKfzPCTKoiAKrrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HkqHxZMagsenECdZFi5wZU5PrQ5WefdptsBsjR/pVwRvNzteYzvB46LnEw/HO9NYVWVqKB8uoEFLuYb7lBlj2POIn1g0MNKo3KSovbm4MVAFVr4zRecbVlt1OyVk03btJ1xhL1eRO1B6hxB4kX8KvkVZpF21lrgMKe4YDshioQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bB0IgNVa; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bB0IgNVa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83E1E41B8A;
	Wed,  8 Jul 2026 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783494313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChKPew/BMXRWrDr58lxT2Xyvyn0EPihLJh/mLwUx2mI=;
	b=bB0IgNVaiFyCF5rDP1kOO4K7SP1yFEbZ9ILNQLOaSXvqEiqujf0/ZWirsqA+ng+Ww0jUOf
	CwPbIXgYhrR1cyyTbaeCAJ3/G2E5V2SuDsscf5yKD4Br/f2U8Y3rCKOXMPyQ2dF0wko1/4
	It6d8792sKjMUJciXKB+51wG2GPiZdgVe5wa6TDQL9DqYamzy0ot3D9OC088Gjzc47ED4K
	hfRfG9/uN8rEUQLeM1SVXCTvhjZSLsKTxwjDgY9SQs3KY3PLjOGIgydeqdLFKCE6KH6O99
	MRvm8m4LfWSKw4tDf/g5hFdFnSQGekbtdAD7YATvSYeYP4835HHoaLruwBzqgQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  shannmu <shanmu1901@gmail.com>
Subject: Re: [PATCH libevl] build: add initial RISC-V support
In-Reply-To: <0b476df7-81b6-4fe5-861f-8056c62266e6@siemens.com> (Tobias
	Schaffner's message of "Wed, 8 Jul 2026 08:35:45 +0200")
References: <20251009125736.3520623-1-tobias.schaffner@siemens.com>
	<0b476df7-81b6-4fe5-861f-8056c62266e6@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 08 Jul 2026 09:05:08 +0200
Message-ID: <87bjcim063.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGWJemSe+E8UUMXH9YFvUT77fOELueXLcCWfcqvHfFjbJHutRBdpyLptrosUpdeEcycR5Ebep/tW1rIzSHm1Y5jxpQXlPOHZb8dJIQjs5knr7lyWKc4ARWmZsj7UcZq0tvHJNiSc6ewdf3OPV1/dXi8y0KtWefErpGvP3FZM4EsQ0sWW18yE8n6wu7InPzz2Ny2LVx2pbVm+6PRsLh0mtYbfighTgYIOT4clWCNDau7sdv43FNzUPsDsjK9umevxe/BtrGSleLsHtYqqaJftJlyDz26JYymUMhhpinR9CDChxvl9NAmDPbZ23WT/xJKhG1j3Xi/Fxw93wrQni8/BUp6J1YqWHR0MusEQSrTa6c4GZQmJswNh5wPELsewZL2JBNU9cL93/6HEJsZJqvHy1I36ak4MF5EkBJjlgTYkqPy4SIlo/KL2Bi1quD8qJqWVavgxac1cTcnXFAHY2wjBAqeNdz4H62Op1iTwG5WT/3kimEPhQ2HOVx8WD3EgI5rNwDXbkR6qcWQahYnTwGcPGjI5PxvQ480f/rfyDnAZKrgySlmo/PBMj0BYLGWpVPNGk4v9sZVakyDyytUoM78QgtNODvOEjTgNoFRLTAf4ClrBHUQCF0k5dyC8W3WegjLbjzX/9tOhyn1AT+LkW56hsorU3DjEJ2gLhpJLLm1zYnOEg

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi Philippe,
>
> On 10/9/25 14:57, Tobias Schaffner wrote:
>> From: shannmu <shanmu1901@gmail.com>
>> Provide the basic build infrastructure and VDSO definitions
>> required to build libevl on RISC-V.
>> Tested-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>
> is this ready to get merged apart from a missing Signed-off-by by shanmu?
>

Almost, but some solution should be found not to have the hard-coded
path below:

>> diff --git a/meson/riscv64-linux-gnu b/meson/riscv64-linux-gnu

>> +sys_root = '/usr/riscv64-linux-gnu'

-- 
Philippe.
