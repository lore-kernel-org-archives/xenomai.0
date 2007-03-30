Message-ID: <460D1BF8.3010904@domain.hid>
Date: Fri, 30 Mar 2007 16:17:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <460C60E9.6010307@domain.hid> <E1HXG3e-0006Jz-Rb@domain.hid>
	<460D0246.5030108@domain.hid> <E1HXGoZ-000163-Vn@domain.hid>
In-Reply-To: <E1HXGoZ-000163-Vn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig317CA732E1903C408F423952"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: iovec overwriting by CAN stack
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig317CA732E1903C408F423952
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi Wolfgang,
>>>>>>
>>>>>> it's late, so I may have misread somecode, but don't you "update" =
the
>>>>>> iovec descriptors a user passes on send/recvmsg on return (namely
>>>>>> iovec_len)? I received some complaints about this /wrt to in-kerne=
l
>>>>>> CAN stack usage.
>>>>> It's done here:
>>>>>
>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/=
rtca
>>>>> n_ raw.c?v=3DSVN-trunk#881
>>>>>
>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/=
rtca
>>>>> n_ raw.c?v=3DSVN-trunk#734
>>>>>
>>>>>
>>>>> I may have missed something. What are the real complaints? Is there=
 a
>>>>> test program?
>>>> Not yet (will commit the related patch to our RACK likely later toda=
y).
>>>> It's simply sending frames while re-using the msg+iovec structs in a=

>>>> loop.
>>>>
>>>>>> I always considered the same well-know behaviour of RTnet a bug, b=
ut
>>>>>> now I found your code is doing this systematically, also for user
>>>>>> space callers. Is this behaviour undefined or even required accord=
ing
>>>>>> POSIX or whatever?
>>>>> I don't know, it's Sebastian's Kode.
>>>> Hmm, hope he will not say that he imitated RTnet...
>>> Rather an imitation of the Linux kernel's behaviour. The memcpy_toiov=
ec()
>>> and memcpy_fromiovec() functions [1] also modify the original iovec.
>>>
>>>
>>> [1] http://lxr.free-electrons.com/source/net/core/iovec.c
>> But that's the kernel's private (and user-safe) copy. I failed to find=

>> it writing that back to user space.
>=20
> Hm. Ad hoc, I don't recall why the userspace's iovec is also updated. P=
erhaps=20
> my intention was to make the use of rtcan_raw_sendmsg consistent for ke=
rnel=20
> and userspace RT-Tasks so that both can rely on finding modified iovecs=
 after=20
> calling sendmsg/recvmsg. But I'm not absolutely sure if there isn't a b=
etter=20
> explanation for this. I will try to find the reason in my backup memory=
=2E ;-)
>=20

So, unless we find some reason why we _must_ modify user's iovec, either
for send or receive, I would say: kill the user copy-back and work in
both case (kernel / user space caller) on the local copy of iovec (if we
still need to modify it all then).

Jan


PS: I just committed this fix (only a problem for in-kernel usage)

--- ksrc/drivers/can/rtcan_raw.c        (Revision 2340)
+++ ksrc/drivers/can/rtcan_raw.c        (Arbeitskopie)
@@ -334,7 +334,7 @@ static int rtcan_raw_setsockopt(struct r
                    return -EFAULT;
                }
            } else
-               memcpy(flist, so->optval, so->optlen);
+               memcpy(flist->flist, so->optval, so->optlen);
            flist->flistlen =3D flistlen;
        }


--------------enig317CA732E1903C408F423952
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGDRv4niDOoMHTA+kRAnQMAJ9FyHLjxzuBS69sUc1iG4bKSuLBygCfYESO
h+7JBJVqtDb3AqsvFX3Y9ks=
=QOh6
-----END PGP SIGNATURE-----

--------------enig317CA732E1903C408F423952--

