Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34B383C70
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153038; cv=none; b=kjcUh3aIZtOhr5qpzalyPeFvM04uK7f4MblSzlSIBAi7+jooDqffhpuNsiMVXqVmSiER6ScULoksIakki8RUgS9ja+RbCBZ25U0jTZhj2rEXOOvqU9VqttmLxZ13P0bFlI0UKphzk2jwRJTocNm7YZ9nuKkJ5pCmnjFe391ji28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153038; c=relaxed/simple;
	bh=8aZ+8TLbyFqPNVfo8ZI29Oxe9tkGrQ+U5uvkpl6Dq/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2TX0aOtrH4Y5z+CUGeSqMNQ3wcJxPsCEh72kj/uujC9zOQBDKEjHFMzdfQ+ISqJr/odXqgEin8Vnm2Rm2YPFsVh2+tmq8ZXTW9Uzcvkdl2ceMIP7ZVlVJYO9m6PrJU1i8eW82CJkHXv7XGxmYWYAxDqFhLDjpPcRet141loujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=EA8AnxQN; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="EA8AnxQN"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6A47D581813
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 07:42:24 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44F753EC7E;
	Tue, 14 Apr 2026 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1776152536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwXbtST4qbYpeahSe5oLq2ROeDILjGkmP2efJHiiyL0=;
	b=EA8AnxQNN/b+eNmgBYEaAoj51gl0jXnVaSuFAAaQTNMt2k/tqBROWAKB1CbF53ximTzC80
	RFfIFSeM1d1tDjMlOuqcetcmW8nba/UTSrPWIEroFG/U53sGtIlOiX4ajqQdw+bebudJUM
	BJeP6ZSvUKU4zS0j77o0qdPFyRDE+YyhP2jK6pe/uPhED+viV4YpDMj2wxGSBd4mirFtSB
	tTUTeZuZ2PNsfrkTU5t55ur7+tNjtZ7uPd4gxw1u8rknsDmZ6OvTQgaPMRyTuFkDkyPeZe
	eOJDs9x6uiAov1D8s2Z1VJfC4gRc5w1+Cgal4fRDswtKQCS8O7urto/iijy9jg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Brandon Ho <brandonho667@gmail.com>,  brho@relativityspace.com,
  jsridharan@relativityspace.com,  xenomai@lists.linux.dev,  Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
In-Reply-To: <e31e14a3ff9eb52ff8db44f23e3a5a5ad29a490c.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 14 Apr 2026 09:37:03 +0200")
References: <87v7e8yzhj.fsf@xenomai.org>
	<20260413181929.1801013-1-brho@relativityspace.com>
	<87h5pe7lvg.fsf@xenomai.org>
	<e31e14a3ff9eb52ff8db44f23e3a5a5ad29a490c.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 14 Apr 2026 09:42:15 +0200
Message-ID: <87se8yyomg.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEL8W+IH1+0Ytp31zjqE4bvQA68Su2vbWEx2agKE6RN1Wz0JgI7zmy7T/09PDVLwKXtx3GCVBglv+8H6fDa6GSIo9uf6HGO+pZOE6oMGnEzTRsenxsE+Bcpvpk1bC/lcXor3kcHMGZIzxUW+LOT8szo1VpTuEzCci8YBNHGnBnmLGNh3D1JkZRS354ozIzGaMU6qRyD9eKG4Thf9h+l0sndgRB9JRjoyM/6xH01zrNfuk7U7vm3je82WvbNBDYUeMOt87r+HPfSzP/vV70hEDQ0dKaCGQTHtsFzTwKg8llAdwdTffwM1zYOo79DAJ5D+kDcpq6SyeALFsoN8V2MIV9dOcJTyLgByavsIgOROE3TIvxJ+O3zu+32es0Z0Ep9dbqVpeGYHNe5XoSLSMdSlrLsRnuqgJ6o5+Eu6BgtjmPkLs9zMTAgzbq/xPyAzsc0+racpJEmxEf7DKf8ApQtIzwNPVJEMNrAiFBeGXP8TOAGV9vZSlnDN+s6PX6RRwuqd2ZEI/dXaD9/i7UsspypUMhm6O7FNUqx9bcgq6Z8Luv/iYeKRglTvMHbNQrWpWrFw6yNWVSyDErzpliNFWzEUK9aQooP0jvdDjBLAKTrC/SpSeBHLh+Z8eEhqZ+BzSdwUrt9sGUZU2IfBMeXbReq7Y8GUbRfL0FAc7/83twEq2d37g
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-04-13 at 20:31 +0200, Philippe Gerum wrote:
>> Brandon Ho <brandonho667@gmail.com> writes:
>> 
>> > Thank you for the responses! I recently came across the
>> > `compact_unevictable_allowed` sysctl option and it seems like it could be a
>> > good fit for our use case. Setting it to 0 would prevent the kernel from
>> > compacting/migrating locked pages, which should eliminate the minor faults
>> > we're seeing during compaction.
>> > 
>> > Could we possibly set `compact_unevictable_allowed=0` by default when
>> > CONFIG_EVL is enabled?
>> 
>> Definitely, yes. Thanks for chasing this issue down. This patch is going
>> to be merged upstream asap, you may want to apply it for a preview.
>
> Targeting linux-evl or linux-dovetail?
>

linux-dovetail, this is a general issue for any latency-sensitive code.


-- 
Philippe.
