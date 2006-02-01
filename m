Date: Wed, 1 Feb 2006 14:13:03 -0500
Message-Id: <200602011913.k11JD3D3015291@domain.hid>
From: Gary Wallace <wallace@domain.hid>
Subject: [Xenomai-help] build fails with "more than 10 operands in `asm'"
Reply-To: wallace@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

  I have tried building both xenomai 2.0.3 and 2.1-rc2 but receive the
following compilation error for both versions:

xenomai-2.0.3/skins/native/lib/task.c: In function `rt_task_send':
xenomai-2.0.3/skins/native/lib/task.c:354: more than 10 operands in `asm'

  I'm using a cross compiler (gcc 2.95.3 from
http://www.kegel.com/crosstool/), the target is ppc and the host
machine is i386 linux.  The target kernel is version 2.6.14.6 with
i-pipe version 1.1-02.

  What am I doing wrong and how can I fix this???

Thanks,
Gary

