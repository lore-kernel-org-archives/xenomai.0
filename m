Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 4 Dec 2007 08:49:06 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375F47@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375F44@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int><51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int><2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int><2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int><18260.25837.479943.881970@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid><18260.29573.817255.968962@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375F43@domain.hid><2ff1a98a0712040608l634b902kf1d7db3652b71575@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375F44@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

=20
> BTW, maybe to solve the problem with registering an opaque pointer
with
> the nucleus, perhaps we should consider adding a single void* to all
> xenomai types. (Tasks, queues, pipes, etc.) Then, the user could have
a
> single call that binds an opaque pointer to any type. This could
contain
> data the user program needs to identify and properly clean up the
> deleted thread. This way, the watchdog timer could simply suspend a
> thread rather than delete it, and the user thread could then clean it
up
> properly. In order to ensure the thread isn't restarted before the
user
> program gets the signal, it could be marked in such a way as to not
> schedule again.
>=20

I just realized that this isn't really the solution (though it might be
nice in a generic sense) because you don't know the thread that was
killed when the signal is received anyway.

Steven
=20

