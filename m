Message-ID: <45754C4C.4060005@domain.hid>
Date: Tue, 05 Dec 2006 11:39:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] vxworks- and posix-skin simultaneously
References: <5D63919D95F87E4D9D34FF7748CE2C2A6C6377@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A6C6377@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> Can anybody tell me about the actual state of using vxworks-skin and po=
six-skin
> simultaneously ? Is it possible, compiling one application with
vxWorks-skin and
> an other one with the posix-skin and to use/execute these two applicati=
ons
> simultaneously on one system ?
>=20
> In an earlier posting I have read, that all skins (or at least the nati=
ve and the
> posix one) should be compiled as modules, so they do not overide the
timer mode.
> Is this still true ? And if yes, dosn=B4t need the posix skin an
aperiodic timer,
> but the timer is set to periodic mode by the vxworks skin ? So, can an
vxworks
> application and an posix applications run together ??

Yes, it is possible, but the two skins would share the same timer, and
since this timer has to be in periodic mode for the vxworks skin, you
would have to run the posix skin in periodic mode too. This should work,
but of course you would not get the same timer resolution as the one you
get in aperiodic mode.

--=20
                                                 Gilles Chanteperdrix

