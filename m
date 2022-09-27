Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADC7B
	for <xenomai@lists.linux.dev>; Tue, 27 Sep 2022 00:51:10 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3321c2a8d4cso85949747b3.5
        for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=PhR17bYtq6BmeX7x9c2TJ4Dkw0f5ytUQvHbFqS/jnlw=;
        b=mDKcik/+fbImhkc9NTihF4LoDnFVtXr5VXbj14GzoxRdnwxIaOyMU53zFZVsOZKZUH
         XWMxt8LZ/eMqFZWiHh7KWifbAhliNelLKFg1KyxQ2CVhVGH2xMXLVGjCcDmfhWz17iIy
         8i8LQ7y57DezLaLKV/V3jtYLqzCFSg2skTfWT6MM/qR9ICGn1K43y3Ix/8pSbIuc7ilb
         Ty2W/fLknow0WgTkCaGpAQTjDKfCd3YjbFWVSOOyJeepJdi9Ycj2q2AcgEYa6nJkD5xQ
         +Uls+EPgxrrPnNMp1bSl18vFn+7FPX/b0uhwdsTlGAV57Dgdz2m1/ueurMUJb7L88aRP
         4ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=PhR17bYtq6BmeX7x9c2TJ4Dkw0f5ytUQvHbFqS/jnlw=;
        b=pKvE619a//bE80fOIg5L27GH649Tos7ae5+2FwDXd4roTqf7rxGo6mzaEscycG1VPP
         RmQ4CtKAVNE981BwnxYEuKNJY0AoeZKb14BNMH+eRs1ZUvQlbOPNrfnFET7vs51wGduy
         3NkfXqoRsY3VX+xb9UbJxrcfmqDhdN+t+rbil8VruJxENTZzmLDYwHBpwhZXB2eszmOD
         SkeyyTzBRi0hSD3XPOwDWuRV4JsU0FkZ5GoQaeHKDbZtnTlzPulEOCH/539vA7ywYMlx
         ehEpTBpNp7SY4j7KWJiDQ/Rrp3TQDBIqpFTYPNLaGJqwTZbBLR+1eCJQt53hXMIFZVb5
         YQ+g==
X-Gm-Message-State: ACrzQf3hxK7p1rkgglHmsVRr9eGQBiOoZvNbh2pQsue6NLaStDktXTMc
	tN5pZ0z6FuuL4jeLGxOxBqhBbh6upFJj5OGXlkhG0qRK2so=
X-Google-Smtp-Source: AMsMyM74KmBZ5O5F7cG/qEsQ/WkO4RV2AvBbXGhS5alw3gjsUKnq0K2XVh36sIX7EmOLnr21TvLE49Cdk/TZEnz2h5Y=
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr22472457ywc.316.1664239869140; Mon, 26
 Sep 2022 17:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 26 Sep 2022 17:50:57 -0700
Message-ID: <CA+K1mPEGDrQ=8NvyD_SK=CJTDj6TVphQRvKxM0BRcrcuKHkQHA@mail.gmail.com>
Subject: Secondary Mode stall during IDDP communication
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

We have two RT userspace applications (appA and appB) communicating
through IDDP sockets.
We run into a problem where one of those applications drops into
"Secondary Mode" and communications is halted, during the call to
recvfrom(). How can we prevent this?

We are using Xenomai 3.1.2 on kernel 4.19.229, ipipe patch, X86 CPU.
It is a 64-bit kernel compile, but our RT applications are compiled
32-bit such that they use the "compat" layer. Since a very large
amount of legacy code is now ported and stable on Xeno 3.1.2 we can't
switch to Xeno 3.2 (or Dovetail).

Here is a backtrace when running the application in a debugger:

Thread 4 "communication" received signal SIGXCPU, CPU time limit exceeded.
[Switching to Thread 0xf703eb40 (LWP 4641)]
0xf7fceb69 in __kernel_vsyscall ()
(gdb) bt
#0  0xf7fceb69 in __kernel_vsyscall ()
#1  0xf7cd497a in do_recvmsg () from /usr/xenomai/lib/libcobalt.so.2
#2  0xf7cd5214 in __wrap_recvfrom () from /usr/xenomai/lib/libcobalt.so.2
#3  0x080798e1 in IPC_receive () at application.c:22634
#4  0x080799ee in comm_task_proc (arg=0x0) at application.c:22694
#5  0xf7d01f4c in task_entry () from /usr/xenomai/lib/libalchemy.so.0
#6  0xf7cf1405 in thread_trampoline () from /usr/xenomai/lib/libcopperplate.so.0
#7  0xf7cd6d35 in cobalt_thread_trampoline () from
/usr/xenomai/lib/libcobalt.so.2
#8  0xf7ca9e99 in start_thread () from /lib/libpthread.so.0
#9  0xf7bdbb4a in clone () from /lib/libc.so.6

in dmesg:
[ 1057.789858] [Xenomai] watchdog triggered on CPU #0 -- runaway
thread 'communication' signaled

This is how we initialize the IDDP socket in our RT userspace app:

   appA_socket = socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP);
   sock_poolsz = 32768;
   ret = setsockopt(app_soappA_socketcket, SOL_IDDP, IDDP_POOLSZ,
&sock_poolsz, sizeof(sock_poolsz));
   if (ret)
      return FAILURE;

   tv.tv_sec = 0;
   tv.tv_usec = 1000;
   ret = setsockopt(appA_socket, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
   if (ret)
      return FAILURE;

   appA_addr.sipc_family = AF_RTIPC;
   appA_addr.sipc_port = 13;
   ret = bind(appA_socket, (struct sockaddr *)&appA_addr, sizeof(appA_addr));
   if (ret)
      return FAILURE;

   strcpy(plabel.label, IDDP_SOCKET_LABEL_EC);
   ret = setsockopt(appA_socket, SOL_IDDP, IDDP_LABEL, &plabel, sizeof(plabel));
   if (ret)
      return FAILURE;
   appB_addr.sipc_family = AF_RTIPC;
   appB_addr.sipc_port = 12;

The call to recvfrom:
    ret = recvfrom(appA_socket, &buf,
                  sz, 0, (struct sockaddr *)&appA_addr, &addrlen)

In about 80% of our tests the apps can communicate with each other for
about 2-3 seconds until AppA drops into secondary mode and the
communication stops.
However, a few times we have seen the apps stay in communication for
many minutes before we killed them normally. We have tried changing
the call to recvfrom to __RT(recvfrom()) but the results were the
same.

The gcc compile cmdline for this app which drops to secondary mode is
as follows:
gcc -g3 -m32 -I/usr/include/libxml2 -I"SOEM/" -I"SOEM/osal"
-I"SOEM/oshw/linux" -I"SOEM/soem" -I"../include/nanopb"
-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -m32
-D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_REENTRANT
-fasynchronous-unwind-tables -D__COBALT__
-I/usr/xenomai/include/alchemy -I/usr/xenomai/include/rtdm   -Xlinker
-rpath -Xlinker /usr/xenomai/lib  application.c
../include/dia_dev_app.h ../include/crc_table.h ../include/dac.h
../include/dacdefs.h ../include/app_version.h
../include/canopen_drives.h ../include/adcdefs.h
../include/app_version.h ../include/adc.h ../include/app.h
../include/canodefs.h ../include/preproc_app.h
../include/app_mem_manager_data.h ../include/comm_dta_app.h
../include/comproto.h ../include/quad.h ../modules/rtsync.h quad.o
dac.o adc.o SOEM/lib/linux/liboshw.a SOEM/lib/linux/libosal.a
SOEM/lib/linux/libsoem.a ../include/nanopb/nanopb.a  -lxml2 -lz -llzma
-lm -ldl -L"SOEM/lib/linux" -Wl,--start-group -loshw -losal -lsoem
-Wl,--end-group -lm -Wl,--no-as-needed
-Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
-lcobalt -lmodechk -lpthread -lrt -m32 -o app
