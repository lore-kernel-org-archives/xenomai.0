From: <dietmar.schindler@domain.hid>
Date: Mon, 19 Sep 2011 07:25:49 +0000
Message-ID: <8236197CA3DA864F9EF20609D9887263B4D0@domain.hid>
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
	<1316360236.2169.40.camel@domain.hid>
In-Reply-To: <1316360236.2169.40.camel@domain.hid>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures cause
 buffer overflow
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: Xenomai-help@domain.hid

> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
> On Behalf Of Philippe Gerum
> Sent: Sunday, September 18, 2011 5:37 PM
> ...
> Actually, we used to follow strictly the pSOS convention for this until
> 2.4.x, at which point we moved to name strings precisely because
> non-null terminated char[4] arrays would break the registry, the way you
> described. This is one of the rare situations where mimicking a useless
> limitation of the original API may be challenged by usability concerns
> in the new environment, and usability won in that case. The problem
> mostly comes from the fact that char[4] is automatically convertible to
> const char *, so we have no warning/error leading us to check the
> potentially problematic call sites.
>
> The concern about moving back to char[4] arrays - null-terminated if
> shorter - is for people who currently assign strings longer than 4
> characters to name their objects. What could be done, is providing a
> build switch to select the accepted input, like
> --disable-psos-long-names to turn on char[4] interpretation.

While I would prefer the switch --enable-psos-long-names, this sounds okay =
to me, the more so as it is more than people who use the pSOS skin without =
obeying pSOS rules deserve.
--
Regards,
Dietmar
________________________________________ manroland AG Vorsitzender des Aufs=
ichtsrates: Hanno C. Fiedler Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. =
Ingo Koch, Dr. Markus Rall, Paul Steidle Sitz der Gesellschaft: Offenbach a=
m Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592 USt-Ident-Nr. =
DE 250200933


