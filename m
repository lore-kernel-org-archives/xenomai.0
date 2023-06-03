Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477AD50E
	for <xenomai@lists.linux.dev>; Sat,  3 Jun 2023 20:39:02 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-977c72b116fso93219466b.3
        for <xenomai@lists.linux.dev>; Sat, 03 Jun 2023 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685824740; x=1688416740;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0RbtBROVxYsUEuh+pczjVHNk2qrctCYExdEdQgvaVFk=;
        b=Tmcl+GWerUrM9DNEcfy47XJezN9wv9jdyd0WaXIobFrwZKTqvqmfA7fUIFtA7T5CQ+
         YLQ2pAS3IEwAn4WSs0/owoC93Ro+W6JGyZMxhtKgiT9XC50Rtkz8oaaGZiK7vUG2WDSL
         vkZ4cdddSemnEewHyxNHfln3RCBRF4QLgsclKJQB58SWdkCYPXWLpT4DoKfqnEIAR1Vy
         pj3SJqv+Oh4ck9TIfu6pc7OeO8Cz4VHRfDXIKn2Fkd6TtyjVfIUCdR5h4NN6ylgglW1S
         wdl957GGmgwuYseVf4esuFrkm/QVgYnkDXpwKrhD9666bROM7JOffccaXa7y6yfEjbun
         eWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685824740; x=1688416740;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RbtBROVxYsUEuh+pczjVHNk2qrctCYExdEdQgvaVFk=;
        b=MgypmLdwDkpCVtxKIsIdXoYrm4Ssgu/hjx3ge5wMNykywRzWYcWkslOKj/6j/a7bce
         +Sbx3U4Zj9onAMjHVXN0OQdg8rblKt5lZeeZQ0RpEc6hM+ApnLrskFB3EVmIh3Ci/QTU
         IA8aPhFg3CCH4bpbM9IXgYO144IlsEyDdzYq/+oFvHv1/xsqE+vskar2NTv9O8LdQEAS
         NFSlDux/zhN/E0/HDcCXe/YBNGZki3+6BHNRm8FX3ERPFmQ25V+IH6MWFOKdmlMxYczd
         cwP3eYWoLU7WhkNJf6ZA9Jn5GDQaCzSYaAF1NE72bXTqKoisSpBvoGPWPLhhcihA2hcQ
         8hGg==
X-Gm-Message-State: AC+VfDxaj6opOY/dYWs8dnlP2ba7fw3ilcxynlzQFpbpnR+Xj7r/3VfR
	o4xrKafFB/AKSkxDh4fBbTyVQFEIgHu/5tqdKGttyIcyILE=
X-Google-Smtp-Source: ACHHUZ6CagQ48lKTS4I3yQk40Zgv9ErcBTqYj9fipl+hK+GXzc3vpbUVyOwe3AN3EZB1aWWBQhDnJBShDomyXpbxKkU=
X-Received: by 2002:a17:907:9621:b0:94f:6058:4983 with SMTP id
 gb33-20020a170907962100b0094f60584983mr2580482ejc.76.1685824739871; Sat, 03
 Jun 2023 13:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sat, 3 Jun 2023 13:38:48 -0700
Message-ID: <CA+K1mPG0PPv6vus7jOraBVJ1cQHoj3XnJcOud7v_7iNO5QyuVQ@mail.gmail.com>
Subject: Secondary Mode backtraces
To: xenomai@lists.linux.dev, Xenomai List <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"

I have RT userspace app which is failing and switching to secondary mode.
I'm wondering if there is a way to get a more informative backtrace in my
SIGXCPU handler.

I'm using xenomai 3.1.2, kernel 4.19.229 on an X68 CPU, and my app is compiled
with -g3 debugging symbols, it is not optimized. I have a signal
handler to catch secondary mode:
 signal(SIGXCPU, warn_upon_switch); // in case Xenomai switches to
non-realtime mode
I just added code to generate a backtrace :
 warn_upon_switch()
 ...
  nentries = backtrace(bt, sizeof(bt) / sizeof(bt[0]));
  backtrace_symbols_fd(bt, nentries, fileno(stdout)); /* print
function strings, offsets */

I am now running the app and waiting for another Secondary mode
switch, to get a backtrace,
but the time between the last two failures was 7 days.  In the
meantime, I did a test where I forced a switch to secondary mode (by
calling glibc open()) in an arbitrary place in my RT thread,
which gave me a backtrace to investigate:

 10:23:22.843077: /xdevel/bin/my_app() [0x807cbf4]
 10:23:22.840927: linux-gate.so.1(__kernel_vsyscall+0x9) [0xf7f6eb69]
 10:23:22.841009:
/usr/xenomai/lib/libcobalt.so.2(__cobalt_open64+0x3e) [0xf7c74b2e]
 10:23:22.843335: /xdevel/bin/my_app() [0x807c98e]
 10:23:22.843410: /usr/xenomai/lib/libcopperplate.so.0(+0x5405) [0xf7c91405]
 10:23:22.843486: /lib/libpthread.so.0(+0x6e99) [0xf7c49e99]

The first line of the backtrace referencing my app is the second line of
my SIGXCPU handler - not helpful. The second reference into my app is
more informative:
 addr2line -f -e main/my_app 0x807c98e
 Periodic_routine
 /home/xuser/src/xdevel3.5/my_app/main/my_app.c:24057

That Periodic_routine() line 24057 is the line just /after/ the call
to my function Find_devices() in which is my intentional switch to
secondary mode.
So the problem is that the backtrace did not catch secondary mode on
the proper line inside
Find_devices() but it blamed a line just after that function returned.

* Is there any way to make the backtrace more accurate, like an inline ASSERT
or something?

thanks,
-C Smith
