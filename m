Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
Date: Tue, 11 Jul 2006 08:09:28 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F9204@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

>=20
> First of all, I'm not sure if that 8K of stack is enough on=20
> PPC with 2.4, on x86 over 2.6 it isn't. The native skin picks=20
> PTHREAD_STACK_MIN*4 for you by default. Is this too much?=20
> Unless dealing with dozens of
> *simple* threads, reducing this makes no sense to me.

?? Greping for PTHREAD_STACK_MIN xenomai/posix/pthread.h tells me,=20
it is 1024. 1024*4=3D4096. This is less than 8192 ;-)
Is there a differnce between x86 and PPC.
(I simply did not realize that there is a default value for=20
the stacksize. Therfore I choose my own value, which was based on my=20
vxWorks experince)


>=20
> Then there was this bug:
>=20
> @@ -168,13 +169,13 @@
>  void root_thread_exit(void)
>  {
>     int i;
> -   RT_HEAP_INFO *hpinfo;
> +   RT_HEAP_INFO hpinfo;
>=20
>     printf("UDP->root_thread_exit\n");
>=20
>     for(i=3D0;i<MAXHEAPBLOCKS;i++)
>     {
> -      if( !rt_heap_inquire(&bigheap[i],hpinfo) )
> +      if( !rt_heap_inquire(&bigheap[i],&hpinfo) )
>           rt_heap_delete(&bigheap[i]);
>     }

Thank you ! 4 eyes see more than 2.
(but this is probably not the reason for the segmentation fault, as=20
this routine is called for exit only !?)
But even after correcting this error, I get segmentation faults (not
with=20
the first start but with the second or third)


>=20
> Now I get some other strange effects (e.g. kernel oopses after OOM
> oopses) that need a closer look under qemu later.

Thanks a lot.

Roderik

