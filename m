Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47271B1D75
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027109; cv=none; b=kBNsGSFbT+B+k1y/miYDyELyOcAzmuGKVUIDhon5d6YeUiGvsErb7ub6n9TBYCKRthG9Ke67/R1dWTY9Z0COcCK3OGNo3gAQlN91gT43xbXMYEoVsXAYXTO0fspmLohC8w8Y9uylscIs3p6m7NxbfWzfPzZjDNdhv1SBsoyR/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027109; c=relaxed/simple;
	bh=fxGYp0hxUnntftPZCwMlJLwIbewRt/lClGuKc958bgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POTdhvRp6U0O1avd9SUiS0IxrNZUfQvJghfFQDizhoVYU6cn6W/0eaNSfzOqUxx+i6kBHHyXnMalr1/Oh3sAg4eFvYKbsvEPzt7xZs3+nrUVASSU+0WqHjVYMWgGJTmFComtKHF1dZF/mpukbWzVm+ivchaTOb5yoiFPAExeqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Id1U282X; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Id1U282X"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240830141133a534f0c64342c27e76
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 16:11:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gueRGytGl+ovIHXsuKZvouW9HsMz5TQq0faDH0DJO3g=;
 b=Id1U282XMeEJZJi0lc85pbpfEUeR1FMOK/Wf+GU/m4VGV41WcvpEcLVkPr+fztX31OXtHw
 zIHNQf8wYhE2Di4auMmAMGRwp9y4RYCD/imMJO6or6DTYMLHpWHW+49nUiu8iEOA3ks5gtLY
 i2VaASoojxLt/upMtZp8RiqaHpjAua1mE+0UyPTSk8eW5cOQ2P6gOKxQAREasLfPvBy2uU5d
 vKFU3aDXwA3iQxnAW9LaMKaTeeFq0ZRvDSHEGu31D9dhh64/YHdoXjlq4mC8KSD5JR8RAntc
 pssJVN1GT5VExGmhqYZ2HuP63+WwTVOzpODLj5TeHbfHRQC55qR5iaQw==;
Message-ID: <d1a91e045f291254222a61efe7a99ab8de475ff6.camel@siemens.com>
Subject: Re: [PATCH 0/3] Fix races in thread relaxation
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: JerryJun <jerryjun123@163.com>
Date: Fri, 30 Aug 2024 16:11:29 +0200
In-Reply-To: <cover.1725016413.git.jan.kiszka@siemens.com>
References: <cover.1725016413.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Fri, 2024-08-30 at 13:13 +0200, Jan Kiszka wrote:
> This should resolve the issue reported in [1] and also clean up a bit
> more of our now obsolete pipeline abstraction. Test case is planned for
> later.
>=20
> Jan

Tested-by: Florian Bezdeka <florian.bezdeka@siemens.com>

I can confirm that the reproducer for [1] does no longer crash.

>=20
> [1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78b=
b60.camel@siemens.com/T/#t
>=20
> Jan Kiszka (3):
>   cobalt: Move relax related lostage_wakeup work from stack to thread
>   cobalt: Drop obsolete pipeline_inband_work abstraction
>   cobalt/posix/process: Sync on thread-hosted irq_work items before
>     exiting
>=20
>  .../kernel/dovetail/pipeline/inband_work.h    | 28 ----------------
>  include/cobalt/kernel/rtdm/driver.h           |  9 +++--
>  include/cobalt/kernel/thread.h                | 10 ++++--
>  kernel/cobalt/posix/process.c                 |  5 +++
>  kernel/cobalt/rtdm/drvlib.c                   | 15 +++------
>  kernel/cobalt/rtdm/fd.c                       | 13 +++-----
>  kernel/cobalt/thread.c                        | 33 +++++++------------
>  kernel/drivers/udd/udd.c                      | 12 +++----
>  8 files changed, 45 insertions(+), 80 deletions(-)
>  delete mode 100644 include/cobalt/kernel/dovetail/pipeline/inband_work.h
>=20
> --=20
> 2.43.0

