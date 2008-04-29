Message-ID: <2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
Date: Tue, 29 Apr 2008 14:18:27 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on AT91SAM9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?ISO-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@viauc.dk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Apr 29, 2008 at 1:37 PM, Hans S=F8ndergaard (HSO) <HSO@viauc.dk> wr=
ote:
>
>
>
>
> Is it possible to install Xenomai 2.4.3 together with Linux 2.6.23 on
> AT91SAM9260?
>
> If the answer is no, which combination of Xenomai and Linux would you
> recommend?

Xenomai 2.4.3 ships with two versions of the Adeos I-pipe patch: one
for Linux 2.6.20, the other for Linux 2.6.24. So, I would recommend
using one of these two versions. Of course, you can probably adapt one
of the patches to Linux 2.6.23, but that may not be obvious.

Note that you may decide to apply the AT91 patch, the I-pipe patch
should apply cleanly with or without the AT91 patch.

--=20
 Gilles

