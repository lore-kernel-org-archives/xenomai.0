Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53059CA47
	for <xenomai@lists.linux.dev>; Mon, 11 Mar 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193501; cv=none; b=DTcGBSia4YfpjL7bpqDdFWRKgSfFKcuDGGaH6oxQLsR1DYuPg1IQHvKe0YPGVb3TzF/fGXXdCRcpDU50QRLSDK6IrEjczKRNDjq5HQyJRH7ZQw/rhicqMd9uz+fStktk/MPBkijFlWRZGh8i5fBsThzXwFDTgmMR02dtft99AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193501; c=relaxed/simple;
	bh=aTDBqc1f4ven3pLYFkt/H9xcY/toO6nxI3Y6kK5pCCI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=B497MKwavm7jYHOkRCrIZnUPeafyAjCUM5wnbaSjWbek/R/vVEi+c8EdzhvRauwtVJ3FgmbjlXFGqJ6sQ7CGKatc3v6cKSkfSnU/ESHkPaisH0JoOLhxZ/+PVzAG2CEx6tc1bKQL+/BEB04st69eFN4DJ3J2F1BabWv8K5R7Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e899ce9e3so1654698f8f.1
        for <xenomai@lists.linux.dev>; Mon, 11 Mar 2024 14:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710193497; x=1710798297;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf+4wNHU8cO/YgkhbG8WVPrYradoW2KVtEvyAXcRXMg=;
        b=faqbgCw4pTypnUX5SDQ+IYII8nWsYUBnZOfRiT3OcHHftKFXho0GOcLOrCecxEuv3y
         esWV5F+lhAEvcpHW+3++uCVB9s3k7C3dwTkdju5peu6z1qUOGNv8EzUKDXSCvKtcO+WA
         P2d4rwCQJGf7g2LX72DBMXic4UoesWoClceabJ+hUqif4KkStIcnAP5s7ewTXpdvPtIw
         EX0Mo204mWudgmon5JC55jbaHq+Nhe0fyuw7zBHHNmmwIUn4becMwREKU3771Ex5ryhQ
         IHP5BFSV6k5rsMmmEaTu9WjWMF0P4RYOcdcZzGQEgPbDMu2fYFZjWFojvnQ+dALwbVxm
         3bvA==
X-Gm-Message-State: AOJu0YzULgXQhDXfjjGflhn4N29lOgLP12b5W1FREw9liq6zJIu8WIo8
	CC+THBR8ISDIc++9bjgZtLMLHwiYlejgOP94XRBv9QVWdROkG5NrRldYpWP6
X-Google-Smtp-Source: AGHT+IHbPBOGDPGRoc/iWEZFcKfL/puOcNciQuodQ5432r/7FklqoHyC4+tFES5kDUfO1gPFU4N0SA==
X-Received: by 2002:adf:f7c2:0:b0:33e:79d3:2cb with SMTP id a2-20020adff7c2000000b0033e79d302cbmr4855502wrq.38.1710193497294;
        Mon, 11 Mar 2024 14:44:57 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id bq30-20020a5d5a1e000000b0033ea499c645sm168566wrb.4.2024.03.11.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:44:56 -0700 (PDT)
References: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
 <7023067c-956e-45ac-b8db-7710ff53a001@siemens.com>
 <877cifwx8x.fsf@xenomai.org>
 <7d95d478-2f28-4ecb-8f59-b59758a20597@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: dovetail kernel maintenance
Date: Mon, 11 Mar 2024 22:30:16 +0100
In-reply-to: <7d95d478-2f28-4ecb-8f59-b59758a20597@siemens.com>
Message-ID: <87il1stpd4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 06.03.24 09:41, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 21.02.24 19:30, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> people started to ask about updates for our kernel trees, and you
>>>> mentioned to me before that you would focus on the last two LTS kernels.
>>>> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
>>>> then also in 5.10 (all referring to the -rebase branches). Before taking
>>>> over 5.10 and 5.15, I would like to clarify their state. But I would
>>>> also like to know what is delaying the tagging of 6.1 and 6.6.
>>>>
>>>
>>> Gentle ping for this question.
>>>
>> 
>> Well, my posts to the mailing list from my usual address have been
>> rejected a couple of weeks ago due to smtp authentication issues it
>> seems, which are now (mostly) sorted out, I thought you did receive this
>> reply as a direct recipient though. Looks like you did not. So here it
>> is.
>> 
>> PS: Since this reply was written, the x86 status with respect to the
>> Dovetail port to v6.8-rc7 has improved. Still in the process of
>> rewriting the arm64/fpsimd stuff.
>> 
>
> Let us know where exactly help could be provided. I just want to avoid
> duplicate attempts, so the development should be coordinated publicly.
>

Addressing [1] comes to mind. As I said in this thread, one could use
the same logic which allows x86 to support preemption of the helpers for
in-kernel fpu by the real-time core.  However, I have to upgrade the
basic arm64/fpsimd port to v6.8 before someone else can handle this
task. ETA, hopefully next week.

>>> From: Philippe Gerum <rpm@xenomai.org>
>>> Subject: Re: dovetail kernel maintenance
>>> To: Jan Kiszka <jan.kiszka@siemens.com>
>>> Cc: Xenomai <xenomai@lists.linux.dev>
>>> Date: Wed, 21 Feb 2024 21:00:17 +0100
>>>
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> people started to ask about updates for our kernel trees, and you
>>>> mentioned to me before that you would focus on the last two LTS kernels.
>>>> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
>>>> then also in 5.10 (all referring to the -rebase branches). Before taking
>>>> over 5.10 and 5.15, I would like to clarify their state.
>>>
>>> Dovetail ports to 5.10 and 5.15 are not maintained anymore, although I'm
>>> still upgrading 5.10 from time to time for work-related reasons, but
>>> nobody should expect this to last for long.
>>>
>
> I can take over those two, but we should coordinate that to avoid
> parallel updates, at least of 5.10. As 5.15 is dropped already, I would
> grab it now officially. Still need to decide whether I continue the
> rebase branches, though.

I don't plan to merge the generic support for oob networking (in
net/core/) which underlies the UDP implementation for xenomai4. So I'm
fine with handing over the maintenance of v5.10 asap.

[1] https://lore.kernel.org/xenomai/ff580dec-096d-45cb-b906-527446c4fa87@163.com/T/#t

-- 
Philippe.
