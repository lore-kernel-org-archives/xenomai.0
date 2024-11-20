Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E111A3BD5
	for <xenomai@lists.linux.dev>; Wed, 20 Nov 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110221; cv=none; b=B/OSrq4+uyxS8NsAJUCVbh5TwSF8R2nE9MHxoo6q+TarCtZSwRVKsIjxcDGeE0GVEv35I0IK3AUYrjU9woSKibr1HM3T+4jHJlqQGO1aKPCKS/W2y5to7FGwTyhIOy4aVEPU7dFZlIP8N23kh/lcapLX1tqG9yuSGfo6GwsehKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110221; c=relaxed/simple;
	bh=cHG0MV3qGiJBdcaVN6spPL3rDjmCTLBZtBUq/jrBqFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DqLDBV0RzlYNx45LbL/ykyT5d7FNMC4fC0+aVQoB0sPBrpbiVHkjni9KyjiA3YHIBOV9ppMQgiuTO+uRVNzsJrnVuemtJ9p4eD57gc8tnG30DFvTeiOP/U6ILNOhrYCa66zLGdFT1wkn4QK9JPNaiNPXTPAzDqPD/LmnBaFlK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id B605E100003
	for <xenomai@lists.linux.dev>; Wed, 20 Nov 2024 13:43:36 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by spool.mail.gandi.net (Postfix) with ESMTPS id F36E1D80287
	for <xenomai@xenomai.org>; Wed, 20 Nov 2024 13:43:35 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431688d5127so18163555e9.0
        for <xenomai@xenomai.org>; Wed, 20 Nov 2024 05:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732110215; x=1732715015;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQhxwjvWqAh2Ugm1q5owmWj9rezDjrc2wipBQVEzjbg=;
        b=Mgj6e/GIDzaM0ilCnjlGiv7nGvN1QGkxCnEpX+Cdc7bglharsC41wSpgf+HeTDW3tt
         Lys1Hi1V0N7xY5GpfXcEFtvlOJmScGGQRxRcYgccEpKGL8oEGTS164pt3PrJzypfmmC0
         1agICOZc5b/YILFAnEAfXvknLOnbMEAv3l1Ezg5RGljYxdKc7+auTx8ExkaBpZHEzQtO
         0U0uRkoEvSlYkHx6Y+PW22Qhs83TOrvRin7qOcSOEluypZrK3KNfilSQWgS/6mLCwkpt
         7uBNVtbBmyAk3dmh6/1YwHVg2gJZep3lPZsqt4sqyFyKYHNLia7IBePxK2Jk7dg0pT78
         iduw==
X-Forwarded-Encrypted: i=1; AJvYcCUYGAWR9JBNzaJo2OoJaJDwOhNG2EtHQpIAkZC0sysND6Nh9dNaHOVzoUbcLVJiTmDqTekpCmhh@xenomai.org
X-Gm-Message-State: AOJu0Yy/T0iyxQrLpT20DsblYMqzdLukCuDEWHXdv3+bDoRF/tPLdm0k
	3yvO5le7rIs4/BwAIWvGViFjZ3dSA9JisMDYGohjVri/260CpVOm0fxFOWuR
X-Google-Smtp-Source: AGHT+IEVuCv2r5IE6uZYR8oEqIRSQVo/AU0JUX9WRvAWPFBBx4SW5ZjVth+K6npn9SC3MeQEBrjG8A==
X-Received: by 2002:a05:600c:4f08:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-43348986a08mr23771825e9.6.1732110215300;
        Wed, 20 Nov 2024 05:43:35 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d17e3sm20248555e9.5.2024.11.20.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 05:43:34 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org
Subject: [xenomai4] POSIX API
In-Reply-To: <afea1670c26d61ccbd18b6a7b609498bb1dfb020.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 20 Nov 2024 12:59:35 +0100")
References: <87ses62bi5.fsf@xenomai.org>
	<d28b8d0200ef0e3ff63e833b64c2ad00c554e351.camel@siemens.com>
	<878qthiw8i.fsf@xenomai.org>
	<afea1670c26d61ccbd18b6a7b609498bb1dfb020.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 20 Nov 2024 14:43:29 +0100
Message-ID: <8734jm3try.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.42 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

CCing the list. This is a combined discussion about bringing a POSIX API
to xenomai4 and getting rid of the --wrap linker trick for xenomai3 in
the same move.

> On Sun, 2024-11-17 at 18:52 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > I finally managed it to "publish" a branch [1] that holds my tries to
>> > get rid of the function wrapping in Xenomai 3.
>> > 
>> > smokey is already running fine, some TODOs are left. See commit
>> > messages for details.
>> > 
>> > Further tests with valgrind and the gcc sanitizer will hopefully follow
>> > soon. Seems I have to do some prctl()/syscall() refactorings first.
>> > 
>> > I would like to close the gap between Xenomai 3 and 4 as good as
>> > possible so that customers can easily move forward without touching
>> > code - ideally.
>> > 
>> > Best regards,
>> > Florian
>> > 
>> > [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/flo/refactor-wrapping?ref_type=heads
>> 
>> Ok, I had a look at this code. I think I understood the key aspects of
>> it. I believe we can do without the trampoline which would make it CPU
>> independent. At least, I managed to implement the same scheme without
>> it [1], which eventually provides the very same support than we got with the
>> linker trick, i.e. for any frob() service from the POSIX API, we would
>> have:
>
> Yes, maybe I can remove the trampoline as well. Will try...
>
>> 
>> - __real_frob() /* original from glibc */
>> - __wrap_grob() /* a Xenomai implementation in libcobalt/libevl */
>> - __local_frob() /* a local (user-provided) override of __wrap_frob()
>> 
>> __real_frob() would require explicit call via some macro trick like
>> __STD() with libcobalt. Others would be invoked under the hood via a
>> plain call to frob(), depending on the insertion of liboverride.so
>> _before_ libposix.so on the linker command line.
>
> Yep. If we could get it flying this way it should be compatible to the
> Xenomai 3 world. __STD() for libc calls, nothing or __RT() for
> cobalt/evl calls.
>
>> 
>> I'm unsure the local override is that useful for the average user.
>
> Agree, for Xenomai 4 I would like to get rid of the user override.
> Unnecessary complexity - IMHO. 
>
> The situation is different for Xenomai 3. As I can't tell if someone is
> using that already - I heavily doubt that - I probably should keep the
> possibility to so. Backward compatibility...
>
>> 
>> Now, this hack would likely be an improvement over the --wrap directive
>> passed to ld, specifically because we'd not need wrap-link.sh to prevent
>> POSIX symbols in system libraries from being wrapped. As a matter of
>> fact, the technique illustrated in [1] relies on the library dependency
>> order on the link line to hide those symbols from the interposition we
>> would do. Only tested lightly, but this should work (see the Makefile).
>
> I did some tests in this direction as well. The results were promising,
> but more testing has to prove that.
>
>> 
>> BUT, this does not solve the fundamental issue I still see with these
>> more or less transparent interposition techniques which --wrap belongs
>> to as well: they all lack explicitness when it comes to clearly identify
>> who will handle the call by simply reading the source code. We still
>> need to understand the build context to figure out, which is a problem
>> because it's really error-prone, I believe. This is the aspect I'd like
>> to improve for libevl, if ever possible (maybe it is, I'm on something,
>> hopefully, but this requires more thought).
>
> Happy to hear your thoughts.
>
>> 
>> [1] git@source.denx.de:Xenomai/xenomai4/playground.git
>> 

-- 
Philippe.
