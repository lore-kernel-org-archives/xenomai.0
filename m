Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B839ADD
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379868; cv=none; b=szolF7B/Zey7b3PmdA1THMcd8bQIXUhfgLnYYDA3Y1l8ldO+jRBZ+sQq2NL/uUkUxHG+2J7UvL3eweTgPaqZakWCLjUkvwIPJJTUfJ03bNbGQEpUicQwEgwGOepbl1Z1j1kN/w8MKRijt5mShxmIMWt241szqmqdTvpOYBRzrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379868; c=relaxed/simple;
	bh=QEnyOZItDHZL5H2CKivo5hlNHONB6FkxyAX8HXta8EI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGnmMOsu9XQnDYV6DDgzxWKT52DN7cRV1WS47vEkAX7ZTAQV+bBVoKZ+xe4W0bztcYmsT2phiiDcp+4GOr5549Y4Y387k1li8obNLtL98yLu+ShNtFl0l+jTWY8/T2H+NpFC09HnuEOh/neMuxRJk/brWey1WbXY8pv5dIwFm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb8cf8a5bso42086505e9.2
        for <xenomai@lists.linux.dev>; Tue, 03 Sep 2024 09:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379865; x=1725984665;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZlVMOseGdzJD55eMo8KbESHCM9Vf+ExR7qkhh+n0Wo=;
        b=coOHVsQn4E7HndTp5iamirKKa091yQLzoqjzyRnIPrhj4sMz6rnSjYhCfCCLDpqCNn
         5hodO7SUSVCTXh2S6uORMnW77h0tvxd7AAF3475zuhrzbsuTPCtzeC8yID2FuTow6qK9
         wneW1+vqEeqFK7JMbA4lq35qCPnzCbcxPehha90wxLgDaXqnm7Nel/8nK4r8mC8GSV8e
         Omhx6YRysvhxOFkAsnEgHBvPUrxj8WKxkl9qpYeixeqz/pqe1+6vX4s2ygzxwvyykuM9
         ooCQP6aECQD/c9G/ecf1gfYEihFt0zM2GWSSAbFJ1L313as0VrQsWIMn8GC3zMWkgrCG
         oGqw==
X-Gm-Message-State: AOJu0YwQGMJ/u7U5jbynxIIe/q3AeaQdKeYsOwSCiaeM9kCv2aQGhs21
	ccJN5gE8wwp82o1M0Lhziym/svGJrwbwFlZ0lBJTi2uRtggJT1Ua8iL0Qw==
X-Google-Smtp-Source: AGHT+IGB08gRdDeKBiBeGIRCpapV20Wp2nS4rgWPHeMMinIUdx5jA8+vhsdRpbOdMxQ+d8TjgvDZtw==
X-Received: by 2002:a05:600c:4e8c:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-42c82f568ebmr58491015e9.20.1725379864501;
        Tue, 03 Sep 2024 09:11:04 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a68sm174045755e9.14.2024.09.03.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:11:04 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Account for invalid syscall number
In-Reply-To: <d80fde5d-b6b5-4c72-ad9e-ce20f2538a38@siemens.com> (Jan Kiszka's
	message of "Tue, 3 Sep 2024 17:50:24 +0200")
References: <24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com>
	<87h6ax9kwa.fsf@xenomai.org>
	<d80fde5d-b6b5-4c72-ad9e-ce20f2538a38@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 03 Sep 2024 18:11:03 +0200
Message-ID: <87zfoo90q0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 03.09.24 10:55, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> At least on x86, the kernel may have decided to invalidate the syscall
>>> number while processing it. Avoid that we process this -1 as legacy
>>> syscall.
>>>
>>> This was a long-pending issue in the whole dovetail series, now revealed
>>> by running auditd on one of the test systems. Syscall auditing was
>>> eventually catching an unbalanced tracing, caused by a premature syscall
>>> exit due to this bug.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  kernel/dovetail.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
>>> index 08c649d6e9d9..bcd49183f8eb 100644
>>> --- a/kernel/dovetail.c
>>> +++ b/kernel/dovetail.c
>>> @@ -119,7 +119,7 @@ static bool __in_oob_syscall(struct task_struct *tsk,
>>>  	 * a PR_OOB_SYSCALL command (new/current call form).
>>>  	 */
>>>  	if (IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE)) {
>>> -		if (nr & __OOB_SYSCALL_BIT)
>>> +		if (nr != -1 && nr & __OOB_SYSCALL_BIT)
>>>  			return true;
>>>  	}
>> 
>> Merged into v6.1.y-dovetail-rebase, v6.6.y-dovetail-rebase,
>> v6.10-dovetail-rebase and the upcoming v6.11-dovetail-rebase.
>> 
>
> Thanks - but not yet pushed, I suppose.
>

No, not yet. Something looks strange with one of my tests. Not sure that
it's related though, just playing safe.

-- 
Philippe.
