Message-ID: <1215513338.487342fa9659c@domain.hid>
Date: Tue, 08 Jul 2008 12:35:38 +0200
From: berlemont.hauw@domain.hid
References: <486E6486.5060000@domain.hid>
	<200807072312.57613.berlemont.hauw@domain.hid> <48731B11.80906@domain.hid>
In-Reply-To: <48731B11.80906@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] comedi: Fix include for do_div
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Hi,

> Sorry, but the committed fix is bogus for 2.6.26. I would suggest just
> to pick up what I proposed, kernel headers do the same since ages
> (including 2.4).

Argh... I am an [CENSORED].

I missed everything, I was in another dimension. I had a too quick look a=
t your
fix (I saw linux/div64 instead of asm/div64) so I decided to put a tempor=
ary fix
(as I was running out of time to get some 2.6.26-rcx sources).

I will fix that tonight.

Sorry I will be more careful (next time, I directly apply your patch).

Alexis.

