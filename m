Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED31DDF6
	for <xenomai@lists.linux.dev>; Sun, 17 Mar 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710129; cv=none; b=oEiZYUF37baNZCACHyqkzWZ+9Tw+tSkjC+RuClfiCeMjXv6CjylTBp2DpVmNCRysOAj9JjegBxktdWsBni+5Gleruz0dQAyazgvjEMrD2HRKASNPBLpRN3LgMuMU3+vsLwlpfLFt8GcShNKoFPvFruT4zYMbRQUA7XsY5BbLlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710129; c=relaxed/simple;
	bh=ei2GdAv1VCrv2uCvOazXecVRyYFrXEmeSSKKCiOToQA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=og2aUgtfERaVRcSmS/aDTNS7coKnPphlhDGxVxV9TNN1P/jtvUNbJEJNo4PiVEgUauuZ1Jpvw2QE1KCIdRlqyLiubJanZ/AUPHPO5Sfi2NUHKSSOTMGdeuw7z+tVlrYbSL2sETaUkZIoq0CHrUqRSqXJxsy/KjqZGndIRjVPCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34169f28460so415092f8f.2
        for <xenomai@lists.linux.dev>; Sun, 17 Mar 2024 14:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710710126; x=1711314926;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTjENLpp1ML2YPEcoUcM6hJAw6Oq8mqbfCQOoGzwCX0=;
        b=Du/7jqcxzVxeGNWll5S4oQSur9krzLysmt/xyJ8YNpZoW208mPan9I46Z8hmVsPnDb
         ze37zPDsThQCl6NaJvYrWq65Y+j87PU6d0LHMjNy4upMVxK7tG0IZ9j2uLymzhkc8f9o
         1K9Qvdmzv21uCS4d+LtVpHuLYWglhqm8bMuH7+sTOHIFwNoY6zwiZMNtpLOc70q7IbSY
         7EgVMY4WaWZjo3siQpy2/Ti8ir/aM85IYOPvBSdHnmLJFoz04hUqDpzuCIsnOVqIQP2v
         lI7S4OBZyuQGQQ0ypO9sgfNqw6dBTXVCMOUhXK2ijoi4dliYHe/pmbcJwUtiIUDgpHLb
         MvHA==
X-Gm-Message-State: AOJu0Yzko9vbudY/SPU9lHSpsNu9dXT0pBEa68IfT7HEx+2ATVmMl+GC
	RF43C3PHQrocPDk5tnbwyF7NeDq71KHlS0FZ8kq+geY46Ml0c8qNTnqoRMS2
X-Google-Smtp-Source: AGHT+IHUhN22PsXabujCLM9Cn9fXbCHauM3rG/kda4yAO1tUYy1XjR08rmUCd8qTmfGWNPCAB86LFA==
X-Received: by 2002:a5d:5005:0:b0:33e:7831:8f69 with SMTP id e5-20020a5d5005000000b0033e78318f69mr9669047wrt.32.1710710125304;
        Sun, 17 Mar 2024 14:15:25 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b0033ec6ebf878sm8205428wrm.93.2024.03.17.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 14:15:24 -0700 (PDT)
References: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
 <7023067c-956e-45ac-b8db-7710ff53a001@siemens.com>
 <877cifwx8x.fsf@xenomai.org>
 <7d95d478-2f28-4ecb-8f59-b59758a20597@siemens.com>
 <87il1stpd4.fsf@xenomai.org>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: dovetail kernel maintenance
Date: Sun, 17 Mar 2024 22:04:00 +0100
In-reply-to: <87il1stpd4.fsf@xenomai.org>
Message-ID: <87a5mwa7br.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 06.03.24 09:41, Philippe Gerum wrote:
>>> 
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>> 
>>>> On 21.02.24 19:30, Jan Kiszka wrote:
>>>>> Hi Philippe,
>>>>>
>>>>> people started to ask about updates for our kernel trees, and you
>>>>> mentioned to me before that you would focus on the last two LTS kernels.
>>>>> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
>>>>> then also in 5.10 (all referring to the -rebase branches). Before taking
>>>>> over 5.10 and 5.15, I would like to clarify their state. But I would
>>>>> also like to know what is delaying the tagging of 6.1 and 6.6.
>>>>>
>>>>
>>>> Gentle ping for this question.
>>>>
>>> 
>>> Well, my posts to the mailing list from my usual address have been
>>> rejected a couple of weeks ago due to smtp authentication issues it
>>> seems, which are now (mostly) sorted out, I thought you did receive this
>>> reply as a direct recipient though. Looks like you did not. So here it
>>> is.
>>> 
>>> PS: Since this reply was written, the x86 status with respect to the
>>> Dovetail port to v6.8-rc7 has improved. Still in the process of
>>> rewriting the arm64/fpsimd stuff.
>>> 
>>
>> Let us know where exactly help could be provided. I just want to avoid
>> duplicate attempts, so the development should be coordinated publicly.
>>
>
> Addressing [1] comes to mind. As I said in this thread, one could use
> the same logic which allows x86 to support preemption of the helpers for
> in-kernel fpu by the real-time core.  However, I have to upgrade the
> basic arm64/fpsimd port to v6.8 before someone else can handle this
> task. ETA, hopefully next week.
>

Dovetail and EVL ports to v6.8 are now available from the usual repos
for all the supported architectures. Only lightly tested so far, but
things look good (arm64/fpsimd is back on track).

If CONFIG_NET_OOB is set, there are some warnings about missing function
declarations in the net/ core which are now turned on for ARM. We may
have to live with them until the generic changes required for enabling
the UDP support in the xenomai4 netstack are merged. Significant changes
are pending in this area.

-- 
Philippe.
