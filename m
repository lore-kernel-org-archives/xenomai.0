Message-ID: <4773DC48.9090001@domain.hid>
Date: Thu, 27 Dec 2007 18:09:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>	
	<18290.62470.714603.940223@domain.hid>	
	<47739370.8000803@domain.hid>	
	<2ff1a98a0712270505j6ecfa48dj36c673c0a40ca574@domain.hid>	
	<4773C03C.9090207@domain.hid>
	<2ff1a98a0712270725s7ba0b058wac469f2219566793@domain.hid>
In-Reply-To: <2ff1a98a0712270725s7ba0b058wac469f2219566793@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFBD04EA6D4B67EF4DED0FEC9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Auto closing of file descriptors and fork.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFBD04EA6D4B67EF4DED0FEC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On Dec 27, 2007 4:09 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> On Dec 27, 2007 12:58 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>  > Hi,
>>>>>  >
>>>>>  > I have a problem with auto closing of file descriptors and fork.=
 I
>>>>>  > have an application (a modified pppd, to name it), which in a ce=
rtain
>>>>>  > mode (pppd "updetach" mode) opens some real-time file descriptor=
s,
>>>>>  > forks and exit the parent, continuing to use the file descriptor=
s in
>>>>>  > the child. The problem is that when exiting the parent, file
>>>>>  > descriptors are automatically destroyed and therefore can not be=
 used
>>>>>  > in the child.
>>>>>  >
>>>>>  > Any ideas for a fix ?
>>>>>
>>>>> More precisely. We need to trap the "fork" event, and handle it in =
the
>>>>> skins event callbacks. We will need to create a new ppd structure f=
or
>>>>> the new process, but what will we do with the skin objects ? If we =
keep
>>>>> the same objects for the child and increment a reference count, we =
will
>>>>> end up with an object that need to be inserted in two per-process
>>>>> lists. If we create new objects, how will we manage for user-space
>>>>> references (inherited accross fork) to remain valid ?
>>>> The only way I see are process-private file descriptor tables +
>>>> reference counters for the underlying objects. On fork, the descript=
or
>>>> table would be cloned and the reference counter of the contained obj=
ect
>>>> would be incremented, creating another reference to them. Or should =
we
>>>> rather re-open those objects, creating another instance?
>>> That is essentially the two alternatives I propose.
>>>
>>> The problem when cloning the file descriptor table is that if there i=
s
>>> an xnholder_t (or something similar) in a file descriptor object, the=

>>> file descriptor can only be linked to one table.
>> Hmm, where is there difference between this cloning and "normal"
>> multi-threaded usage? The only difference I see is that there are now
>> two separated address spaces from the user perspective. But for the
>> kernel, it stays the same.
>=20
> If there are two ppds, there are two lists (or hash table, or whatever
> data structure). So, we now have an object, with only one xnholder_t
> (or list_head) that must be in two lists. This does not work.

At least for RTDM, objects that are addressed via file descriptors are
not managed in ppd tables. Instead, the descriptor table already
contains enough information to find those objects on process
termination. At the moment, there is an owner field in the object
required to tell the ownerships apart. With process-private descriptor
tables this field would become obsolete.

>=20
>>> The problem of re-opening the objects is that the user-space
>>> references to the re-opened object should be updated. It is impossibl=
e
>>> for a file descriptor.
>> The only user space reference is the file descriptor - an index. And a=
s
>> this index stays the same across the fork, I don't see the problem.
>=20
> The user-space file descriptor is __rtdm_fd_start + kernel-space file
> descriptor. If you re-open an object, you will obtain a new
> kernel-space file descriptor, and hence a different user-space file
> descriptor. So, no, the index will not stay the same across the fork.

Not with the current implementation, true. But as I said: the
prerequisite for fork-persistent file descriptors are process-private
descriptor tables anyway. And at that point, the indexes will stay the sa=
me.

Jan


--------------enigFBD04EA6D4B67EF4DED0FEC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHc9xMniDOoMHTA+kRAofkAJ907pvdQDu3GNi6ma7f3EFsA+OslQCeLgu0
nlc/ob4qhb3swpZLRUkKjdY=
=6spy
-----END PGP SIGNATURE-----

--------------enigFBD04EA6D4B67EF4DED0FEC9--

