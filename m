Date: Wed, 14 Oct 2015 12:21:25 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <646804237.361502.1444825285470.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <561E31CA.1080008@xenomai.org>
References: <561E31CA.1080008@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_heap_alloc size 0 - syscall 7 denied
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Wednesday, 14 October 2015, 12:43, Philippe Gerum <rpm@xenomai.org> wr=
ote:
>On 10/14/2015 12:22 PM, Frederik Bayart wrote:
>> Hallo,
>> I'm using xenomai 3.0 on kernel 3.18.20 (64 bit).
>>
>> When using single block heap, I'm getting memory allocation problem when=
 calling rt_heap_alloc with size 0. I don't get the error when calling the =
function with size used in rt_heap_create.
>> On the mailing list, I found there has been an issue with this in May : =
http://www.xenomai.org/pipermail/xenomai/2015-May/034165.html
>> Is this still an issue ?
>
>No, this one is long gone.
>
>>
>> In attachment a test program htest.c + makefile to generate the problem =
:
>>
>> $ sudo ./htest 1=C2=A0 =3D=3D> use 0
>> htest.c:69: heapsize =3D 70000, usablemem =3D 70144, usedmem =3D 0
>> htest.c:79 ERROR: rt_heap_alloc(-12): Cannot allocate memory
>>
>> $ sudo ./htest 1=C2=A0 =3D=3D> use same size as in create
>> htest.c:69: heapsize =3D 70000, usablemem =3D 70144, usedmem =3D 0
>> htest.c:92: heapsize =3D 70000, usablemem =3D 70144, usedmem =3D 70144
>>
>
>Does this help?
>
>diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
>index 20531e3..146bfa1 100644
>--- a/lib/alchemy/heap.c
>+++ b/lib/alchemy/heap.c
>@@ -442,7 +442,9 @@ int rt_heap_alloc_timed(RT_HEAP *heap,
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D __mptr(hcb->sba);
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto do=
ne;
>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size > 0 && size !=3D hcb-=
>size) {
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size =3D=3D 0)
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =
=3D heapobj_size(&hcb->hobj);
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (size !=3D hcb->size) =
{
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -EINVAL;
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto do=
ne;
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>

After code reading, could it be that the exception for size =3D=3D 0 has di=
sappeared in the released code ?

=C2=A0 if (hcb->mode & H_SINGLE) {
=C2=A0=C2=A0=C2=A0 p =3D __mptr(hcb->sba);
=C2=A0=C2=A0=C2=A0 if (p)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
=C2=A0=C2=A0=C2=A0 if (size > 0 && size !=3D hcb->size) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 p =3D heapobj_alloc(&hcb->hobj, size);
=C2=A0=C2=A0=C2=A0 if (p =3D=3D NULL) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 hcb->sba =3D __moff(p);
=C2=A0=C2=A0=C2=A0 goto done;
=C2=A0 }


And if size is 0, alloc_block returns NULL so ENOMEM is returned.


>> However, I both cases, I get a trace in dmesg :
>>
>> [Xenomai] syscall <7> denied to sysregd
>
>That one is a different issue. Does your application have supervisor or
>user privileges?
>

I'm running the application as root. Is this the question ?

>--=20
>Philippe.

Frederik
