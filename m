Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66217BEA2
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918424; cv=none; b=fafPWHgOjSq6OGMCp0TUQMAhZEMZHqQ/DgqmGWAAHCeZMFC3J1+CRE86LsI1q7UDuqPzR/86zfpAcYEMMinJGGrF8LucV20IQnH+M0aVblcQkiuAUHKglbYhfd9INOHsEJsSlLa0wifE/8JSCN+zlo2R16Azs/HpI3Yk8imANBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918424; c=relaxed/simple;
	bh=siRwIscd6hFv9Aen4D/AggBv8Fw07yY+prXRDz4ywok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OhEIUM0zVdwR6h7l+jv4Su+lkqrwM5t7Oqw7krmWmCk54Qc5/2JHYAJgOY3VVUlhaYh4zCoBxg3tulL4VyrajbHe2/XE6dchzcLnlecIdWI9BUOMDvOrfDzsfIhLR1DzmEhjD6NcFjT/mpSRvpUYcgxxPktSbd0RQfyAta3IJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f8490856so2831767e87.2
        for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 00:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918421; x=1732523221;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b00XpXF1E85S2pSTBvTy3oDEp39+7bqdDvI8RLWKQ6Q=;
        b=VdJ/tDeRxsIv9KGqONDi1Z6NrfXM6GH3KlPS7mlftCtKcbk5v706pifI2BQHfIORUu
         9eJOTodpUMF0856zAYESBiYnURPy72Eeou53hhVWdfMMQSoPeSkI5OQqf5kBs7S/79Xh
         arR9L6xcPEY6ELJOHwCVy0xkvvGCHb+e7VA1dySwq3UbTkY6f1W9jvE4nnO23LciPzax
         1+tDBeUWOiU6NPXOcnOP4C0+l8LCLosy1AvLDbzLWnP20PR29cmUCiDrSaLS0wbdtL/u
         YCVHehZ9EocUHGyqzzfnNcoAgCGjoDFQOiBjSAcEhlgGVXvcUg37DA/dVEhkInlp2o7v
         hxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQWH0d5wSp9OZ9eY5elCB2CoVlBQ3gilcsRpcodHsRvq9C2vfOGJGYU7sdGEtjL6Q1BWx0Lnba@lists.linux.dev
X-Gm-Message-State: AOJu0YzGKoIa/sRyvvsl8XwULEWePjtQksXC2jVH2wfmNxks8+6HdpHE
	c6ZiMLuGtcGvHKnnm3NVm9VbGX7+RyzBtK+KI0ulYc5eYuruvcAI4ayMpK8g
X-Google-Smtp-Source: AGHT+IGDQkItLjVjZV4lM0gJN1HeubM2qzmrvTxaSU6/zK1YuqcTXW/iFKpJoUlHd4Cw9gxppC145A==
X-Received: by 2002:a05:6512:2316:b0:539:e9f8:d45d with SMTP id 2adb3069b0e04-53dab3bfbbamr4333005e87.52.1731918420307;
        Mon, 18 Nov 2024 00:27:00 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721b7sm146516255e9.8.2024.11.18.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:26:59 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
In-Reply-To: <49554ca1-4f91-4d9d-8b40-7561eca99908@siemens.com> (Jan Kiszka's
	message of "Mon, 18 Nov 2024 08:48:31 +0100")
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
	<20240613134557.4013044-4-tobias.schaffner@siemens.com>
	<87jzisrkfo.fsf@xenomai.org>
	<dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com>
	<ZyUJFhSxPyAcfSHI@trex>
	<49554ca1-4f91-4d9d-8b40-7561eca99908@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 09:26:55 +0100
Message-ID: <87zflxj6b4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> [sorry, missed your reply]
>
> On 01.11.24 18:00, Jorge Ramirez-Ortiz, Gmail wrote:
>> On 13/06/24 17:30:51, Jan Kiszka wrote:
>>> On 13.06.24 16:16, Philippe Gerum wrote:
>>>>
>>>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>>>>
>>>>> Stress evl with a load command while running the tests. The load command
>>>>> may be set to an empty string to run tests without stressing the system.
>>>>>
>>>>> To align with xeno-test the -l command line argument was used for the load
>>>>> command. Listing of the unittests can now be done with --list and --List.
>>>>>
>>>>
>>>> Nak. Compat with xeno-test is definitely not a requirement if this means
>>>> breaking the existing evl command line usage. Besides, --List looks
>>>> strange as an option. Let's pick a different option for the load command
>>>> instead.
>>>>
>>>>> The load command is moved to its own process group to allow a clean
>>>>> teardown of the load process with all its subprocesses.
>>>>>
>>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>> ---
>>>>>  utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>>>>>  1 file changed, 61 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/utils/evl-test b/utils/evl-test
>>>>> index 5c1c3da..fb85f69 100644
>>>>> --- a/utils/evl-test
>>>>> +++ b/utils/evl-test
>>>>> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
>>>>>     exit 2
>>>>>  fi
>>>>>  
>>>>> -usage() {
>>>>> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
>>>>> -}
>>>>> -
>>>>>  keep_going=false
>>>>>  do_list=false
>>>>>  full_path=false
>>>>>  unittests_only=false
>>>>> +load_cmd="dohell 900"
>>>>> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
>>>>> +
>>>>> +usage() {
>>>>> +   cat >&2 <<EOF
>>>>> +evl test -h
>>>>> +
>>>>> +This help text.
>>>>> +
>>>>> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
>>>>> +
>>>>> +Run a basic test/benchmark of evl on your platform, by first starting a
>>>>> +few unit tests, then running the latency test under the load generated by
>>>>> +"load-command".
>>>>> +
>>>>> +By default, the load command is "dohell 900", which will generate load during
>>>>> +15 minutes. To generate a more realistic load see dohell help.
>>>>> +
>>>>> +This script accepts the -k option to tell the unit test loop to keep
>>>>> +going upon a failing test. Otherwise evl test stops immediately.
>>>>> +
>>>>
>>>> To be fixed wrt the comment on the previous patch.
>>>>
>>>>> +Use -u if you want to skip the latency test and only run the unittests.
>>>>> +
>>>>> +Use --list to output all the tests available. --List will print all the tests
>>>>> +with their full path.
>>>>> +
>>>>> +Example:
>>>>> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>>>>> +
>>>>> +Will generate load including network load using the server at IP address
>>>>> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
>>>>> +installed under the /ltp directory, and use the latency test by measuring the
>>>>> +timer irq latency.
>>>>
>>>> We should use stress-ng or something alike, instead of the obsolete
>>>> dohell script.
>>>
>>> Fact is that dohell does better than stress-ng, at least in the configs
>>> of the latter that I've seen before.
>> 
>> just "dohell -s 192.168.0.5 -m /mnt -l /ltp" ? do you know after how
>> long (ie, did it take a few hours or just minutes?)
>> 
>
> Yes, I ran what Xenomai 3 also runs, for better comparison. That was for
> some hours (don't recall exactly anymore). Not just 10 min but also not
> for a day or longer.
>
> My theory on this: With RT Preempt, it's more effective to stress the
> common code (and locking) paths like stress-ng is triggering. For the
> more decoupled co-kernel architecture with way less common locking, and
> that rather short and not nested, cache load is more effective.
>

Same conclusion here, this is where the vm stressors may come into
play. They tend to pound the hardware pretty aggressively, in addition
with stressors causing a high rate of context switches (L1 flush +
mandatory hard irqs off section on mmswitch). If we could generate such
load by using the proper stress-ng stressors, we would only depend on a
broadly available tool suite which implements state-of-the-art testing
techniques (Gilles wrote xeno-test 14y ago based on my testing habits
since 2006 or so, which clearly does not qualify anymore).

-- 
Philippe.
