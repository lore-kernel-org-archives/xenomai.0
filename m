Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFB2562
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 15:57:39 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5638A240008;
	Mon, 20 Jun 2022 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1655740657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UQKetNkkPlfofagzf1PDxm9XPK64hk+e8fIozI9CCo=;
	b=SXMcOtItWe6Vq08Rwh5m4XcgF6jvL7dnyndtzXGM6O2PmmZ/YzGo5aV6hC4JeumD4Y51X6
	BSJRmKvxAf0mCHN1/MdQNAHsbY5OjXNY3CPUnXy82SH+CijhdLCDzijq4A7Fqy2Td2m4Iz
	pF4hbv4Qe8a3MRdDalGo2s7vA+2OOKEO/ssqdTWytwS/cd642Vel5p+ILMavk0xFOawY/z
	OzbfSzn6+zStwSxvt3+0SCHb5HlJy9JnH+obenIUba5z4BeD70MBWQPZAHkNn/c6Y6Zv5S
	w7TmnmlPwDXYnollTno9oyVs/MZI5sxkNxDPuIJtkxGWp5rSEIHvSKpDvMIWRA==
References: <PH1P110MB1050B18C8CE66B077B50B31CE2B09@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Interrupts
Date: Mon, 20 Jun 2022 17:42:32 +0200
In-reply-to: <PH1P110MB1050B18C8CE66B077B50B31CE2B09@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87pmj3iaz3.fsf@xenomai.org>
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
>> The recommended way with EVL is to follow the common patterns used for
>
>> developing regular linux drivers, except that the EVL kernel API must be
>
>> used instead of the regular/in-band kernel API for anything which wants
>
>> to synchronize threads over the oob stage.
>
>>
>
>=20=20
>
>> Typically, you could share an EVL semaphore [1] or an event flag group
>
>> [2] between the interrupt handler and the oob_ioctl() or oob_read()
>
>> call, which would block the user-space task until the matching event
>
>> happens. To monitor complex events, you could use an EVL wait queue
>
>> instead of a semaphore or a flag.
>
>>
>
>=20=20
>
>> If you need to monitor multiple event sources in userland, you can use
>
>> the EVL poll API [4] with the file descriptors you would otherwise pass
>
>> to the oob_{ioctl, read, write}() calls.
>
>>
>
>=20=20
>
>> [1] https://evlproject.org/core/user-api/semaphore/
>
>> [2] https://evlproject.org/core/user-api/flags/
>
>> [3] https://evlproject.org/core/kernel-api/wait/
>
>> [4] https://evlproject.org/core/user-api/poll/
>
>>
>
>=20=20
>
>> --=20
>
>> Philippe.
>
>=20=20
>
> If I create an EVL semaphore or event flag group on the userspace side (u=
sing the libevl API), how would I go about passing a reference to that down=
 to the kernel driver (through ioctl)? Wouldn=E2=80=99t the kernel driver n=
eed to know what a =E2=80=9Cstruct evl_sem=E2=80=9D or a =E2=80=9Cstruct ev=
l_flags=E2=80=9D is? But those are defined in the libevl usersapce API and =
the kernel does not have access to those headers from what I can see.
>
>=20=20
>

You could export the file structure of a userland object to a kernel
driver, but this is not the recommended way, especially since this would
require to deal with the lifetime of those objects using the internal
EVL API in kernel space.

The proper way for an application is to create a kernel semaphore/flag,
post it from kernel space (e.g. from an interrupt handler), pend on it
from an oob_ioctl/oob_read handler typically.

The sequence would be as follows:

1. the user task issues oob_ioctl(fd, IOC_WAIT_FOO) or oob_read(fd),
which invokes the corresponding oob_ioctl and/or oob_read handlers in
the kernel driver.

2. Those handlers call e.g. evl_down() on the kernel sem, which the
interrupt handler can post using evl_up() at some point in order to
signal the event. Conversely, the user task would wait for such event,
sleeping in kernel context until it occurs.

--=20
Philippe.
