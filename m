References: <1320995056.19430.YahooMailNeo@domain.hid>
	<4EBD0A71.7090409@domain.hid>
Message-ID: <1322037104.76183.YahooMailNeo@domain.hid>
Date: Wed, 23 Nov 2011 00:31:44 -0800 (PST)
From: Guvenc Gulce <gulceg@domain.hid>
In-Reply-To: <4EBD0A71.7090409@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] IDDP send-receive example emits SIGXCPU signal
Reply-To: Guvenc Gulce <gulceg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Yes.. I have enabled the support for iddp sockets in the kernel configurati=
on. It looks like that =0A=0Ait works with xenomai 2.6.0 when I enable the =
=0A=0Apthread_set_mode_np(0, PTHREAD_WARNSW);=0Aafter the socket() and bind=
() calls. (tested again with the example code from xenomai)=0A=0AMy questio=
n is:=0A=0AIs it designed that way that the calls socket() and bind() for I=
DDP cause a switch to =0A=0Asecondary mode and the calls recvfrom() and sen=
dto() do not ? In other words =0A=0Adoes the real-timeliness guarantee exis=
t only for recvfrom() and sendto() ?=0A=0A=0AThanks & Regards=0A=0AGuvenc=
=0A=0A=0A=0A=0A----- Original Message -----=0AFrom: Gilles Chanteperdrix <g=
illes.chanteperdrix@domain.hid>=0ATo: Guvenc Gulce <gulceg@domain.hid>=0ACc=
: "xenomai@xenomai.org" <xenomai@xenomai.org>=0ASent: Friday, November 11=
, 2011 12:43 PM=0ASubject: Re: [Xenomai-help] IDDP send-receive example emi=
ts SIGXCPU signal=0A=0AOn 11/11/2011 08:04 AM, Guvenc Gulce wrote:=0A> look=
s like XENOMAI_SKINCALL3 macro is failing for some reason but I can't =0A> =
=0A> explain this behavior as I am using the example code linked with the c=
orrect =0A> =0A> xenomai libraries. Any help would be highly appreciated.=
=0A=0ADo you have support for iddp sockets enabled in kernel configuration?=
 If=0Ayes, do you have the same issue with xenomai 2.6.0?=0A=0A-- =0A=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A

