Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E654C99
	for <xenomai@lists.linux.dev>; Wed,  6 Jul 2022 15:25:30 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1A13420012;
	Wed,  6 Jul 2022 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657121123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx97p2+O5w10XQ4hE1YgGy8f11T2InPyKBxOgNQiWtc=;
	b=chLkyDln1yhVvYNUrxGBTYKuuEppYyUM43MSnoVitY9U2rv1UMkZVHuKKPDSWGzFI0HiUC
	ksPSkpb/eEGfKYAXdqZR5VYcjYIQ1IdLQyrXe6nz7Us2qmQYA87egxrSZJYBq0spKUAMJ3
	ytZAEts+wXB0QKbC3WqEFAn5HOmt4kRH/GD7l0Y0PcYGPGjKctK2hqCQcAh68HdmDizHBI
	onxMqA6HJ/6y7DIliEX7jYy96K484nVSa1UR86nDOsModgfkFI20MCWKWWx4yc1MnluuYo
	76wM4WZWhwfK5EieUeItJOacMLZeVz75BShej558DQVgLn974huuDm2QpaCM9Q==
References: <PH1P110MB105061FEB2694B16A3879348E2BD9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10506DDF3B33330889D67BE6E2819@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: More details on health monitoring notifications
Date: Wed, 06 Jul 2022 16:57:42 +0200
In-reply-to: <PH1P110MB10506DDF3B33330889D67BE6E2819@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87o7y2s1p9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I also notice these lines in =E2=80=9Cdmesg=E2=80=9D output from the EVL =
core. Can I use the excpt or user_pc to get any more information about what=
 is causing these in-band switches?
>

Yes. Exception #14 on x86 is 'page fault' event, which seems to be the
architecture this code is running on. User_pc is the PC value in the
virtual address space of the process when it causes the trap in this
case. This is a - possibly legit - memory access which requires a
so-called 'major fault' to be taken.

GDB may help figuring out the location of this code, in two ways:

- switching the HM notifier to 'signal' mode for your threads, using
  T_HMSIG, you only need to run the app over GDB: the core will send it
  a SIGDEBUG event, which GDB will trap. Using the GDB 'backtrace/bt'
  command once the app is in break state after receipt should display a
  backtrace to the offending code (IOW the EVL core makes sure that your
  app receives SIGDEBUG immediately on top of the code causing the
  trap).

- using the GDB 'list' command to list the code at the PC value reported
  by the kernel should work. You just need to start the application
  first: unless you have a complex dlopen-based scheme for running code
  plugins, running until a breakpoint is taken in main() should be
  enough before you can issue 'list *<PC_value>'.

>=20=20
>
> [ 7301.352255] EVL: thread_1 switching in-band [pid=3D6319, excpt=3D14, u=
ser_pc=3D0x7f54a7877fa6]
>
> [ 7301.352689] EVL: thread_2 switching in-band [pid=3D6285, excpt=3D14, u=
ser_pc=3D0x7f54a7877fa6]
>
>=20=20
>
> From: Russell Johnson=20
> Sent: Friday, July 1, 2022 11:19 AM
> To: xenomai@lists.linux.dev
> Subject: More details on health monitoring notifications
>
>=20=20
>
> Hello,
>
>=20=20
>
> I have gotten a health monitoring thread going that tracks all the EVL th=
reads running in my app. The goal was to try and figure out what is causing=
 occasional in-band switches in some of my EVL threads. I am seeing the not=
ifications now that give me a little more insight, and the two diagnostic c=
odes I am seeing are 2 (switched inband due to syscall) and 3 (switched inb=
and due to fault). I am finding these to be quite hard to pinpoint
> specifically throughout my code. Is there any way to get more information=
 into what exactly is causing these notifications from the EVL core? It wou=
ld be great to have a callstack of some kind, but I am not sure if that is =
possible. Any insight would be helpful.
>
>=20=20
>
> Thanks,
>
>=20=20
>
> Russell
>
> [[End of S/MIME Signed Part]]


--=20
Philippe.
