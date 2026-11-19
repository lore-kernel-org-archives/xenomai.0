Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115260;
	b=cOVv+EF3KWujYDRek18KtGoRaPZLz08aO19jM6t+mALX8+Y3ME2An/2Ss/QcvFkgthrI
	 mXcpSN9Dns/AawPrlb03jt7Kx6DSqymgs/U5PBeTKTptCQjkDJ5DhwFUT27+g/HRtKbSL
	 WU8Yqoc1cz25VoUsTTOALvffL6flVTc6op8yW1lnGtMtjEmLYqglh7RCnQGoxQpeRHO7k
	 dzSTxC4u7uwUaeGo9WQfByq/7CmhEU1HXfS9xrSMWecGlnJz7R7lcnNdHJhyMIIzZSy57
	 rXczdqdnUFEan4Hvtl/8pGiLCnm7IB0M28w0sd8zOQ92ofNNch9jaLczxZytU8WkDOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115260;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=prc98a8BFxlKFRWU+YyYTqqUm2A40DaqFEUJk/TdQQI=;
	b=PHmodz+bQ8FRiftOIb/FhJHjnK5Nep6/W1DixHOBL+peIWmBjFEOycX8lwJhl7SbE68A
	 XxzZkjROLGMikBNwddCLRW8wHfAaumTz5ZonfPN9OLFHGlKgAp9BR3KcHBWSn8L+fcvLm
	 e9n2vGq3NC93DvDEOGmeqiPQlnv/bgGPi1y7+HHChGIpxGNQkyuDroSyeTS4oodP2TVpX
	 nLZANsAZCtYIdStxeLV+vlKt5U3TkgkTCDYWicRhZACVUZ1Z+XbhOUJT/Nk/+PpvRSG9W
	 RxWlealtgPGtrKONZYuSZcsf8XeggdvR/0ah1VyUOBatmN81Mmk/K3e6PBE3Gt/RdKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=KLG3CzZa;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E50606A8F8
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 19:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E50606A8F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=KLG3CzZa
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57C933EBC0;
	Thu, 19 Nov 2026 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795115250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prc98a8BFxlKFRWU+YyYTqqUm2A40DaqFEUJk/TdQQI=;
	b=KLG3CzZaIH7Z0qpvmifzGr7LMoJht9SbIIWlWRSO3zCzovi2/+XHhGppuxueW6hyY3gOiz
	8bhKkHvIjisg8YEkI73UGsSj+5nMd0SeiTmnFizljTJ90SnuVPPFqfXPyDYNJ3jsuPJZhX
	FB6KR+hlQQVznQZRkMCjQGxdA5B3AbaTaRQ4Tgn2gWJDipQJTCt8/AqzoGpvIrCn6Iuxis
	X5dash7jNxq7pRBkQBm6n0dYc7aPALAhwYKx8uc6cvDiJb3pQC9tRONLvSyJKZLl4MFpLw
	R+FVKCj2BX7bY7lP1qKoVVZNUme1Mk1nYF1hoGi88K3/nqFdePi0u4D29LDD+g==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [RFC PATCH dovetail 2/7] dovetail: trace stage switches
In-Reply-To: <4c0e980d-32d8-4b2a-b369-ecfb6f190f9e@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Nov 2026 08:40:14 +0100")
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
	<20261110180847.633167-3-tobias.schaffner@siemens.com>
	<4c0e980d-32d8-4b2a-b369-ecfb6f190f9e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 20:07:29 +0100
Message-ID: <87bj7kod1q.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGyCu3fJd6H8Rmbz/rEcqe+LHqsAFNfd6wyXp5C8bFM0f64kpLNye8nmDHgTrtU+JpZqZULw1fE0mMxVZkdrVJ8kBoCHzfV8Im0NNQierhWDO8UWScTCXiszEIM3Q281HNWLHyS3r5WW+8nkF3cJqB05iBc0dVXUG4g+z9o8dGcE7Jr5y5o4RAEc/wBp93q1syObLw5Hy9W5h6CtFz3RUaVHKoOTf//NZACDP2AWLGlS8QEaCfVHcLSNCjGhFRTbQ73jrB3w2nYL8OWNrohd68NWxRxaysw7xlGj3rFoMzIJrVLfW0LLWTb8ar9SZYdaBEpe5sd2SpnHeGky5Xaay2jm7pYWIn48bATfBMtKJJes5kwH3RStMvpUD2tSXSAtOwWnmT6GwVGRx5sRPixBBbGY63jNeJM66JO4l5HA+LPenae1f9ovOL423ws5xuxXFF2xqftMn+E2QD4boJwkiy705rh3nVawv09nNk1i1Lz4EdOl1F27sXPVyfqLNGH/Vh4Ya5QmCsU33exbm4wZiSsrZPXb4dAP6DQnYFdrP6k5GpNjXtfW+fHf2rjPetnYooXUf3pRR+Lsv7mHZ0LQ5aFDTHjKgWPI5Gxi3tSa1MVyR4jCBMSQAtIU5plcl9Barwby0EmjRwne1TivtqsmuWycmNKrUZsQsJYqC29JCHHjg
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 10.11.26 19:08, Tobias Schaffner wrote:
>> Add tracepoints for a task leaving the in-band and the out-of-band stage,
>> for use by the Dovetail RV monitors.
>> 
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  include/linux/dovetail.h        |  9 +++++++++
>>  include/trace/events/dovetail.h | 23 +++++++++++++++++++++++
>>  kernel/dovetail.c               | 13 +++++++++++++
>>  kernel/sched/core.c             |  2 ++
>>  4 files changed, 47 insertions(+)
>>  create mode 100644 include/trace/events/dovetail.h
>> 
>> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
>> index b41ea0f8fc4e..5ab07e69152a 100644
>> --- a/include/linux/dovetail.h
>> +++ b/include/linux/dovetail.h
>> @@ -18,6 +18,7 @@ struct files_struct;
>>  #include <linux/mm.h>
>>  #include <linux/thread_info.h>
>>  #include <linux/irqstage.h>
>> +#include <linux/tracepoint-defs.h>
>>  #include <uapi/asm-generic/dovetail.h>
>>  #include <asm/dovetail.h>
>>  
>> @@ -163,8 +164,16 @@ void dovetail_stop_altsched(void);
>>  
>>  __must_check int dovetail_leave_inband(void);
>>  
>> +DECLARE_TRACEPOINT(dovetail_leave_inband_tp);
>> +void __trace_dovetail_leave_inband(struct task_struct *p);
>> +
>> +DECLARE_TRACEPOINT(dovetail_leave_oob_tp);
>> +void __trace_dovetail_leave_oob(void);
>> +
>>  static inline void dovetail_leave_oob(void)
>>  {
>> +	if (tracepoint_enabled(dovetail_leave_oob_tp))
>> +		__trace_dovetail_leave_oob();
>>  	clear_thread_local_flags(_TLF_OOB|_TLF_OFFSTAGE);
>>  	clear_thread_flag(TIF_MAYDAY);
>>  }
>> diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
>> new file mode 100644
>> index 000000000000..785a653252d3
>> --- /dev/null
>> +++ b/include/trace/events/dovetail.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM dovetail
>> +
>> +#if !defined(_TRACE_DOVETAIL_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_DOVETAIL_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +struct task_struct;
>> +
>> +DECLARE_TRACE(dovetail_leave_inband,
>> +	TP_PROTO(struct task_struct *p),
>> +	TP_ARGS(p));
>> +
>> +DECLARE_TRACE(dovetail_leave_oob,
>> +	TP_PROTO(struct task_struct *p),
>> +	TP_ARGS(p));
>> +
>> +#endif /* _TRACE_DOVETAIL_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
>> index da4016697b67..98892f0a63da 100644
>> --- a/kernel/dovetail.c
>> +++ b/kernel/dovetail.c
>> @@ -12,6 +12,19 @@
>>  #include <asm/syscall.h>
>>  #include <uapi/asm-generic/dovetail.h>
>>  
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/dovetail.h>
>> +
>> +void __trace_dovetail_leave_inband(struct task_struct *p)
>> +{
>> +	trace_dovetail_leave_inband_tp(p);
>> +}
>> +
>> +void __trace_dovetail_leave_oob(void)
>> +{
>> +	trace_dovetail_leave_oob_tp(current);
>> +}
>> +
>>  static bool dovetail_enabled;
>>  
>>  void __weak arch_inband_task_init(struct task_struct *p)
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3ec77a682c4a..b2ad0ab0626c 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10689,6 +10689,8 @@ int dovetail_leave_inband(void)
>>  	 */
>>  	if (likely(__schedule(SM_NONE))) {
>>  		arch_dovetail_switch_finish(false);
>> +		if (tracepoint_enabled(dovetail_leave_inband_tp))
>> +			__trace_dovetail_leave_inband(p);
>
> Why does trace point have to be conditional? Rather unusual.
>

I guess that the upside of having a static key to fully skip the
tracepoint prep dynamically may be wanted here. Granted,
dovetail_leave_inband() should not be on the hot path, but we are
nevertheless on the switch tail path to oob.

-- 
Philippe.
