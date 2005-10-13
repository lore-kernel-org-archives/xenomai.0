Message-ID: <434E67CE.60507@domain.hid>
Date: Thu, 13 Oct 2005 15:57:34 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Future of fusion
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
	<Pine.LNX.4.64.0510131033300.5110@domain.hid>
	<17230.8141.436906.810841@domain.hid>
	<Pine.LNX.4.64.0510131049420.5110@domain.hid>
	<434E2510.9060502@domain.hid>
	<Pine.LNX.4.64.0510131131490.5110@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0510131131490.5110@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B82D974B1FF73B310CF7E62"
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
--------------enig2B82D974B1FF73B310CF7E62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Herman Bruyninckx wrote:
> On Thu, 13 Oct 2005, Philippe Gerum wrote:
> 
>> Herman Bruyninckx wrote:
>>
>>> On Thu, 13 Oct 2005, Gilles Chanteperdrix wrote:
>>>
>>>> Herman Bruyninckx wrote:
>>>> > On Thu, 13 Oct 2005, Philippe Gerum wrote:
>>>> >
>>>> > [...]
>>>> > > - New skins: Any new colors for the "chameleon"?
>>>> > "Perfect POSIX" is, to me, more important than new skins.
>>>> "Perfect" means,
>>>> > among other things, that the interference problem with the Posix
>>>> thread
>>>> > library (libraries) under Linux is solved.
>>>>
>>>> What is wrong with the current implementation ? 
>>>
>>>
>>> [...]
>>>
>>>> But I assumed the
>>>> interference with the posix thread library was solved. Could you
>>>> elaborate a bit more on the issues you observed ?
>>>
>>>
>>>
>>> Well, if this problem is solved, I'm very happy :-) And maybe I look
>>> at the
>>> wrong places, but where do I find a succint explanation of the solution?
>>>
>>
>> Well, what's your question first? :o>
>>
> Sorry if that was not clear.
> 
> The question is: how is the following problem solved? Where the problem is
> as follows: using Posix threads in realtime requires another library than
> the standard NPTL library that Linux uses (at least, I think you require
> another library), but how do you make sure to link to the correct library?
> Or is NPTL realtime safe?
> 

Nope, that's why there is RT-NPTL. And that library is still in flux,
especially now with the ongoing work on PREEMPT_RT. Let's wait for the
result and see if it is feasible to reuse this userspace infrastructure.

For now, I'm convinced that it is much more comfortable for the user to
obtain kernel extension and userspace library from one hand with a clear
and consistent versioning.

Jan

--------------enig2B82D974B1FF73B310CF7E62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDTmfOncNeS9Q0k+IRAj7wAKC2Zf1W88yjtndrRYRotKD8HYzMCQCguKps
kMkgjbnCDvl9wCIc4jqSPe4=
=HgmU
-----END PGP SIGNATURE-----

--------------enig2B82D974B1FF73B310CF7E62--

