Message-ID: <43BEA273.5090808@domain.hid>
Date: Fri, 06 Jan 2006 18:01:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Oops, I broke something
References: <43BE5E3E.1060208@domain.hid>	<43BE626A.6000500@domain.hid>
	<17342.26740.324646.221814@domain.hid>
	<43BE771C.2090005@domain.hid>
In-Reply-To: <43BE771C.2090005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0F1116A910F8B7E51ACD222"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0F1116A910F8B7E51ACD222
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
> 
>> Philippe Gerum wrote:
>>  > Jan Kiszka wrote:
>>  > > But this raised the question to me again if we really need the
>> "xenomai"
>>  > > prefix for all the skin headers /from within xenomai/. Why not
>> doing the
>>  > > same linking dance for the other skins as well? Or do you also
>> prefer
>>  > > that user include <xenomai/native/task.h> instead of just
>> <native/task.h>?
>>  >  > We need this for building from within the kernel. Other options
>> would  > require to either alter the Xenomai source tree adding
>> symlinks there,  > pollute linux/include with symlinks to reach the
>> individual Xeno  > components, or refer to some external tree that
>> eventually redirects to  > the Xenomai tree, which is not acceptable
>> in any case.
>>
>> Maybe we could add EXTRA_CFLAGS=-I$(TOPDIR)/include/xenomai to every
>> xenomai kernel makefile
> 
> 
> Yes, I would preferably merge that instead of playing with symlinks.
> 
>  and to the cflags returned by xeno-config for
> 
>> kernel-space applications ?
>>
> 
> There no such support in xeno-config anymore. Kernel module flags and
> dependencies now exclusively belong to the kernel build system;
> xeno-config is only relevant for building user-space apps.
> 

Actually, my concerns only targeted the userspace applications, more
precisely those few being built inside the xeno tree. External user apps
can still use the standard, non-prefixed headers. Thus my idea was to
unify the includes for those in-tree applications so that users who are
taking them as reference only see the standard way.

External kernel applications and drivers can and should catch this
prefix by adding <linuxsrc>/include/xenomai to their makefiles.

Jan

--------------enigF0F1116A910F8B7E51ACD222
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvqJzniDOoMHTA+kRAmLGAJ9RjDBWK/qM637Oys0i054xJlZyjQCcDx7p
7bmqo18SBAkJ08IabKqgrGk=
=etEF
-----END PGP SIGNATURE-----

--------------enigF0F1116A910F8B7E51ACD222--

