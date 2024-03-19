Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF061EEE8
	for <xenomai@lists.linux.dev>; Tue, 19 Mar 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862854; cv=none; b=ROtIgChfSDlgcb5ubFlZQDo51TZc+uRYYnCBrF12+hrK9dlJRGkaX0+9B2kUo1v5zpP8mk0nU7z4TuyCXHicuXpFDLbWI01mGZgC2ao2Ylzs0ut5ZzNQEprlQSlKCmlGjtjL/sih00hGFW1EA6imAIl1xQOBk+sSB+IDn6uM/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862854; c=relaxed/simple;
	bh=M8gcDXokUji/0HjC5JNaKX8v7C6WiF6iKvKCq0hL49k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=nvtmML4zmr1yrIBm3qk47wRtnsKT3Zj1Hhvh+CbSo44WQ37KBfen/Pn24gn0MFWanvyAwJb3NUOWR82REDQd9T3kVu7foqEpjDIuBDkqCRKr7DNM0bOofe/UKjTPCemzmZ+NKqSsQ9G5/fGvkce9ataQLC+WwE2xAT2o18b6kuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34005b5927eso2058633f8f.1
        for <xenomai@lists.linux.dev>; Tue, 19 Mar 2024 08:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862851; x=1711467651;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P4TPJf8qYusnsm/dywxDib6e5E+n4lOnUBPCVFvIm4=;
        b=oMjDTyexs4MurK1I3RmhU4Q1nUMP7H+3sTEBZQ9L3schRre2GQTCxrqre8cb1HasVP
         HaAB7sLX9ucmyiSCThVazBrx67O4xTWt+d5TBfkQ8Y/TOuGSUxK0qOeheFOIfGX+lgZZ
         ZfsRZP34pHZiSXQ4+Mscxr71JVwPnwKJTd4PsG52sL+Z4s++CdzeX5Dg7K7rrra/2Rp2
         RSzOGuLQggxyrYJCDLRBlDO/T6srpPhZz/wfQdeFRZLKl9ohYu7/ROroX9pC4t/lxXUb
         vNaYvKIp4YyhsI7A5mCP1cfzXFiSBit4+JtvijIhEm8yRhbuetKwHRr4YDEtyy6n+Rb+
         toag==
X-Gm-Message-State: AOJu0Yzn65vEORVc6J6GILYipAh9pACaLpQ9mY0eaHMU4aYvV3eGydPc
	gUS/bUZ8NUJxZajUMtJkEZZL4m+c68cCwyavC3N0Fp+IH/c0Ju7FO5w7wepc
X-Google-Smtp-Source: AGHT+IGlJxzg+WBBhjEK/n8VpYThvPK0YMTfprvrabnsVc/0GRB+vCIxSvcG5Y2fueEa0TvhjjFnPg==
X-Received: by 2002:a5d:4ec5:0:b0:33e:652b:d6db with SMTP id s5-20020a5d4ec5000000b0033e652bd6dbmr10525955wrv.23.1710862850551;
        Tue, 19 Mar 2024 08:40:50 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id bo6-20020a056000068600b003418016b04csm3793822wrb.76.2024.03.19.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:40:50 -0700 (PDT)
References: <DM6PR04MB538655375C57CF07EDDE5089E2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <87bk7kwu9z.fsf@xenomai.org>
 <DM6PR04MB53868485664BC9374914AC69E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB5386D31E1CB453165917BD24E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538672EDF4ADC9538AB418FDE22C2@DM6PR04MB5386.namprd04.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Rosenow, James" <jim.rosenow@mts.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Date: Tue, 19 Mar 2024 16:40:33 +0100
In-reply-to: <DM6PR04MB538672EDF4ADC9538AB418FDE22C2@DM6PR04MB5386.namprd04.prod.outlook.com>
Message-ID: <87zfuudybi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Rosenow, James" <jim.rosenow@mts.com> writes:

> Anyone have any advice on how to root cause this hang.
>
> The requested /proc/interrupts output is below and the system does hang with only CONFIG_IRQ_PIPELINE enabled.
>

I'll have a look asap this week.

-- 
Philippe.
