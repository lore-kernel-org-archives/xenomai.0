Message-ID: <4B473206.90209@domain.hid>
Date: Fri, 08 Jan 2010 14:24:22 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid> <4B45F163.4000504@domain.hid>
	<4B460255.30200@domain.hid> <4B46125D.4010602@domain.hid>
	<4B471B48.6040301@domain.hid> <4B471D96.7050001@domain.hid>
In-Reply-To: <4B471D96.7050001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0E7CACA06D7E8F7F78A38C80"
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E7CACA06D7E8F7F78A38C80
Content-Type: multipart/mixed;
 boundary="------------090001050701070805010902"

This is a multi-part message in MIME format.
--------------090001050701070805010902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 08.01.2010 12:57, schrieb Gilles Chanteperdrix:
> Stefan Kisdaroczi wrote:
>> Am 07.01.2010 17:57, schrieb Gilles Chanteperdrix:
>>> Stefan Kisdaroczi wrote:
>>>> Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
>>>>> Stefan Kisdaroczi wrote:
>>>>>> hi,
>>>>>>
>>>>>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfa=
ults when I
>>>>>> try to create a task with stacksize 2048, this worked with 2.4.10.=

>>>>>> Because my app is written in pascal i have reproduced the problem =
with the
>>>>>> xenomai trivial-periodic.c example:
>>>>>>
>>>>>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>>>>>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>>>>>
>>>>>> Stacksize 0 -> default stack size : ok
>>>>>> Stacksize > 0 and <=3D 16911 : Segmentation fault
>>>>>> Stacksize >=3D 16912 : ok
>>>>>>
>>>>>> Any hints ?
>>>>> What does the task do? If it uses printf, printf needs a lot of roo=
m on
>>>>> the stack.
>>>>>
>>>> To clarify:
>>>> It does not depend on the task body, the task is not even started.
>>>> The segfault happens when calling rt_task_create(), before rt_task_s=
tart()
>>>> is called.
>>> Actually, when calling rt_task_create, the thread is created, under t=
he
>>> hood, and waits to be started. So the segmentation fault is most
>>> certainly due to a stack overflow in the newly created thread.
>>>
>>> And I am afraid I know why it happens: the newly merged user-space
>>> signals support requires roughly 16 * sizeof(struct siginfo) on stack=
=2E
>>> But this amounts to two Kbytes here. Could you run the following prog=
ram
>>> on your target ?
>>
>> salut gilles,
>>
>> as the stacksize is already checked and increased to PTHREAD_STACK_MIN=
 if
>> the value is too small, i suggest to take the stacksize needed by xeno=
mai
>> into account too. The attached patch is clearly wrong, but it solved t=
he
>> problem for me.
>=20
> PTHREAD_STACK_MIN varies a lot depending on architectures and even
> depending on the glibc versions. Which is why we took 32 Kb as the
> default stack size. Since the default is enough even for struct xnsig,
> if you are asking a smaller size, you may have good reasons to do so. W=
e
> should check that the size is at least sizeof(struct xnsig), but since
> PTHREAD_STACK_MIN is larger than struct xnsig, it should work as is.
>=20
> The point is that your system seems to require 16 Kb whereas
> sizeof(struct xnsig) is only 2Kb. So, there is something wrong somewher=
e
> else.
>=20
> Could you run the segfaulting program inside gdb, and print the frames
> infos ?

gdb logfile attached

kisda

--------------090001050701070805010902
Content-Type: text/plain;
 name="gdb.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gdb.txt"

U3RhcnRpbmcgcHJvZ3JhbTogL2hvbWUvc2tpL3NyYy94ZW5vdGVzdC90cml2aWFsLXBlcmlv
ZGljIApbVGhyZWFkIGRlYnVnZ2luZyB1c2luZyBsaWJ0aHJlYWRfZGIgZW5hYmxlZF0KW05l
dyBUaHJlYWQgMHhiNzViYTZjMCAoTFdQIDIxMzM2KV0KW05ldyBUaHJlYWQgMHhiNzViOWI5
MCAoTFdQIDIxMzM5KV0KClByb2dyYW0gcmVjZWl2ZWQgc2lnbmFsIFNJR1NFR1YsIFNlZ21l
bnRhdGlvbiBmYXVsdC4KW1N3aXRjaGluZyB0byBUaHJlYWQgMHhiNzViOWI5MCAoTFdQIDIx
MzM5KV0KMHhiNzc1Mzc4MyBpbiA/PyAoKSBmcm9tIC9saWIvbGQtbGludXguc28uMgojMCAg
MHhiNzc1Mzc4MyBpbiA/PyAoKSBmcm9tIC9saWIvbGQtbGludXguc28uMgojMSAgMHhiNzc1
OTJlMCBpbiA/PyAoKSBmcm9tIC9saWIvbGQtbGludXguc28uMgojMiAgMHhiNzcxZjdmZCBp
biB4ZW5vX3NpZ3dpbmNoX2hhbmRsZXIgKCkgZnJvbSAvdXNyL2xpYi9saWJuYXRpdmUuc28u
MwojMyAgMHhiNzcxZjhhNiBpbiB4ZW5vX3NpZ3NoYWRvd19oYW5kbGVyICgpIGZyb20gL3Vz
ci9saWIvbGlibmF0aXZlLnNvLjMKIzQgIDxzaWduYWwgaGFuZGxlciBjYWxsZWQ+CiM1ICAw
eGI3NzFlMWUwIGluID8/ICgpIGZyb20gL3Vzci9saWIvbGlibmF0aXZlLnNvLjMKIzYgIDB4
Yjc1YjkzYjggaW4gPz8gKCkKIzcgIDB4Yjc3MjEyMDggaW4gPz8gKCkgZnJvbSAvdXNyL2xp
Yi9saWJuYXRpdmUuc28uMwojOCAgMHhiNzcyMTNjMCBpbiA/PyAoKSBmcm9tIC91c3IvbGli
L2xpYm5hdGl2ZS5zby4zCiM5ICAweGI3NzFmNzAwIGluID8/ICgpIGZyb20gL3Vzci9saWIv
bGlibmF0aXZlLnNvLjMKIzEwIDB4MDAwMDAwMDAgaW4gPz8gKCkKU3RhY2sgZnJhbWUgYXQg
MHhiNzViNzAwODoKIGVpcCA9IDB4Yjc3NTM3ODM7IHNhdmVkIGVpcCAweGI3NzU5MmUwCiBj
YWxsZWQgYnkgZnJhbWUgYXQgMHhiNzViNzAyMAogQXJnbGlzdCBhdCAweGI3NWI2ZmZjLCBh
cmdzOiAKIExvY2FscyBhdCAweGI3NWI2ZmZjLCBQcmV2aW91cyBmcmFtZSdzIHNwIGlzIDB4
Yjc1YjcwMDgKIFNhdmVkIHJlZ2lzdGVyczoKICBlYnAgYXQgMHhiNzViNzAwMCwgZWlwIGF0
IDB4Yjc1YjcwMDQKU3RhY2sgZnJhbWUgYXQgMHhiNzViNzAyMDoKIGVpcCA9IDB4Yjc3NTky
ZTA7IHNhdmVkIGVpcCAweGI3NzFmN2ZkCiBjYWxsZWQgYnkgZnJhbWUgYXQgMHhiNzViNzhh
MCwgY2FsbGVyIG9mIGZyYW1lIGF0IDB4Yjc1YjcwMDgKIEFyZ2xpc3QgYXQgMHhiNzViNzAw
NCwgYXJnczogCiBMb2NhbHMgYXQgMHhiNzViNzAwNCwgUHJldmlvdXMgZnJhbWUncyBzcCBp
cyAweGI3NWI3MDIwCiBTYXZlZCByZWdpc3RlcnM6CiAgZWlwIGF0IDB4Yjc1YjcwMWMKU3Rh
Y2sgZnJhbWUgYXQgMHhiNzViNzhhMDoKIGVpcCA9IDB4Yjc3MWY3ZmQgaW4geGVub19zaWd3
aW5jaF9oYW5kbGVyOyBzYXZlZCBlaXAgMHhiNzcxZjhhNgogY2FsbGVkIGJ5IGZyYW1lIGF0
IDB4Yjc1Yjc5NTAsIGNhbGxlciBvZiBmcmFtZSBhdCAweGI3NWI3MDIwCiBBcmdsaXN0IGF0
IDB4Yjc1Yjc4OTgsIGFyZ3M6IAogTG9jYWxzIGF0IDB4Yjc1Yjc4OTgsIFByZXZpb3VzIGZy
YW1lJ3Mgc3AgaXMgMHhiNzViNzhhMAogU2F2ZWQgcmVnaXN0ZXJzOgogIGVicCBhdCAweGI3
NWI3ODk4LCBlaXAgYXQgMHhiNzViNzg5YwpTdGFjayBmcmFtZSBhdCAweGI3NWI3OTUwOgog
ZWlwID0gMHhiNzcxZjhhNiBpbiB4ZW5vX3NpZ3NoYWRvd19oYW5kbGVyOyBzYXZlZCBlaXAg
MHhiNzc0NTQwYwogY2FsbGVkIGJ5IGZyYW1lIGF0IDB4Yjc1YjdhNTgsIGNhbGxlciBvZiBm
cmFtZSBhdCAweGI3NWI3OGEwCiBBcmdsaXN0IGF0IDB4Yjc1Yjc5NDgsIGFyZ3M6IAogTG9j
YWxzIGF0IDB4Yjc1Yjc5NDgsIFByZXZpb3VzIGZyYW1lJ3Mgc3AgaXMgMHhiNzViNzk1MAog
U2F2ZWQgcmVnaXN0ZXJzOgogIGVicCBhdCAweGI3NWI3OTQ4LCBlaXAgYXQgMHhiNzViNzk0
YwpTdGFjayBmcmFtZSBhdCAweGI3NWI3YTU4OgogZWlwID0gMHhiNzc0NTQwYyBpbiBfX2tl
cm5lbF9ydF9zaWdyZXR1cm47IHNhdmVkIGVpcCAweGI3NzFlMWUwCiBjYWxsZWQgYnkgZnJh
bWUgYXQgMHhiNzViN2E1YywgY2FsbGVyIG9mIGZyYW1lIGF0IDB4Yjc1Yjc5NTAKIEFyZ2xp
c3QgYXQgdW5rbm93biBhZGRyZXNzLgogTG9jYWxzIGF0IHVua25vd24gYWRkcmVzcywgUHJl
dmlvdXMgZnJhbWUncyBzcCBpcyAweGI3NWI3YTU4CiBTYXZlZCByZWdpc3RlcnM6CiAgZWF4
IGF0IDB4Yjc1YjdhMWMsIGVjeCBhdCAweGI3NWI3YTE4LCBlZHggYXQgMHhiNzViN2ExNCwg
ZWJ4IGF0IDB4Yjc1YjdhMTAsCiAgZWJwIGF0IDB4Yjc1YjdhMDgsIGVzaSBhdCAweGI3NWI3
YTA0LCBlZGkgYXQgMHhiNzViN2EwMCwgZWlwIGF0IDB4Yjc1YjdhMjgKU3RhY2sgZnJhbWUg
YXQgMHhiNzViN2E1YzoKIGVpcCA9IDB4Yjc3MWUxZTA7IHNhdmVkIGVpcCAweGI3NWI5M2I4
CiBjYWxsZWQgYnkgZnJhbWUgYXQgMHhiNzViN2E2MCwgY2FsbGVyIG9mIGZyYW1lIGF0IDB4
Yjc1YjdhNTgKIEFyZ2xpc3QgYXQgMHhiNzViN2E1NCwgYXJnczogCiBMb2NhbHMgYXQgMHhi
NzViN2E1NCwgUHJldmlvdXMgZnJhbWUncyBzcCBpcyAweGI3NWI3YTVjCiBTYXZlZCByZWdp
c3RlcnM6CiAgZWlwIGF0IDB4Yjc1YjdhNTgKU3RhY2sgZnJhbWUgYXQgMHhiNzViN2E2MDoK
IGVpcCA9IDB4Yjc1YjkzYjg7IHNhdmVkIGVpcCAweGI3NzIxMjA4CiBjYWxsZWQgYnkgZnJh
bWUgYXQgMHhiNzViN2E2NCwgY2FsbGVyIG9mIGZyYW1lIGF0IDB4Yjc1YjdhNWMKIEFyZ2xp
c3QgYXQgMHhiNzViN2E1OCwgYXJnczogCiBMb2NhbHMgYXQgMHhiNzViN2E1OCwgUHJldmlv
dXMgZnJhbWUncyBzcCBpcyAweGI3NWI3YTYwCiBTYXZlZCByZWdpc3RlcnM6CiAgZWlwIGF0
IDB4Yjc1YjdhNWMKU3RhY2sgZnJhbWUgYXQgMHhiNzViN2E2NDoKIGVpcCA9IDB4Yjc3MjEy
MDg7IHNhdmVkIGVpcCAweGI3NzIxM2MwCiBjYWxsZWQgYnkgZnJhbWUgYXQgMHhiNzViN2E2
OCwgY2FsbGVyIG9mIGZyYW1lIGF0IDB4Yjc1YjdhNjAKIEFyZ2xpc3QgYXQgMHhiNzViN2E1
YywgYXJnczogCiBMb2NhbHMgYXQgMHhiNzViN2E1YywgUHJldmlvdXMgZnJhbWUncyBzcCBp
cyAweGI3NWI3YTY0CiBTYXZlZCByZWdpc3RlcnM6CiAgZWlwIGF0IDB4Yjc1YjdhNjAKU3Rh
Y2sgZnJhbWUgYXQgMHhiNzViN2E2ODoKIGVpcCA9IDB4Yjc3MjEzYzAgaW4geGVub19zaWdz
aGFkb3dfaW5zdGFsbGVkOyBzYXZlZCBlaXAgMHhiNzcxZjcwMAogY2FsbGVkIGJ5IGZyYW1l
IGF0IDB4Yjc1YjdhNmMsIGNhbGxlciBvZiBmcmFtZSBhdCAweGI3NWI3YTY0CiBBcmdsaXN0
IGF0IDB4Yjc1YjdhNjAsIGFyZ3M6IAogTG9jYWxzIGF0IDB4Yjc1YjdhNjAsIFByZXZpb3Vz
IGZyYW1lJ3Mgc3AgaXMgMHhiNzViN2E2OAogU2F2ZWQgcmVnaXN0ZXJzOgogIGVpcCBhdCAw
eGI3NWI3YTY0ClN0YWNrIGZyYW1lIGF0IDB4Yjc1YjdhNmM6CiBlaXAgPSAweGI3NzFmNzAw
IGluIHhlbm9fc2lnc2hhZG93X2luc3RhbGw7IHNhdmVkIGVpcCAweDAKIGNhbGxlZCBieSBm
cmFtZSBhdCAweGI3NWI3YTcwLCBjYWxsZXIgb2YgZnJhbWUgYXQgMHhiNzViN2E2OAogQXJn
bGlzdCBhdCAweGI3NWI3YTY0LCBhcmdzOiAKIExvY2FscyBhdCAweGI3NWI3YTY0LCBQcmV2
aW91cyBmcmFtZSdzIHNwIGlzIDB4Yjc1YjdhNmMKIFNhdmVkIHJlZ2lzdGVyczoKICBlaXAg
YXQgMHhiNzViN2E2OApTdGFjayBmcmFtZSBhdCAweGI3NWI3YTcwOgogZWlwID0gMHgwOyBz
YXZlZCBlaXAgMHgwCiBjYWxsZXIgb2YgZnJhbWUgYXQgMHhiNzViN2E2YwogQXJnbGlzdCBh
dCAweGI3NWI3YTY4LCBhcmdzOiAKIExvY2FscyBhdCAweGI3NWI3YTY4LCBQcmV2aW91cyBm
cmFtZSdzIHNwIGlzIDB4Yjc1YjdhNzAKIFNhdmVkIHJlZ2lzdGVyczoKICBlaXAgYXQgMHhi
NzViN2E2YwpUaGUgcHJvZ3JhbSBpcyBydW5uaW5nLiAgRXhpdCBhbnl3YXk/ICh5IG9yIG4p
IA==
--------------090001050701070805010902--

--------------enig0E7CACA06D7E8F7F78A38C80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLRzIGIPTw9rIdn6oRAkPtAJ9mDYV8UyV6qpYIbFPRiF2q0w3+MwCfTuRi
iM20dPccNBSRj8HRkxQUcLE=
=0Bbg
-----END PGP SIGNATURE-----

--------------enig0E7CACA06D7E8F7F78A38C80--

