Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 10:07:47 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D53405D@slcmail.slc.mew.int>
In-Reply-To: <497751E3.3020301@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
	<4976EABD.3060505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534053@domain.hid>
	<497751E3.3020301@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> __xnpod_init_fpu is for kernel-space thread. For user-space threads,
> the
> FPU initialization happens either in Linux code if the fault happens
in
> secondary mode, or in the fault handler if it happens in primary mode.

Interesting. Shouldn't rt_task_spawn() start up in primary mode even if
it's called in user space? Is it normal to start in secondary mode? I
know std::cout will migrate to secondary, but I do my fpu stuff before
that.
=20
> Which is why I suggested printing only if !strcmp(current->comm,
> "double_test"), and why you should stop double_test as soon as you
> detect an error. Furthermore, what interest me is what branches are
> taken in the various ifs found in xnarch_save_fpu, xnarch_restore_fpu,
> xnarch_enable_fpu.

My current test is called double_test_wlib and I notice current->comm
only prints "double_test_wli" so I guess there is a limit to the number
of characters in it. I'll put that in there now.

I changed the program so it doesn't need to loop. Just doing everything
in func() and func2() one time is enough to see the problem.

I will let you know about the branches in the mentioned routines
shortly.

Steven

