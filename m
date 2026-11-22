Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358095;
	b=Vd8H9F/xs3jnygW8Sjf0yo6t6ILX6f8eiqmG5sjz3j2KCKvRV6ZlSuDBnsOBDFYvnZwz
	 0sy7B7g8pn4FnXhPVWi/rt74I7rqAr0pX3IEVsXCgP5GG3zvRBWyQJMoKZFJSv+s1cLrv
	 Eypt6wbL8fj8+uOMThmXYqZ3meLLN8D5q5V2A2gWFxq0Mg+CsFtgKq99Nswljwl8JUzr+
	 ux21KXxJSI12rc2AYDps+ahiTZF+wBuvXX4CflZ9Rd/m7s8YnIk8jIdHUPPXSv2ZwN6PF
	 NDSW9yW9XYDtxIV1rtYZv8QQeB+dYHRhueieQ67uQDbzOJp1D6myf3F3X8Mh0kNxhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=prs4FsvUZbz9MGKQ7dm+Cs7eH0CojOm/PWBV/EQHPMg=;
	b=1TQd2x6Iccz9VMEgQ+hCN/PdEu/4WUPmAH9E6BaB0dvAksaWK0LQ7I50iTjcsr6RExIU
	 /bz39Di0Tt+Mr3vcxpDMNysFTq6+QRo2e4fr9m8xL1EG10glCDmVzVVEod9e53XZfGyxq
	 eqpR5m1R4czMMmm0zK6ScdFJcHqmlSabGm3ZeZDoAiKz4KSY2XhciZh2vdIyzky9fSnEu
	 w/lYiP29vxfma0uZuAYNPNkcytuoUj5JSMK4xSddVWyJOf1ooHA2yrj+iDG2efaYqY8YA
	 pqy8cOssQdI3ng9St3QhNoKKnzkWHTcXdhLrHz1NvHc/ePXm+QjjS203zgE2zaJ4vqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=eqZZMQ1k;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFF606A320
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 14:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECFF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=eqZZMQ1k
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso342623066b.3
        for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 06:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795358094; x=1795962894; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prs4FsvUZbz9MGKQ7dm+Cs7eH0CojOm/PWBV/EQHPMg=;
        b=eqZZMQ1k0R5y4a02f4rURdBlkiNj/REkTl8+ANn+TuxYzmcIjhGrz5AE2pp9R5Kb1O
         wGXMbcR3raTdqPRY3aEvO3iTade7h7Sp5WYL799VRnK/pWcZp/f13fYphl735j3tPw6/
         BrPMDQeIf/+1sKuyoOMmFyrAAMRayvbc2z+5gAJObjW4uARaWXgd3Eg0GYXyfqH0iXwM
         /vApkAaIAtqtPqJV/Yiuut2JZ5RN7Q5mtR49LlV1NCiJCtrx0OSz4lgnl92xUnWQxy+V
         tz9vp1Mp/dg2chcx6epOVCQCyCKrPsm4V06mEcKBlB1OyEDibbnSYDLZZV/EEA9NSLXx
         6yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358094; x=1795962894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=prs4FsvUZbz9MGKQ7dm+Cs7eH0CojOm/PWBV/EQHPMg=;
        b=xO2YjOUfgVJ/yD1AXkeVhi6b+GBF1mQlGWeDAXP+Tn/4qcaGsp86KN3TTH4BO8MCcl
         xh/zWa8bM3PFh1+TWjntrU+Xq6GgdF0ehUhzhSCW4XRs5UnSE3e4qrFeQvkbsGH959g3
         XDMFh2MSx+trfu7LwAK7uJV3CofbPwb47W66sBP38pjXVaDSfeEIyaPI1L829ofuLyAB
         PBe/rW9SRTZ4rH4etdwgmCQGIWLwbo/jD+1ci00i38tTDQ3GQVWW8lO0Kx2rXZWtaT3b
         g/egqY8OmmHdFXNyDlu9FDLqocNgJBTtBnnEElcsXgsMAiqlR6rgMfrbYFFIMzVa7K80
         35Kg==
X-Forwarded-Encrypted: i=1; AL+hErHJoyzF8330UrQf/hPpsaTofk4295qykt5ID3Zu6wTOeVPDfJp0un1ncqpIwu4Am1O4i3e2pkpM@lists.linux.dev
X-Gm-Message-State: APuU4Z/gK4daIhIGS51ydY/i5cLgVeP8Xvx4NsBZU7ZKy7SmIJwwJ2Ug
	lqe6Dh0jWolbbCtmOtD6d4ppJjUzKr5qoCcqn6sHc3Mx4OJyW63pjRCn
X-Gm-Gg: AZFdTZcTFj2CMcgtdK4G+rLlTPdfjNr4FB3kvji1NhZjvyO4hHHPBijrYEiiNIVtw09
	PmX7QllV/s+Q8y1zftTCOM+6gKAnUAf+OjneyBgTZnEUqtKCAwFVFg39QV4dm/huvVu6X1Hq+7m
	dFbrRdzkZmsNheZHm02PpilNpR5CK4lHRE7dhWfJdL9KZWemyBPaZJhqW4Bwvh99PlCXi9yAQzn
	svg71o26ONfgp/vS0LeZkcY+m9usKI3zwGJfyhHHa4WMv5C8t/a1Vp7niw7hUf05foTDlnO4l3s
	BzbDg49ATZYm4KfEArQiYDA1mkaLMdMUjYXgXGymV11DDfyzLfP17zPuuADj4+EINzJdqzyDcOl
	5piIM/NqJN2V5tWoGD+xwcPMGKR04f0H3jp/518qHr45komEB7ZMOrwefmZQ33fPFwIw2//ocB2
	1YMvceu9m6JPAUuKwn5220iztFoPj8XGEVxa4BM+SEW3TaUyE3zE0qQA2kPAX/DOSzITPE70W21
	T05JWcGROHUK7HzvWkMbwx+EUaOQMBnjTKBwRZBS5YtjEfnrjlmk4AujoYkvhuVE7uj7pUFPYCf
	SlTZJe/kodYehsJ1MbINxJT+yE3iTjTa90qjjA5lv/eHedYO1gw0ZPPlbsjxwljYHyxDrbIl1sA
	ClKqG+WSYxVnvV0Ro7DITYmcOFclrEw==
X-Received: by 2002:a17:906:231a:b0:c42:4750:8d49 with SMTP id a640c23a62f3a-c513aad2400mr507961866b.25.1795358093594;
        Sun, 22 Nov 2026 06:34:53 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae65965sm323553066b.23.2026.11.22.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:34:52 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	xenomai@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 0/4] Mercury build fixes
Date: Sun, 22 Nov 2026 15:34:52 +0100
Message-Id: <20261122143452.2973777-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9ce50b6edee8bf79bdb9bccb37decc9418857628.camel@siemens.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com> <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com> <20261118214521.2292680-1-yegorslists@googlemail.com> <231ed4e64e4210b736a9ef7eb41a9b86abfd5ebe.camel@siemens.com> <20261120214018.3745861-1-yegorslists@googlemail.com> <9ce50b6edee8bf79bdb9bccb37decc9418857628.camel@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Florian,

On Fri, Nov 20, 2026 at 11:17 PM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> I guess the first thing to clarify is: Do we want to support that? Seems
> nobody is using it as it is broken for ~6 years already. I don't have an
> opinion on that yet.

Fair enough, that's for you and Jan to decide. I've asked on the
Buildroot list who uses Xenomai there and with which core and C
library, and will report back. If Cobalt on uClibc-ng is not supported,
I'll make Cobalt depend on glibc in Buildroot, so users get a clear
limitation instead of a build failure.

> Whenever we can re-use / share the time64_t services for the native case
> it's enough to check for __USE_TIME_BITS64. If not - e.g. because of a
> different ABI / memory layout we need to check for __TIMESIZE == 32 to
> identify the compat case.

Thanks for the explanation. I won't send anything there unless you
decide to support uClibc-ng.

> That's good, but too late.  We should know on "merge" or "before
> release" if something got broken. Not afterwards. Or is that
> infrastructure building regularly any next/development branches?

No, the Buildroot autobuilders only build the released version that
Buildroot packages, so they find problems only after a release.

To catch them before merge, the place would be your GitLab CI. Right now
it builds only Cobalt, with the Debian trixie GCC 14 cross compilers
and the bullseye GCC 10 i386-userland job. Mercury isn't built at all,
which is how the missing includes went unnoticed. I could add
userland-only jobs next to i386-userland, e.g.:

- Mercury with the existing Debian arm/arm64 cross compilers
- Mercury with a 32-bit arm uClibc-ng toolchain from Bootlin's prebuilt
  toolchains

Each job would just run configure and make. Would that be acceptable?

For a broader check before a release, Buildroot's utils/test-pkg can
build any Xenomai commit against Buildroot's set of prebuilt
toolchains (glibc and uClibc-ng, various architectures and GCC
versions; Buildroot doesn't offer Xenomai with musl). It only needs a
Buildroot checkout and a config snippet:

  $ cat xenomai.config
  BR2_PACKAGE_XENOMAI=y
  BR2_PACKAGE_XENOMAI_CUSTOM_GIT=y
  BR2_PACKAGE_XENOMAI_REPOSITORY="https://gitlab.com/xenomai/xenomai3/xenomai.git"
  BR2_PACKAGE_XENOMAI_REPOSITORY_VERSION="<sha1 or tag>"
  BR2_PACKAGE_XENOMAI_MERCURY=y   # or BR2_PACKAGE_XENOMAI_COBALT=y
  $ ./utils/test-pkg -c xenomai.config -p xenomai      # default subset
  $ ./utils/test-pkg -c xenomai.config -p xenomai -a   # all toolchains

Toolchains the package doesn't support are skipped, and failed builds
can be re-run after a fix. For example, current next (9fe2f61f3) with
Mercury and the armv5 uClibc-ng toolchain fails in 2.5 minutes with the
lib/boilerplate/setup.c mlockall()/MCL_CURRENT error that v3 of this
series fixes. I'm happy to run this on a release candidate
or on next before a release and report the results, if you ping me.

Regards,
Yegor
