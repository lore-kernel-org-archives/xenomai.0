Message-ID: <45DEA9D0.6060100@domain.hid>
Date: Fri, 23 Feb 2007 09:46:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: The "product" Xenomai (was: [Xenomai-help] hello xenomai world?)
References: <45DE006F.5000400@domain.hid> <45DE33BF.7090601@domain.hid>
In-Reply-To: <45DE33BF.7090601@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig43403D60D5482CBA90FE9615"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig43403D60D5482CBA90FE9615
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
>> Your feedback is appreciated and helps improving things. Just a certai=
n
>> part of your verbosity might have been avoidable by digging a bit deep=
er
>> and checking twice, no? :)
> :)
> Perhaps. We are all in a big hurry and there are lots of bits and piece=
s
> with lots of documentation. Most of it not so bad actually but not
> really unified. If I from my point of view were to comment, then I woul=
d
> say that a single unified manual would have really made life a lot
> easier. Then again I have a handicap with my distribution so it may hav=
e
> been a lot simpler had I been working on a fixed installation instead o=
f
> a windows laptop which turns into linux when it has a usb stick in it.
> On yet a third hand, I do think that a lot of people will only start
> recompiling kernels when they enter this real-time story. A combined
> really slow step-by-step instruction set of how to compile the kernel
> with xenomai would make it a lot more accessible.

Well, compiling your own kernel is often one central key to the system
development. But you are right, it's an entry barrier to getting started
with real-time _application_ development. That's why I hope we will
manage to create and maintain some pre-compiled binary packages one day,
both for kernel and user space part, with standard PC as target. Yet
another item on the to-do list...

>=20
> On even yet another hand (I'm counting with my feet by now) I don;t
> really know what the objective of xenomai is. So far it appears to be a=
n
> impressively engineered product for which I don't doubt there should be=


Xenomai is not a "product". It's an open source project, a developer and
user community.

> decent interest. Industry however is rather demanding when it comes to
> development time (which is where my hurry comes from) and would
> generally not go through the motions I am trying to rush through here.
> We typically want a platform on which one can start developing for the
> application ASAP. Now even though what I am doing is relatively speakin=
g
> the easy bit (compared to developing the rt-patches and drivers), there=

> are still too many man hours involved in just getting to the final
> platform.

Keep in mind: You haven't bought a box with some CD and a manual, nor
have you signed a support contract by downloading Xenomai. Anything you
can get from Xenomai must be contributed by someone else first,
including some quick-start-in-five-minutes package or support around it.
Should really become general knowledge about open source.

There are also commercial support solutions available, but that's not
what happens *here*, in this particular forum.

>=20
> Apparently -from how I understand the documentation- the objective, or
> one of the objectives of xenomai, is to make porting to it from other R=
T
> operating systems as easy as possible. Having to struggle ones bottom
> off to get xenomai installed and understanding how it works, would rub =
a
> lot of the shine off this (I speak based only on the twinkels I have
> seen so far :)) otherwise hyper-promising bit of software engineering.

You can be sure that we know there are always things to improve to lower
the entrance barrier. But there are also more than enough other things
to do, and no one here has been hired to address this specific issue. So
we have to look how things get improved incrementally whenever time permi=
ts.

We are aware that helping beginners to get familiar with Xenomai is an
"investment" in potential future contributors (though the return rate is
yet improvable as well). That's also one reason why we are hanging
around here - even for free. :)

>=20
> Anyhow, must catch some quick sleep. Sorry again for all the questions.=

> Especially the stupid ones :)
>=20
> Thanks for tolerating and responding to them.
>=20
> Ah, one last thing, if you want to remind me about our contribution to
> the documentation that would be good.

Be careful, I typically actually do so! ;)

Jan


--------------enig43403D60D5482CBA90FE9615
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3qnQniDOoMHTA+kRAjDIAJ9djAhfJoaFUrKHQiDbBm2rHLhMXQCffxuk
JZK5Y6/notig/1uUZAJjXko=
=9/3G
-----END PGP SIGNATURE-----

--------------enig43403D60D5482CBA90FE9615--

