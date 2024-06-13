Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9F26AE4
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295003; cv=none; b=EoxCr7/ikpKkjWJSuMfIFK9uHHLnjknQO2daPd6eY3O/cR4/Yh0bYXLbbmbr/lW7gxnqrGnsq8IM46RijcBoZNF9huTaiaPvmjx/HPY2JyJCQG3A9h2vWmaCxX6FU9IKNGQqUZ0lzzvIPXqN2E5tbZjL0VDZ5uNs9T980T5jqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295003; c=relaxed/simple;
	bh=OMHKfytuOBpz0sRTc/7mH2eL6cNn7WKrcH7g8qs0sW0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=E5SoVyrIouA54hegd9yx84BhF0BZdQEM6etfR/6vx0CoaAjnxXvwNzKqMTLjgqHvWaKwJOO0ClPxRiI7MnoeGD5S5oUzZH58tFQyFNCWcULlUJM3owNh01NxSELiWsCUQaFpdHTW0UgD8xEROe17scgwfYYOVUxyb3yVoKKJ3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so11247761fa.3
        for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 09:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718294999; x=1718899799;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kLUG/gUwLUZHQeHAkyawNVFpadINRuWVcHFOEtjbFY=;
        b=gCXMVgmqKVll5JJkjd/EXsv+tFGG93Gu6yAsiFaXbx/fX8I6GTUu7t88h1t4WXECWW
         ts526TEAFkKMZg/5+grBhw/UArEUDkv+CpWPQz0YGwauiiaIKevHBJxV2M8mg3GpmxEs
         Hch+4Pdks9iL5yUcWxoNY8cZGCRgvWL5ILK4mva5/KRa7FUcObrvOvdCYJGNNmmmZWAB
         A03LFW90Fe2cTNKi3NrqXqsgJ8kBFz0nkaoUH0iMZq+OOAL7Frw91zD+78nXjeKvjGgV
         PKDHz+c6eHq1Ry53+6Suld4rps0l5y8oWivkSmfKsZ9S2IrV1uHAiwYVz2a6n260PkLD
         ks6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOoX425OLDbsDaEYu8JXj+bqSP5Wa6Pc2fZWvNRjggoO7VIaD4eOIj6H7ZPTdDlm6H7XPYZYwUsufrj5N5b/DgfWVHOxkqQQ==
X-Gm-Message-State: AOJu0YwQqG9B0pzYeQQ9Ex4qGEB6CTAA8pKoWIqR/CultVl6OfkxRnPQ
	V30IRXEx4UzI26UTlfSwYNIzJhgMjTiTJPrkzavmm5USlgHDjm54x+0h8Q==
X-Google-Smtp-Source: AGHT+IHuj89UBkAZK6V4br6B0QnEqywZuT9Jmwlfl5F4FTYL7eKXAjC9AmKSCRYKC3YxoEyp29TkNA==
X-Received: by 2002:a2e:9dda:0:b0:2e1:2169:a5cc with SMTP id 38308e7fff4ca-2ec0e46d9e8mr2079041fa.15.1718294999080;
        Thu, 13 Jun 2024 09:09:59 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f2f30925sm30832665e9.0.2024.06.13.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:09:58 -0700 (PDT)
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Date: Thu, 13 Jun 2024 18:09:46 +0200
In-reply-to: <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com>
Message-ID: <8734pgrfhl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 13.06.24 16:16, Philippe Gerum wrote:
>> 
>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>> 
>>> Stress evl with a load command while running the tests. The load command
>>> may be set to an empty string to run tests without stressing the system.
>>>
>>> To align with xeno-test the -l command line argument was used for the load
>>> command. Listing of the unittests can now be done with --list and --List.
>>>
>> 
>> Nak. Compat with xeno-test is definitely not a requirement if this means
>> breaking the existing evl command line usage. Besides, --List looks
>> strange as an option. Let's pick a different option for the load command
>> instead.
>> 
>>> The load command is moved to its own process group to allow a clean
>>> teardown of the load process with all its subprocesses.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>  utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 61 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/utils/evl-test b/utils/evl-test
>>> index 5c1c3da..fb85f69 100644
>>> --- a/utils/evl-test
>>> +++ b/utils/evl-test
>>> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
>>>     exit 2
>>>  fi
>>>  
>>> -usage() {
>>> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
>>> -}
>>> -
>>>  keep_going=false
>>>  do_list=false
>>>  full_path=false
>>>  unittests_only=false
>>> +load_cmd="dohell 900"
>>> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
>>> +
>>> +usage() {
>>> +   cat >&2 <<EOF
>>> +evl test -h
>>> +
>>> +This help text.
>>> +
>>> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
>>> +
>>> +Run a basic test/benchmark of evl on your platform, by first starting a
>>> +few unit tests, then running the latency test under the load generated by
>>> +"load-command".
>>> +
>>> +By default, the load command is "dohell 900", which will generate load during
>>> +15 minutes. To generate a more realistic load see dohell help.
>>> +
>>> +This script accepts the -k option to tell the unit test loop to keep
>>> +going upon a failing test. Otherwise evl test stops immediately.
>>> +
>> 
>> To be fixed wrt the comment on the previous patch.
>> 
>>> +Use -u if you want to skip the latency test and only run the unittests.
>>> +
>>> +Use --list to output all the tests available. --List will print all the tests
>>> +with their full path.
>>> +
>>> +Example:
>>> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>>> +
>>> +Will generate load including network load using the server at IP address
>>> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
>>> +installed under the /ltp directory, and use the latency test by measuring the
>>> +timer irq latency.
>> 
>> We should use stress-ng or something alike, instead of the obsolete
>> dohell script.
>
> Fact is that dohell does better than stress-ng, at least in the configs
> of the latter that I've seen before.
>

See my comment on the dohell patch.

-- 
Philippe.
