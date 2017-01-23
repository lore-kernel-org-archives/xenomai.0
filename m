References: <CAJEimAzwYvDuHkSeEzUibkg8oZHX1QNqUNgAzh5SM_+8sPM_vA@mail.gmail.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <968e3268-5567-1bb6-dc34-55f9ec73a2ae@numalliance.com>
Date: Mon, 23 Jan 2017 11:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAJEimAzwYvDuHkSeEzUibkg8oZHX1QNqUNgAzh5SM_+8sPM_vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Looking for help regarding implementing shared memory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Le 22/01/2017 =C3=A0 05:12, =EC=9D=B4=EC=84=9D=ED=9B=88 a =C3=A9crit :
> Hi All,
>
> I'm new to Xenomai and RT in general. I have some trouble using rtheap
> functions.
>
> Xenomai version I'm using is 3.0.2 (no ipipe patch), with linux kernel
> 4.1.18, I'm using Cobalt mode, and using native skin when building.
>
> I'm trying to use shared memory and it is not working.
>
> On program A, I call
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> int err;
>      rt_printf("heap create start\n");
>
>      err =3D rt_heap_create(&heap_desc, "SHM001", 1024, H_SINGLE | H_NO=
NCACHED
> | H_SHARED);
Hi,
that does not conform to 3.0 syntax :
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alche=
my__heap.html#ga1d19ad24dc9f94b969aa0f574170bdc4
H_FIFO|H_SINGLE should be right
Regards,
S.Ancelot
>      if(err<0) rt_printf("create_error =3D %d\n", err);
>
>      rt_heap_bind(&heap_desc, "SHM001", TM_INFINITE);
>
>      err =3D rt_heap_alloc(&heap_desc, 0, TM_INFINITE, &shm_area);
>      if(err<0) rt_printf("alloc error =3D %d\n", err);
>      rt_printf("rt_heap_alloc got : %x\n", shm_area);
>      char myString[10] =3D "test\0";
>
>      memcpy(shm_area, myString, 5);
>
>      rt_printf("heap create end\n");
>
> and this works fine, on program B, I call
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      RT_HEAP desc;
>      void *shm;
>
>      int err;
>
>      rt_printf("heap create start\n");
>      err =3D rt_heap_bind(&desc, "SHM001", TM_INFINITE);
>
>      if(err) rt_printf("failed: %d\n", err);
>
>      err =3D rt_heap_alloc(&desc, 0, TM_INFINITE, &shm);
>      if(err) rt_printf("alloc failed: %d\n", err);
>
>      rt_printf("heap create end\n");
>      rt_printf("content:: %s\n", shm);
>
> and rt_heap_bind would not go. When I try this using TM_NONBLOCK, it
> returns -11 and it looks like program B cannot find the symbol "SHM001"
>
> Could you help me with this? I think there should be anything I'm missi=
ng
> and I cannot find any logs from kern.log or syslog which I can use.
>
> Thank you very much.
> Koon
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

