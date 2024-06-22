Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969A14A4E5
	for <xenomai@lists.linux.dev>; Sat, 22 Jun 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719035348; cv=none; b=BKjo+vbv98+kyfzHuU1pgR5m3bAcMbe22Jw7p4pM6l+504g3e6sF27VcAZv2J3ff0NRZhDXb7GOINVDG5lRv1nTRtYTd8saRoPuG75YhWYPcaTE8L/kvxF6+iv4nzy91GhnjFxFD9S/O0sCoFq0K159iR8+9D2eZFs7N10+HP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719035348; c=relaxed/simple;
	bh=EjfQN1ce6UChe91WStNDbU0IBtJdHy9h0BnYQFSY6v8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=LhxL7ExyC5wYzXCp3co/5pKPtTW2iQ4JEnhB07c03fBIRX+i3A6zvLw7ocdj5zoRnfventzjyRilMy5A2Te+y1Oii9T+0ccsepYTx22hYqi2Hbsld/AuBGOcknRT1VCd8XWOyskulVJvo9pOyEeR+3++MbWUlXlhKrFpXoM/ZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7lUrpcM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7lUrpcM"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2598ae41389so1423881fac.3
        for <xenomai@lists.linux.dev>; Fri, 21 Jun 2024 22:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719035345; x=1719640145; darn=lists.linux.dev;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0s1erEoy0LJ9hmAD99TV7Iq7KJuENfOqoX7kDYSfnQ=;
        b=Y7lUrpcMIGv+Iuz6DXCoNgQqhJ9jQMl60Ca08TpG/5JPdC75JA89Uwtc5/JKBfdQgq
         5JCwe0rTyd6rspY5p/gOYarQ8saz/9Kz8spMWCU2NYRqSd7AL+t4EQnAwSlOtSd0K4ri
         R3PTJ+9zxdYxrEIPFtX44npNEfWb4Q949ohW3bq9OyHAewITtmU+6IkpdXShbfOyRMFZ
         Rq4aGydy1uENF2j+0Zj2a5CNZnKWJySj62slgZaaXBd1fR59zPH9EIXazBjowR4L59pO
         +8RzMWa/f53JLD5omaq1VjppWfH7oy4382ubgiVn1IJsVy8v7ls/Y32tT4tZ1MNgJt/l
         Q1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719035345; x=1719640145;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0s1erEoy0LJ9hmAD99TV7Iq7KJuENfOqoX7kDYSfnQ=;
        b=wmpHZAwa9MbyB1Sohx/P+lwfD/zmkTnUQVRAk29SnCYkMXvmKCfqHbNXfh/vangxgI
         z8TfBopu6dhcAXwPkHNQj6WKJ6/az9CjE4dsPaqhP6ouv2j31zo0cc28Xf+iaAtjAyr5
         UedKAYJ+1XXXMf0J71q8dHG1hM6SvZ03ggFAU7zxjcDATfpFZZhvTD0g0eEmxG1FReSk
         +O1VmB6gPkacVXVRoTmYFaGAkh8m3RGfQqNOGLlNXl9j3PLxDcadnToiHamGi4oanJ5L
         WQuFcpgczHWGJ7IZCQ2ZJsbv7fRXtLNnvN9GsucWg6Vlm6pNkUn9AgpF62T9ZzID4nFE
         daxg==
X-Gm-Message-State: AOJu0YwkJGgYwasIdCBD88VBa9IJIBgbpMZCPotmehikV1faMQA/nh5o
	rw0LoVDGGEtRhkkzicoR00YYPwc4KazKOji8ug99UVP4SLarPWXfU9th5w==
X-Google-Smtp-Source: AGHT+IGvKNtfek74vFH4MktTdVhWg78U8dRGvm2fJwNCeRU6pOaii/GrcFx4tO7haBaLbbSv6AUvag==
X-Received: by 2002:a05:6870:f151:b0:250:73d9:7739 with SMTP id 586e51a60fabf-25c94d059e1mr11408900fac.45.1719035345377;
        Fri, 21 Jun 2024 22:49:05 -0700 (PDT)
Received: from smtpclient.apple ([103.88.46.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651311293sm2339628b3a.213.2024.06.21.22.49.04
        for <xenomai@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 22:49:05 -0700 (PDT)
From: YinJie LI <liyinjie0418@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Assistance Needed with EVL4 Monitoring Data Not Updating
Message-Id: <8AE92F55-6328-43C0-9548-952CBCF19929@gmail.com>
Date: Sat, 22 Jun 2024 13:48:50 +0800
To: xenomai@lists.linux.dev
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi=EF=BC=8Call

I recently started working with EVL and wrote a simple piece of code to =
understand its behavior.
However, I=E2=80=99ve encountered an issue where the monitoring data =
does not update as expected,=20
while latmus tests show changes.

Here=E2=80=99s the code snippet:

#include <sys/types.h>
#include <unistd.h>
#include <error.h>
#include <sched.h>
#include <pthread.h>
#include <evl/sched.h>
#include <evl/evl.h>
#include <evl/thread.h>

int main(int argc, char *const argv[]) {
	struct sched_param param;
	int ret, tfd;

	ret =3D evl_init();
	if (ret)
		error(1, -ret, "cannot initialize EVL=E2=80=9D);

	param.sched_priority =3D 8;
	ret =3D pthread_setschedparam(pthread_self(), SCHED_FIFO, =
&param);

	tfd =3D evl_attach_thread(EVL_CLONE_PUBLIC, "evl-example-%d", =
getpid());
	if (tfd < 0)
		error(1, -tfd, "evl_attach_self() failed=E2=80=9D);

	for (;;) {
		struct evl_version ver_t =3D evl_get_version();
		printf("Hello, EVL! %s \n", ver_t.version_string);
		usleep(50);
	}

	return 0;
}

The monitoring command (evl ps -tsp) shows the following, which does not =
change over time:

Every 1.0s: evl ps -tsp                                                  =
                    =20

CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA       STAT     =
TIMEOUT      %CPU      CPUTIME       NAME
  3       96822  fifo          8       1           1                1    =
         0             X              -                   0.0        =
0:000.009        evl-example-96822

The relevant versions used are as follows:
libevl=EF=BC=9Ar46
Linux-evl: v6.6.23-evl2
Gcc : 8.4
Linux : x64 intel

Could anyone help me understand why the monitoring data isn=E2=80=99t =
updating or suggest what I might be missing?

Thanks in advance for your assistance!


