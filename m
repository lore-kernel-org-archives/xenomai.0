References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
 <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
 <5B1EDD8E.2010707@freyder.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6d63abf1-0b15-5c55-5ab5-f0f424848dd3@xenomai.org>
Date: Tue, 12 Jun 2018 08:39:49 +0200
MIME-Version: 1.0
In-Reply-To: <5B1EDD8E.2010707@freyder.net>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Performance issue with memory allocators
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/11/2018 10:37 PM, Steve Freyder wrote:
> On 6/8/2018 7:48 AM, Philippe Gerum wrote:
>> On 05/20/2018 08:15 PM, Philippe Gerum wrote:
>>> On 04/27/2018 08:23 PM, Philippe Gerum wrote:
>>>> After a comprehensive series of tests, it is now obvious that
>>>> heapobj-pshared has gruesome performances when releasing bursts of
>>>> small-sized objects. Allocation of large objects is not particularly
>>>> efficient either, although not as bad. The Cobalt core allocator is
>>>> affected by the same bug too.
>>>>
>>>> Those new tests are available from the wip/heapmem branch, they are
>>>> based on the smokey framework (e.g. smokey --run=3Dmemory_* --verbose=
=3D2).
>>>>
>>>> Work is ongoing into the wip/heapmem branch to fix the mess, first
>>>> addressing the issue with the core (in-kernel) allocator,
>>>> heapobj-pshared next. Please note that wip/heapmem is a development
>>>> branch I'm working on for testing improvements - hopefully - to the
>>>> memory allocators, which should not be used in production.
>>>>
>>>> I would strongly recommend that users running single-process
>>>> applications - i.e. not needing the shared heap feature - make sure to
>>>> turn off heapobj-pshared when configuring, by passing --disable-pshared
>>>> to the configuration script (or leave the feature to the default off s=
tate).
>>>>
>>>> As the benchmark figures show when running 'memory_pshared', the shared
>>> memory allocator still needs to be fixed. This is next on my list.
>> The pshared allocator is now fixed in the next branch.
>>
> I tried to build with the -next branch, I'm not sure if I'm doing
> something wrong, but I'm getting the errors below.=A0 I thought perhaps
> the "struct shared_heap" should have been "struct shared_heap_memory",
> so I made that change, and that resulted in the second set of errors
> shown below that, then I decided time to post to the group:
>=20
> Thanks,
> Steve
>=20
> ------------------------------------------------------------------------
>=20
> make[3]: Entering directory
> '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
> =A0 CC=A0=A0=A0=A0=A0=A0 regd.o
> =A0 CC=A0=A0=A0=A0=A0=A0 fs-common.o
> In file included from
> ../../../../../xenomai-3/include/cobalt/wrappers.h:21:0,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
> /home/sdf/xenobuild/imx-xenomai/xenomai-3/include/cobalt/time.h:26,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
> /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/sys/typ=
es.h:132,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:19:
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
> =E2?~open_heaps=E2?T:
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10: error:
> dereferencing pointer to incomplete type =E2?~struct shared_heap=E2?T
> =A0=A0 heap =3D container_of(obj, struct shared_heap, memspec);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10: error:
> initialization from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
> =A0=A0 heap =3D container_of(obj, struct shared_heap, memspec);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
> In file included from
> /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/string.=
h:32:0,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
> ../../../../../xenomai-3/include/copperplate/heapobj.h:24,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:27:
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:35: error:
> invalid use of undefined type =E2?~struct shared_heap=E2?T
> =A0=A0 heap =3D container_of(obj, struct shared_heap, memspec);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
> ------------------------------------------------------------------------
> This is with "struct shared_heap" changed to "struct shared_heap_memory":
>=20
> make[3]: Entering directory
> '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
> =A0 CC=A0=A0=A0=A0=A0=A0 regd.o
> =A0 CC=A0=A0=A0=A0=A0=A0 fs-common.o
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
> =E2open_heaps=E2:
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:249:17: error:
> =E2struct shared_heap_memory=E2 has no member named =E2ubytes=E2
> =A0=A0 p->used =3D heap->ubytes;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:250:18: error:
> =E2struct shared_heap_memory=E2 has no member named =E2total=E2
> =A0=A0 p->total =3D heap->total;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
> Makefile:472: recipe for target 'fs-common.o' failed
> make[3]: *** [fs-common.o] Error 1
>=20

This may help:

diff --git a/lib/copperplate/regd/fs-common.c b/lib/copperplate/regd/fs-com=
mon.c
index ef2e6dae9..e0bdd3d04 100644
--- a/lib/copperplate/regd/fs-common.c
+++ b/lib/copperplate/regd/fs-common.c
@@ -211,8 +211,8 @@ int open_heaps(struct fsobj *fsobj, void *priv)
 {
 	struct sysgroup_memspec *obj, *tmp;
 	struct heap_data *heap_data, *p;
+	struct shared_heap_memory *heap;
 	struct fsobstack *o =3D priv;
-	struct shared_heap *heap;
 	int ret, count, len =3D 0;
=20
 	ret =3D heapobj_bind_session(__copperplate_setup_data.session_label);
@@ -244,10 +244,10 @@ int open_heaps(struct fsobj *fsobj, void *priv)
 	for_each_sysgroup(obj, tmp, heap) {
 		if (p - heap_data >=3D count)
 			break;
-		heap =3D container_of(obj, struct shared_heap, memspec);
+		heap =3D container_of(obj, struct shared_heap_memory, memspec);
 		namecpy(p->name, heap->name);
-		p->used =3D heap->ubytes;
-		p->total =3D heap->total;
+		p->used =3D heap->used_size;
+		p->total =3D heap->usable_size;
 		p++;
 	}

--=20
Philippe.

