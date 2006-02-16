From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
Date: Thu, 16 Feb 2006 15:14:44 -0200
References: <200602141114.23856.lbocseg@domain.hid> <43F2761D.2050702@domain.hid>
	<200602151253.05341.lbocseg@domain.hid>
In-Reply-To: <200602151253.05341.lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602161514.44451.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Em Quarta 15 Fevereiro 2006 12:53, Rodrigo Rosenfeld Rosas escreveu:

>Em Ter=3DE7a 14 Fevereiro 2006 22:30, Jan Kiszka escreveu:
>>...
>>
>>>> You cannot mmap before you know precisely for which user this should
>>>> take place.
>>>
>>> Do you mean that if I use the 'current' and current->mm struct of the
>>> driver, when mmaping, the user won't be able to use the returned pointe=
=3D
r?
>>
>>To mmap you need to know the target process, more precisely its mm. This
>>is typically derived from the invocation context of the service call
>>("current" is a pointer to the current process). But init_module runs in
>>the context of modprobe. Even worse, the process later opening and
>>mapping some buffer may not even exist at that time!
>
>Right, I've already verified this on practice... I'm mmaping on open handl=
=3D
er
>for now just for testing the mmap, but I'll change it to the ioctl mmap
>handler.
>
>It seems to work. I mapped high_memory and could read and modify it from
> user space. The memory values mantained betweens the many open calls. I
> read, printed the values and increment them by one. On next time, the val=
=3D
ue
> shown was incremented... All seems perfect but I still didn't test with
> real acquire code... When I do so, I'll let you know.
>
>I still need to test the vmaops. I think I'll test them tomorrow. I need to
>begin writing an article that my advisor asked me to. I need to finish it
>until march, 10.

Ok, I tested the vmaops too and it also worked as expected. I think you cou=
=3D
ld=3D20
merge rtdm_mmap and related stuff to mainline RTDM. Thank you for your=3D20
precious work. Unfortunately you'll need to wait a while until I test them =
=3D
on=3D20
the real video driver. I had to stop working on it for writing the article.=
=3D
=3D20
When I finish the article I'll test them on real hardware but I see no=3D20
reasons for not working...

Best Regards,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


