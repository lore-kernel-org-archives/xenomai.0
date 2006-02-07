From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Tue, 7 Feb 2006 17:22:06 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
In-Reply-To: <43E8DB10.5000901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602071722.06921.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan, thank you for your precious code! :)

But, while it is executed in Linux context, ie, in a non-rt context, I coul=
=3D
d=3D20
register a normal Linux file descriptor and call mmap on it. Or I could mma=
=3D
p=3D20
the device /dev/mem for mapping the memory region I would need. I can obtai=
=3D
n=3D20
the absolute address from a RTDM ioctl call.

Anyway, I'll be missing the V4L2 compatibility but that is not a great issu=
=3D
e.=3D20
But since I only need to call this on initialization, I don't need to be in=
=3D
=3D20
RT-context in my specific application. But since I'm also developing a=3D20
robotic programming framework it would be nice to have this mmap capability=
=3D
=3D20
in real-time context.

But thank you anyway. I really appreciate your code.

Best regards,

Rodrigo.

____________________________________________________________
Em Ter=3DE7a 07 Fevereiro 2006 15:38, Jan Kiszka escreveu:

>[snmp on web.de down, switching account]
>
>Rodrigo Rosenfeld Rosas wrote:
>> Hi Jan,
>>
>>> ...
>>> What precisely? I suggested to look at remap_pfn_range() or
>>> io_remap_page_range(). Do you see problems when using one of them?
>>
>> This is the function prototype:
>>
>> int remap_pfn_range(struct vm_area_struct *vma,
>> unsigned long virt_addr, unsigned long pfn,
>> unsigned long size, pgprot_t prot);
>>
>> When a mmap call is issued, the vma structure is already initially fille=
=3D
d.
>> I don't know how to fill it and LDD3 doesn't explain it:
>>
>> "The arguments to remap_pfn_range are fairly straightforward, and most of
>> them are already provided to you in the VMA when your mmap method is
>> called."
>>
>> "Note that the kernel maintains lists and trees of VMAs to optimize area
>> lookup, and several fields of vm_area_struct are used to maintain this
>> organization. Therefore, VMAs can?t be created at will by a driver, or t=
=3D
he
>> structures break."
>>
>> So, I don't know how to implement a mmap like ioctl. Any sugestions?
>
>Well, I have to say sorry. I was obviously too optimistic about an easy
>way to implement mmap-features outside a mmap handler. It's far more
>complex.
>
>Ok, we need some helper function in RTDM to make life easier for
>driver developers. Attached is a draft to implement
>
>void *rtdm_mmap_to_user(void *buffer, size_t length);
>
>It can only be invoked on continuous kernel memory (kmalloc'ed or
>ioremap'ped), but this should be sufficient for the intended
>applications. And it only runs in Linux context of course.
>
>I tested it (after figuring out what to do at all, and how to get it
>working then...) with a simple demo that returns a shared kernel memory
>block, mapped into user-space via an RTDM-IOCTL. I think you should
>easily (now really!) adapt it to your needs. Please check if this
>functions meets your requirements and works for more than one scenario.
>If so, I will add it to official RTDM.
>
>
>@all: I would be curious to hear any comment on my /dev/zero-trick to
>invoke mmap in kernel-space. Is this an ugly hack or may it be worth
>considering to apply on /dev/rtheap as well - to overcome the need for
>this device (and related user errors...)?
>
>Jan

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


