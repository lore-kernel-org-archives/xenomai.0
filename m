Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714A134B3
	for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so81004991fa.0
        for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 05:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698757019; x=1699361819;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy8TLNiLj52Mwwc3i9bXYhp4NzvQ/ItoaRbU5x2Vb2s=;
        b=nwOnVeZmvhICx7lEibKIEx2hFpB/w1C5abThuDFGKWHDdSSj28gWv2IUhz6IIjVSy2
         iSXIX6E7BpSh1MRKEc/78/nEznBNhHhloOiI9Xb4ApdIiQoQWPmRxYy0alFdQzXRRc2Y
         c6ePNAp0zVHYaqHsAMacZUWAs7a/2NWZ7QRLdZFGIV9TQY5k2XZHwhOnrfco45L68U3B
         5HSWFrE0T7YYcmilBUMhUuwMWGXSi6ZLsHEOqcjeEIdxgoTSrhqDFDf56TcJgTbGJJh8
         J3KgmEEB3O8HGLokvftf3feGXcPHPb0M9tpG48xzYu/Z9JhIHrvcWoYypAl4bkh1Zmsd
         M8Tg==
X-Gm-Message-State: AOJu0YwxumHRXN97FBR0k3WGwSLUsqNgCDCvOIS3m/HDUCv+LETDXShp
	Pyn3IVYy/1nFz9bKpYYpZrTuTlsFSBax3Q==
X-Google-Smtp-Source: AGHT+IE8SbTMw4OmYlzgC6BlOzFqI9ofdRzBUur1tkOwfQYR/c3abbudDUIc0gTBk3OcmIsYmBVZtQ==
X-Received: by 2002:a2e:9f06:0:b0:2bc:d634:2210 with SMTP id u6-20020a2e9f06000000b002bcd6342210mr9050707ljk.16.1698757019072;
        Tue, 31 Oct 2023 05:56:59 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id z14-20020adff74e000000b003200c918c81sm1444545wrp.112.2023.10.31.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:56:58 -0700 (PDT)
References: <20231024093242.1077831-1-clara.kowalsky@siemens.com>
 <87lebjgi5x.fsf@xenomai.org>
 <bfc296acb34deccc3615edc828779592c68346c7.camel@siemens.com>
 <87h6m7ghm1.fsf@xenomai.org>
 <dd9a43fbe4d7099c6017f9383550980bfa44a39b.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH v3][Dovetail 6.6] arm64: dovetail: Fix undefinstr/break
 trap handling
Date: Tue, 31 Oct 2023 13:55:07 +0100
In-reply-to: <dd9a43fbe4d7099c6017f9383550980bfa44a39b.camel@siemens.com>
Message-ID: <87cywvgdba.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2023-10-31 at 12:23 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > On Tue, 2023-10-31 at 11:46 +0100, Philippe Gerum wrote:
>> > > Ack. I initially thought we could postpone the in-band switch until
>> > > after some of the emulation code paths have been considered (typically
>> > > the MRS stuff), but that would involve convoluted logic for no obvious
>> > > gain, so let's take the straightforward approach instead. The assumption
>> > > here is that issuing an (emulated) MRS read request from a userland
>> > > application should not happen from a time-critical context anyway, so
>> > > doing this in-band should be acceptable. We'll see from complains if its
>> > > not..
>> > > 
>> > > IOW, patch merged to v6.6, thanks.
>> > 
>> > Nice! Thanks!
>> > 
>> > > 
>> > > PS: There are three Dovetail branches to maintain concurrently ATM,
>> > > twice that number when including the EVL trees. So please always mention
>> > > the kernel release any patch sent my way applies to, this may help
>> > > speeding up the process on my end (e.g. this patch conflicts, needs
>> > > manual backport to v5.10, v6.1.y).
>> > 
>> > We had [Dovetail 6.6] in the subject. I thought that should be
>> > sufficient. Seems it's not. How should we make that clear?
>> 
>> No, that's perfect. PEBKAC detected locally.
>
> Happens to the best ;-)
>
> Let us know if we can help backporting. Clara might have a look
> especially at 6.1 - our preferred target right now.
>

That would be great. I would take care of 5.10 then.

-- 
Philippe.
