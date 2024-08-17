Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDB155337
	for <xenomai@lists.linux.dev>; Sat, 17 Aug 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927285; cv=none; b=VME0KTBgUMysYHJFyQNVfy3OkPxOri96Ghi2H/kUhg57776TGmsDlklKCYWM2iq1zfK3Nn6A4GxnxNpTcGovFv8W+1wQgGC6CUsualQnX+au/SlBQeWvbStZu1T5CR40NmttuEnOBt0PMlizPC64qqMQZbHCjdcGZtV37L3fTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927285; c=relaxed/simple;
	bh=MN56B/p3094r8eqBl2DR8+bb3uDFVmobZiceB1KLSo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNttDrdCiID0clyiJRVwS+2s0g5bzH3ffIF9SV+zBvHZ1U6kx3zWGmWfxlRaxjdReDpKgep2dZgDzQJe+v1hxTw89RyOIlP5ShgisEuq9Wi1aPXGkcYVLougVqMvv9ebpTrOJ7bud8aCJUX4mmEYgtAcOrnmyF0/cgnPwyLsw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428178fc07eso21734515e9.3
        for <xenomai@lists.linux.dev>; Sat, 17 Aug 2024 13:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927282; x=1724532082;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MN56B/p3094r8eqBl2DR8+bb3uDFVmobZiceB1KLSo0=;
        b=k/4AlXx84Fq1uDq30P135ZEcpkrVw5f2z6ydXA9/j7AU0r3GzhcAHqU+S1lbOQAMvf
         hcw1lmXdcYTT4aUGQDXuevpXXMcsfwT4ybeErUoOmrmprYzi5HwigYBf3UEnr48sZ4Sw
         ICfsBVjGOuwowSRJr36dpY1tP+arYexcxZ8J2nyKbrNuQQXCyT5JaxPzuIUIQOrx7R9h
         1SHJB83N5MjZcbIj0e876laElsybnvUhUvmo4/KTqA4fBSyWkzP/gdoPM/TU0vYD9upx
         9gKZ1kWSYWQCsDjG4RBvBDnGgfXen553xvWUFbOA9kj/KE+1q2z0AxJVALyyZfeup161
         OVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKPHITpmFD57AJ8KIXfs1HRL3m3WfH3Xw4LtzrYTcn/Kfuj13arRmciGsXbeFqmXrS6mLmXjsK@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo+d2SGl9YNnBuwGKwrAqXsDp4IwD2lmlaM/NIkvLl8yNC3eCn
	01c+eMhaoCCQiARZtlWsEq4FmokXzuJj4G2zFkvMPSnORwBZXv/kAM9R+Lvf
X-Google-Smtp-Source: AGHT+IEROHsa51w0oFw9FGTWAWLoOpKmG2lFKdrtgiG5HruuHHMXgWlvVMT2UYsaaRLieHBdc7dTzQ==
X-Received: by 2002:a05:600c:1d06:b0:428:52a:3580 with SMTP id 5b1f17b1804b1-429ed7a5f68mr42027335e9.3.1723927281484;
        Sat, 17 Aug 2024 13:41:21 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed785708sm57592375e9.37.2024.08.17.13.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 13:41:21 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Xenomai Meetup at OSS Vienna in September
In-Reply-To: <CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
	(Richard Weinberger's message of "Sat, 17 Aug 2024 21:14:39 +0200")
References: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
	<5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
	<5e35103a-afc1-41de-9103-791380ce21b1@siemens.com>
	<CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Sat, 17 Aug 2024 22:41:20 +0200
Message-ID: <87o75q51cf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard Weinberger <richard.weinberger@gmail.com> writes:

> On Thu, Aug 15, 2024 at 3:36=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.co=
m> wrote:
>>
>> On 15.08.24 12:08, Florian Bezdeka wrote:
>> > Hi Richard,
>> >
>> > On Thu, 2024-08-15 at 10:46 +0200, Richard Weinberger wrote:
>> >> I expect that some members of the Xenomai community will be attending
>> >> the upcoming Open Source Summit in Vienna. If there's enough interest,
>> >> we could arrange an in-person community meeting at a local beer
>> >> garden?
>> >
>> > Nice idea! I will be there and yes, there is interest to meet.
>> >
>> > I can already tell that Jan and me can not join on Thursday of the
>> > conference week, 19th of September. Every other day should work on my
>> > end (- can't speak for Jan though).
>> >
>>
>> Hehe, just realized that I have a double-appointment on that Thursday
>> now (RT and CIP). Definitely no space for Xenomai.
>
> I'm also blocked on Thursday (RT party).
>

It looks like everyone is going to be at the RT party. Same here.

--=20
Philippe.
