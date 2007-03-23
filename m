From: xenomai@domain.hid
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
Date: Fri, 23 Mar 2007 15:01:53 +0000
Message-Id: <032320071501.18626.4603EBE100089583000048C22216557996070E0301020A98@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="NextPart_Webmail_9m3u9jl4l_18626_1174662113_0"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


--NextPart_Webmail_9m3u9jl4l_18626_1174662113_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

>Regarding "nothing gets scheduled on" CPU #2: Do you mean no Linux job
or no Xenomai task? The bug that was (/should be) fixed in 2.3.1 was
concerning Linux, Xenomai requires explicit scheduling.

>But you are right, something is fishy here. I never heard of hanging
modules like that before.


Well, I made nucleus as a module and it boots up and runs fine.  After installing the modules the tests run although with slightly different results.  Insted of single digit latencies, I get upwared of 38us every once in a while.

Mike


 -------------- Original message ----------------------
From: Jan Kiszka <jan.kiszka@domain.hid>



--NextPart_Webmail_9m3u9jl4l_18626_1174662113_0
Content-Type: message/rfc822

From: Jan Kiszka <jan.kiszka@domain.hid>
To: xenomai@domain.hid
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>,
	xenomai@xenomai.org
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
Date: Fri, 23 Mar 2007 14:52:39 +0000
Content-Type: Multipart/mixed;
	boundary="NextPart_Webmail_9m3u9jl4l_18626_1174662113_1"

--NextPart_Webmail_9m3u9jl4l_18626_1174662113_1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[Please don't top-post, cite only what you comment on.]

xenomai@domain.hid wrote:
> I disabled CONFIG_ACPI_AC and I got the same hang with ACPI_BATTERY. I =
am using 2.31.  Any other suggestions?  I will remove all that hang
but I feer that that is not the right way to go.

Regarding "nothing gets scheduled on" CPU #2: Do you mean no Linux job
or no Xenomai task? The bug that was (/should be) fixed in 2.3.1 was
concerning Linux, Xenomai requires explicit scheduling.

But you are right, something is fishy here. I never heard of hanging
modules like that before.

Jan


--NextPart_Webmail_9m3u9jl4l_18626_1174662113_1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA+mZniDOoMHTA+kRApGMAJ4n4gpvw2071EA4U9VOZxzYIkNbuwCfY8KQ
vCujG27aMbAtMrf+7jBlZPk=
=QnFX
-----END PGP SIGNATURE-----

--NextPart_Webmail_9m3u9jl4l_18626_1174662113_1--

--NextPart_Webmail_9m3u9jl4l_18626_1174662113_0--

