Message-ID: <5513E34A.1050207@xenomai.org>
Date: Thu, 26 Mar 2015 11:45:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5513D5DB.9090809@free.fr>
In-Reply-To: <5513D5DB.9090809@free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] heap: bad usage or design problem using named heaps ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>, Xenomai@xenomai.org

On 03/26/2015 10:48 AM, St=E9phane ANCELOT wrote:
> Hi,
>=20
> I faced the following problem with xeno 2.5.x , but may exist on other
> releases .
>

Or may not, since 2.5.x is obsolete (last release on August 2012), or if
this turns to be usage issue.

> 1/ I create a rt_heap
> 2/ in this rh_heap I alloc many named "data area"

Some code is needed to understand the kind of heap your code creates.

> I always give the global rt_heap ptr. no problem, areas are allocated.
>=20
> 3/problem arises when unallocating/unbinding
> using rt_heap_free/rt_heap_unbind.

These routines have very different purposes. Why are you coupling them
in your description of the issue?

> only the last segment created is freed. Because the global heap ptr size
> contains only size of the last allocation.

I don't understand what you mean.

>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> to solve the problem, I had to use a distinct rt_heap for each named
> area, in this case.

What is a "named area" in the context of your application, if not a
separate named heap in single-block mode (H_SINGLE)?

>=20
> At first, I may have misunderstood the way was working rt_heaps ?
> I was thinking I could manage only a heap with many named modules inside
> it...
>=20

Please send a simple code fragment illustrating your use case.

--=20
Philippe.

