Message-ID: <4347B72A.3030706@domain.hid>
Date: Sat, 08 Oct 2005 14:10:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] "New" roadmap after split from RTAI...?
References: <Pine.LNX.4.64.0510081235280.18584@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0510081235280.18584@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig085C6F6BA73B2720938EFBB6"
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
To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig085C6F6BA73B2720938EFBB6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Herman Bruyninckx wrote:
> Dear list,
>
> I was wondering whether there is a new roadmap for the Xenomai project, now
> that the split from RTAI is effective?

I'm not aware of any planned fundamental changes. Rather, Philippe was
collecting ideas/wishes for the time after release 2.0. I already
brought up some topics, and to take this chance, let's start collecting
furthers:

 o ARM support
     It's burning in order to extend the usage to this booming domain.

 o More flexible scheduling subsystem
     This would allow to attach new scheduling schemes like EDF. And it
   should attract also more researchers to this project. Input from
   those people is valuable, because they tend to look from different
   perspectives at the code, finding different kind of bugs or
   optimisation potentials.

 o Define more RTDM device profiles, write more drivers
     With the availability of a driver model, I hope people will take
  the chance and broaden this important foundation part of any OS. I
  think the Xenomai community can become a very good arena for such
  efforts. Maybe we can even motivate some hardware vendors to jump in.

 o Consider new real-time memory allocators for the core
     I already had some discussions with Miguel Masmano, the
   maintainer of the quite promising TLSF allocator, about this. Further
   evaluation is certainly required, but his approach looks superior to
   the current BSD algorithm.

>
> In my contacts with industry, I feel that a clear roadmap and a clear
> documentation and a clear design are paramount for getting credibility. And

Yep, that's also what I hear from those people. I got the impression
that the RTAI/fusion and now Xenomai approach is warmly welcome and
already gained some credibility.

> a top-notch POSIX implementation is also a must. I hope all these things
> will (remain to) be priorities for "the new Xenomi"...
>
> If I may recommend one urgent action it would be to update the project's
> home page at <http://home.gna.org/xenomai/>, and, especially, to remove the
> rubbish from the mailing list announced on that page :-)
>

Give the maintainers at least a few days. ;)

Anyway, the question arised for me if we really need to differentiate
between a "core" and a "main" mailing list. According to the expected
traffic volume and content, I configured my filter to forward both lists
into the same inbox...

Jan

--------------enig085C6F6BA73B2720938EFBB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDR7gkniDOoMHTA+kRAinEAJ9dW9S7VqZdQ3DdbetVxqjlTx0ebQCfe3Ho
St+nxltvybyh6yH127l7e7Q=
=uizn
-----END PGP SIGNATURE-----

--------------enig085C6F6BA73B2720938EFBB6--

