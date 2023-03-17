Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0A4A34
	for <xenomai@lists.linux.dev>; Fri, 17 Mar 2023 12:32:52 +0000 (UTC)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7CE9F85B6E
	for <xenomai@lists.linux.dev>; Fri, 17 Mar 2023 13:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1679056370;
	bh=CQtrgX+t9SJzuwpZT4cT5yeWbGopIrfoDvJMiRpr230=;
	h=Date:From:To:Subject:From;
	b=0Qc/rq88zjQI1yqg8vQk9oQgwHcnsGT8yooOqQ/GbY6Z3WODWrbHdQn/rMkboCsQH
	 dhxliN2hpMbv3bekFO5RJNvQAt/Wt9Fax9mqN3QhYcuosiCHXMDeJpJHoey8RwqPIk
	 NKEIPlt3tV6eU7f1jtoN4xD+skKtKYPDnkk7Q4yqxs80PyXCBIYfuDzxcOUEXX6EH6
	 tURVCP1OP3Kz58Qg1ggadPljOSsMzFlAWapdxnqb1CLR6FaQa76O/9kJjT7atukVrr
	 9r9GQHFRyKJ2IkgGxWSj1XxuUo212j0QHI6EifPr8AKR7rpgKR+Cu+eWjPdOQmKxwV
	 +kEvJohJ83upA==
Date: Fri, 17 Mar 2023 13:32:49 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai4] Sharing information regarding RPi4 demo
Message-ID: <20230317133249.38756e92@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OlCHPjHB/MVU0cgQJqlJq1U";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/OlCHPjHB/MVU0cgQJqlJq1U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

I would like to inform you about available Xenomai4 demo for Raspberry
Pi4 (model B) board.

All you need is to build the SD card and connect oscilloscope.

Please follow guidelines in:
https://source.denx.de/lukma/meta-xenomai-demo

Full Yocto/OE setup is possible with single kas file:
https://source.denx.de/lukma/kas/-/blob/master/rpi4-xenomai4-demo.yml

I hope that somebody will find it useful :-)



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/OlCHPjHB/MVU0cgQJqlJq1U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmQUXfEACgkQAR8vZIA0
zr3uaAf+NOUvr1gc06ro0AeQMfLbI0eJeszu16oQjiTmoQKE/J2eIjBf4tS2/Skz
Dk/jcOP0ZBNjJ88MX47xfezb8XFHViZl/eo3/pio1Xt7SxnpDNGBGelYbYo7MBuq
E4rUIqVSb2odJd1KUEG01a3zCxavIDFaRloJU6xElmfKs6FLXBxMktSNU1YBryTX
+oQMAOw4EdFLH2/pXjyvZuZ7PNHt+jCEkNuW0BRdc5crlV6QihNnKm2RV9Bk5dZQ
oSTplQBwLKsECaD/Ftn7DfhXW0L+3o91oLCFnP26Usop/fRVwS4dyukDiBb24kfO
7DLcfKJl0Oxty1W9lMqV3zSN1XHCew==
=Zq+P
-----END PGP SIGNATURE-----

--Sig_/OlCHPjHB/MVU0cgQJqlJq1U--
