Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5B2904
	for <xenomai@lists.linux.dev>; Sat, 22 Jun 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719052676; cv=none; b=n1kJF4zU01mdEYTHnuC1EgWSEsu9rZKudsX+CYIWN3HCBp6OwSvDwD0cxLIGM+DLWC2uIL467i7h9FoTGKJy+lw4L5/FKsW2Upslh1nUXJTPhRszVbRQt/7tyB2nH5MAS6r0QV8rtYEEAFpohkT4bNqJTnya7D86UO0YnDEEZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719052676; c=relaxed/simple;
	bh=NT1MZz637+0Ybw9EXVYMaSLjJgHWO51KSeKXZSMaIqs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=RNRrATqS/WFKdJYhPGqrWjC5qxTo1iZ1ECdhFMoifBK0zVCdUElocMz7raB8c6LDgSLF0RvjskpwfkEMBKmFMNntB/R9J541FeCw9wXx9aO5ERbIPv+g3CIq0aBJ9VAvE9YkpxOjBD2/frg3t86LLlyU6HpeMHWXnj4A6fqUAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52caebc6137so2982595e87.0
        for <xenomai@lists.linux.dev>; Sat, 22 Jun 2024 03:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719052672; x=1719657472;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rjfoG8dCfS2dlX/kGkxag5Hvic4XFrd0w7N5MphOO4Q=;
        b=JokcB4Wxn9qCg7Ex7sNSe/akDLa137+9ArxjM6aKQx4AYNtk5quleB0mQ4CnguE9sq
         /BeKA0AeK9+hfKMSWrHyIe0fTCMVg4ljQl4Ug/b9GSqZ5O8fjoaXjA2XPLqeK3Uevy0V
         m2+1wyQDj6KrVs9ci1bqad6SqUS2+TDW1rQOW6BwJWE0f7M/XP22IcsgalKjyET4yqYG
         Qy4tiMnFztXT9o1uuYdRe1Nf0FPJp59wb90EWaJviWGQ09QPNjppmuiukYUY//vsNyae
         Y9iR21jvf9Mwr6by054UiR3fMOk6tT4gE6CpUGoZZOYx4PQfmjkw6i7rqNcOtu/poKWr
         5hWg==
X-Gm-Message-State: AOJu0YyAsjHNkh0a54zj08/gjPMDmeMmd4ieekrQj4FgHryaXv7BgwEJ
	2YLaUMki9GL85UMgzzOMY+T4lbAs9WLTShx/6xEsJJQOeCBQNHXU0ED0FQ==
X-Google-Smtp-Source: AGHT+IFQH835nGixcrSRvw0sJOXT3SIwdGt4wZQdrwEsHUKsTG7FzccdaTxza/W5dlDHATbJKyJPFA==
X-Received: by 2002:a05:6512:1190:b0:52c:c9d3:a30c with SMTP id 2adb3069b0e04-52ccaa62164mr7638182e87.29.1719052671583;
        Sat, 22 Jun 2024 03:37:51 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f68acsm4130103f8f.2.2024.06.22.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:37:51 -0700 (PDT)
References: <8AE92F55-6328-43C0-9548-952CBCF19929@gmail.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: YinJie LI <liyinjie0418@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Assistance Needed with EVL4 Monitoring Data Not Updating
Date: Sat, 22 Jun 2024 12:25:19 +0200
In-reply-to: <8AE92F55-6328-43C0-9548-952CBCF19929@gmail.com>
Message-ID: <87frt5e005.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


YinJie LI <liyinjie0418@gmail.com> writes:

> Hi=EF=BC=8Call
>
> I recently started working with EVL and wrote a simple piece of code to u=
nderstand its behavior.
> However, I=E2=80=99ve encountered an issue where the monitoring data does=
 not update as expected,=20
> while latmus tests show changes.
>
> Here=E2=80=99s the code snippet:
>
> #include <sys/types.h>
> #include <unistd.h>
> #include <error.h>
> #include <sched.h>
> #include <pthread.h>
> #include <evl/sched.h>
> #include <evl/evl.h>
> #include <evl/thread.h>
>
> int main(int argc, char *const argv[]) {
> 	struct sched_param param;
> 	int ret, tfd;
>
> 	ret =3D evl_init();
> 	if (ret)
> 		error(1, -ret, "cannot initialize EVL=E2=80=9D);
>
> 	param.sched_priority =3D 8;
> 	ret =3D pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>
> 	tfd =3D evl_attach_thread(EVL_CLONE_PUBLIC, "evl-example-%d", getpid());
> 	if (tfd < 0)
> 		error(1, -tfd, "evl_attach_self() failed=E2=80=9D);
>
> 	for (;;) {
> 		struct evl_version ver_t =3D evl_get_version();
> 		printf("Hello, EVL! %s \n", ver_t.version_string);

evl_printf(...)

> 		usleep(50);

evl_usleep(50)


> 	}
>
> 	return 0;
> }
>
> The monitoring command (evl ps -tsp) shows the following, which does not =
change over time:
>
> Every 1.0s: evl ps -tsp=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
>
> CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA       STAT     =
TIMEOUT      %CPU      CPUTIME       NAME
>   3       96822  fifo          8       1           1                1    =
         0             X              -                   0.0        0:000.=
009        evl-example-96822
>
> The relevant versions used are as follows:
> libevl=EF=BC=9Ar46
> Linux-evl: v6.6.23-evl2
> Gcc : 8.4
> Linux : x64 intel
>
> Could anyone help me understand why the monitoring data isn=E2=80=99t upd=
ating or suggest what I might be missing?
>
> Thanks in advance for your assistance!

This code loop never runs real-time evl-wise, because it's using plain
so-called "in-band" calls from the regular kernel logic, not evl
services. The first call to printf() downgrades the thread execution
mode to in-band, leaving it there indefinitely since there is no evl
call causing a switch back to out-of-band scheduling. As a result, this
thread does not perform any evl context switch as reported by 'evl ps'
in the CTXSW column, consumes no time in real-time mode and so on.

You may want to read this:
https://v4.xenomai.org/core/user-api/thread/
https://v4.xenomai.org/dovetail/altsched/

--=20
Philippe.
