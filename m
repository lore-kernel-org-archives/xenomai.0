Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 May 2011 08:36:30 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>
In-Reply-To: <4DC03CE8.4050608@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz><1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>	<4DBFE062.3020902@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>
	<4DC03CE8.4050608@domain.hid>
From: <dietmar.schindler@domain.hid>
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, May 03, 2011 7:36 PM
> ...
> >> On 05/03/2011 10:15 AM, dietmar.schindler@domain.hid wrote:
> >>> ...
> >>> We at manroland now use (with Xenomai 2.4) the attached patch, =
which
> >>> implements the readv file operation in the rtpipe driver so that =
the
> >>> assertion "One read() per rt_pipe_write()" (message boundaries
> >>> preserved) covers readv(2) also.
> ...
> Unfortunately, the patch as is is a bit hard to read. IMO, only
> implementing readv will result in a more straight-forward =
implementation
> which we could merge.

I understand. If you prefer, I can provide a patch which multiplies out =
the functions to a separate readv, though this will result in code =
duplication of the whole read function. Alternatively, I could comment =
the changes so that they are easier to read.
Please let me know which flavour you favour.
--=20
Dietmar

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


