Message-ID: <43F18CDE.1010800@domain.hid>
Date: Tue, 14 Feb 2006 08:55:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid>
	<43ED3165.3090300@domain.hid> <43EDE275.5040307@domain.hid>
	<43EDE6D7.8050506@domain.hid> <43EE3E81.80803@domain.hid>
	<43EFBA92.3030306@domain.hid> <43EFFB80.1080104@domain.hid>
	<43F126D4.4040407@domain.hid> <43F13AA3.3090702@domain.hid>
In-Reply-To: <43F13AA3.3090702@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5ED54F2FA25C7C49D5DEF502"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5ED54F2FA25C7C49D5DEF502
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>> =20
>>
>>> Jan Kiszka escreveu:
>>>  =20
>>>> Ok, but even if you decide to let rt-mmap be non-deterministic, you
>>>> still need some means to prevent the scenario you described above.
>>>> Actually, all you need is some callback when the mapped memory block=

>>>> was
>>>> actually released (munmap/application exit). Such a callback can be
>>>> registered inside the rtdm_mmap handler as a vma_fileop.
>>>>    =20
>>> I have never worked with vma_fileop... I would need to learn it first=
=2E
>>>  =20
>>
>> Here is the patch to offer you access to those ops. Revert the previou=
s
>> version, then apply this one.
>>
> Actually I would have to revert the modifications I had to do for the
> patch to apply (some rejected chunks). But I think I'll update to the
> last SVN xenomai. BTW, is this patch for the SVN or 2.1 or 2.0.2
> xenomai? Or it would apply for all of them?

Developed and tested against 2.1. The current patch will not cleanly
apply against 2.0.

>=20
>> It still needs some final documentation
>> notes and a test on kernel 2.4. But is should already work on 2.6.
>> =20
>>
> I forgot to mention, I have one more problem. Since I call mmap on
> driver initialization (thus before any rtdm_dev_open), I do not have an=
y
> rtdm_user_info_t, so I need to use current instead, but I'm not sure if=

> this will work. Maybe mmap needs the 'current' struct of the user
> program... I don't know this very well... If that is true, so I'll have=

> to do the maps in a non-rt context anyway...

You cannot mmap before you know precisely for which user this should
take place. During init, it's the insmod/modprobe process - likely not
the one you are interested in. So the earliest point for mmap is device
open. If this is too late for you, then now finally forget about this
pre-mmapping and turn it into a normal function for secondary mode. It
will be hard anyway to find a user who will notice the difference.

>=20
>> I also attached a demo for the handler usage based on my previous test=

>> framework. Just grab the pattern and put some useful code in the close=

>> handler...
>>
>> =20
>>
>>>> It will run in
>>>> non-RT, and could be used to mark the related hardware buffer as
>>>> finally
>>>> free for re-allocation.
>>>>    =20
>>> Now, I did realize that there is one more problem on my current desig=
n.
>>> If the user application exits or is terminated, I'm not sure if the
>>> close handler is called if the user forgot/was not able to. If it is
>>> not, the buffer would be marked as used until I reloaded the driver..=
=2E
>>> Is the close handler invocated on application termination?
>>>  =20
>>
>> Yep, this is a general issue you cannot avoid: all skin objects beside=
s
>> task are only released when the user-space application cleans it up as=

>> it's ought to. There is no tracking of used resources, no auto-cleanup=
=2E
>> If your application fails to close a device or socket, you will get a
>> stalled handle which can be found in /proc/xenomai/rtdm/open_files.
>> Writing the file descriptor number to this particular proc-file (e.g.
>> "echo 3 > /proc/xeno...") will trigger an enforced close and will
>> release the file descriptor again. Useful when debugging such broken
>> applications.
>> =20
>>
> Yes, sorry... I forgot I've already read this... :)
>=20
> Rodrigo.
>=20
>=20

Jan



--------------enig5ED54F2FA25C7C49D5DEF502
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8YziniDOoMHTA+kRAkEDAJsE8WBUeQ1cvW2WslCvPqX2R2PQEwCdEMh3
wWx1JtXxskrwVfaDXnyguk8=
=HSgs
-----END PGP SIGNATURE-----

--------------enig5ED54F2FA25C7C49D5DEF502--

