Content-Disposition: inline
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
Date: Tue, 14 Feb 2006 11:14:23 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200602141114.23856.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Em Ter=3DE7a 14 Fevereiro 2006 05:55, voc=3DEA escreveu:
>Rodrigo Rosenfeld Rosas wrote:
>> Jan Kiszka escreveu:
>>> Rodrigo Rosenfeld Rosas wrote:
>>>> Jan Kiszka escreveu:
>>>>> Ok, but even if you decide to let rt-mmap be non-deterministic, you
>>>>> still need some means to prevent the scenario you described above.
>>>>> Actually, all you need is some callback when the mapped memory block
>>>>> was
>>>>> actually released (munmap/application exit). Such a callback can be
>>>>> registered inside the rtdm_mmap handler as a vma_fileop.
>>>>
>>>> I have never worked with vma_fileop... I would need to learn it first.
>>>
>>> Here is the patch to offer you access to those ops. Revert the previous
>>> version, then apply this one.
>>
>> Actually I would have to revert the modifications I had to do for the
>> patch to apply (some rejected chunks). But I think I'll update to the
>> last SVN xenomai. BTW, is this patch for the SVN or 2.1 or 2.0.2
>> xenomai? Or it would apply for all of them?
>
>Developed and tested against 2.1. The current patch will not cleanly
>apply against 2.0.

Ok, it already applied cleanly on last svn version. I'll reboot my computer
and test it. That is something I didn't like in 2.1 series... I always have
to recompile the kernel and to reboot when a new xenomai release is availab=
=3D
le
(unless I'm missing something)... On the previous series I just compiled it
as modules and it was only necessary to recompile the kernel when a new ade=
=3D
os
(ipipe) version was available...

>>> It still needs some final documentation
>>> notes and a test on kernel 2.4. But is should already work on 2.6.
>>
>> I forgot to mention, I have one more problem. Since I call mmap on
>> driver initialization (thus before any rtdm_dev_open), I do not have any
>> rtdm_user_info_t, so I need to use current instead, but I'm not sure if
>> this will work. Maybe mmap needs the 'current' struct of the user
>> program... I don't know this very well... If that is true, so I'll have
>> to do the maps in a non-rt context anyway...
>
>You cannot mmap before you know precisely for which user this should
>take place.

Do you mean that if I use the 'current' and current->mm struct of the drive=
=3D
r,
when mmaping, the user won't be able to use the returned pointer?

>During init, it's the insmod/modprobe process - likely not
>the one you are interested in.

Actually, that is the way I was planning for making the maping in a
deterministic way...

>So the earliest point for mmap is device
>open. If this is too late for you, then now finally forget about this
>pre-mmapping and turn it into a normal function for secondary mode. It
>will be hard anyway to find a user who will notice the difference.

That is not a question of noting any difference or not... An application can
works great most of the time but it can fail under some not common
circunstances. The user will need to know, at least, that he will can not
rely on rt-capabilities when doing that and will be forced to do that only =
=3D
on
initialization. But that is ok for most cases. I think I'll do that (I do n=
=3D
ot
have other options at all :) ).

Thanks,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


