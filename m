Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D4100B2
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 13:54:13 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 01B13CDF93
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 13:42:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96140E0002;
	Tue,  8 Aug 2023 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1691502165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjDq63AT/1I3ZXo98HGKoIcA/vgzxYW9kByX0zV/vEg=;
	b=EbAnCXid7Hq7yuXl0knMqzD4L5EGhR60V6mLZw3JTRUKWKa06zm/F49Ec+NVjqzv1GtbmO
	rfUjPmnz3Ojr2PWYPe+Mj9n4SrYCr+RxLnZZ+O3IKTEf1WYHJqxf6IPRKEauFTlldzv3Wl
	/oaghMnCcp/tKzYRAiCauCIIxx4a7pp9VTbpe7IhefbE6Dvt9kYejYUyM152cOAu2pU4N8
	W1yvOBSi499CwpAm+EEB96syZ3nkuyEiV0blGDgIKEYBg4s/rZRLWO0CLkyG4l9c/h+j/U
	3JxufwvwH4018dtjDaBUeMt+vUwlmQ47rT+38r2tjFstTzdaIjQXvcC+yt7R/w==
References: <6712560bbd3fb1b22960b14090d0a4c018f61692.camel@siemens.com>
 <6c3240eb-896b-403b-3a36-d85fe24f8b5c@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: Re: Removal of arm OABI support possible?
Date: Tue, 08 Aug 2023 15:40:34 +0200
In-reply-to: <6c3240eb-896b-403b-3a36-d85fe24f8b5c@siemens.com>
Message-ID: <87leel646o.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.08.23 15:29, Florian Bezdeka wrote:
>> Hi all,
>> 
>> Clara is currently trying to enable compat support for arm64. That will
>> allow us to run arm(hf) applications on arm64 kernels like we do it for
>> i386 applications on x86_64 kernels.
>> 
>> We fixed the Xenomai arm specific register layout in a way that is
>> compatible to arm64. That looks promising as the testsuite (smokey) can
>> already be executed successfully in such a compat environment.
>> 
>> The changes we made affect the EABI only and we left the OABI interface
>> untouched and expect it to be broken right now. We can't really test it
>> here...
>> 
>> Is there still the need for OABI support in Xenomai? OABI is marked as
>> obsolete since gcc > 4.6.4 (~2013) and Debian stopped shipping oabi
>> toolchains long time ago. Would it be accepted if we simply drop the
>> OABI support of Xenomai?
>
> From Xenomai 3 perspective, it would be fine to finally drop that with
> the 3.3 release - patch(es) welcome.
>
> Not sure, though, how the situation of Xenomai 4 / EVL is in this regard
> - Philippe?
>

Having support for OABI was not even considered wrt neither EVL nor
Dovetail (would require specific syscall handling which is not there),
so it is safe to drop it entirely from any current Xenomai 3 codebase.

-- 
Philippe.
