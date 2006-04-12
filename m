Message-ID: <b647ffbd0604120146u2f8e481bv2db9d1115d69e954@domain.hid>
Date: Wed, 12 Apr 2006 11:46:10 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [draft PATCH] nested enable/disable irq calls
In-Reply-To: <443C1D29.5020105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
	<443C1D29.5020105@domain.hid>
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
Cc: xenomai@xenomai.org

Hi Jan,

I'll read up more carefully you proposalsa bit later, just want to
note now that the code I have posted (and actually the current shirq
code) have a few nasty (hidden maybe for a first glance) synch.
related bugs. brrr... although one will not encounter them when RTDM
is used for driver development but may happilly find himslef in
trouble using the native or posix skin.

I'm finding a way to solve them more gracefully now.

--
Best regards,
Dmitry Adamushko

