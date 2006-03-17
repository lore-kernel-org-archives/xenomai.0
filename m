Message-ID: <441AE25F.7040903@domain.hid>
Date: Fri, 17 Mar 2006 17:22:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] Xenomai thread runtime statistics
References: <067C9A1F6AFEB643895EA4513E116884178FC4@domain.hid>
	<441ADC6B.5010909@domain.hid> <441ADFAA.9040602@domain.hid>
	<441AE047.6020505@domain.hid>
In-Reply-To: <441AE047.6020505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5754F7691802163D7BC7C62"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, "Moser, Dan" <DMoser@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5754F7691802163D7BC7C62
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Moser, Dan wrote:
>>>
>>>> Hi,
>>>>
>>>> I am still searching for ways (hopefully via some API(s)) to get
>>>> Xenomai
>>>> run-time thread execution info (my original post is below).
>>>>
>>>> Being a newbie, I apologize if the answer "should be obvious".  I am=

>>>> still getting up to speed with both Linux and Xenomai.
>>>>
>>>> Is there a better list on which I should post this question?
>>>>
>>>
>>> This question is perfectly relevant to this list, the thing is that
>>> there's no simple, built-in way of getting execution stats for real-t=
ime
>>> threads yet. The best way to find out the execution time of your work=

>>> cycle would be to measure it using the high precision clock informati=
on.
>>
>>
>> Hmm, wouldn't it be feasible to add such statistics to I-pipe level? I=
'm
>> thinking of something like time spent in domain X, Y, Z vs. the overal=
l
>> runtime, preferably converted to percentage usage.
>>
>=20
> This would be nice, but only part of the issue, since you might have
> several real-time context switches occurring in a single Xenomai domain=

> activation.

You mean per-thread statistics? For sure, but a very common question is:
"How much remains for Linux?" And this feature could give a general hint
(although detailed benchmarking will typically be required as well, as
the effect of Xenomai+RT-load on application-specific Linux service may
have to be analysed more thoroughly).

Jan


--------------enigC5754F7691802163D7BC7C62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGuJfniDOoMHTA+kRAlr7AJ9lBAXPK8yLh2B4dhv35V+G40ExxgCePQhS
l8xYLdHzpjc/lNF2WInDPL4=
=hrNx
-----END PGP SIGNATURE-----

--------------enigC5754F7691802163D7BC7C62--

