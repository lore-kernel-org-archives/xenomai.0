From: "Gianni Perugini" <gperugini@domain.hid>
References: <003001cbacde$f43fa500$dcbeef00$@com>
	<4D2476A5.5080908@domain.hid>
	<003601cbace1$5a56fb20$0f04f160$@com>
	<4D247B80.3040503@domain.hid>
In-Reply-To: <4D247B80.3040503@domain.hid>
Date: Wed, 5 Jan 2011 15:46:16 +0100
Message-ID: <004001cbace7$5e250b60$1a6f2220$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: it
Subject: [Xenomai-help] R: R:  XDDP socket problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Ok, now it works. My makefile was wrong.

Thank you for your assistance

Gianni Perugini
Ilapak Italia S.p.A.
Via L.Lama 11/13
52045 - Foiano della Chiana (AR)
Phone: +39 0575 649751
Fax: +39 0575 649753
Mobile: +39 349 2377467
Email: gperugini@domain.hid
Web: www.ilapak.com


-----Messaggio originale-----
Da: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Inviato: mercoled=C3=AC 5 gennaio 2011 15.09
A: Gianni Perugini
Cc: xenomai@xenomai.org
Oggetto: Re: R: [Xenomai-help] XDDP socket problem

Gianni Perugini wrote:
> Hi Gilles,
>=20
> Attached is the log with the result of the command you asked for.

(...)

0804a6a8 B rt
         U rt_print_auto_init
         U rt_printf
         U sendto@domain.hid
         U setsockopt@domain.hid
         U sigaddset@domain.hid
         U sigemptyset@domain.hid
         U signal@domain.hid
         U sigsuspend@domain.hid
         U socket@domain.hid
         U strlen@domain.hid
         U write@domain.hid

Here, this binary is using glibc symbols, not Xenomai symbols, if it was
using Xenomai symbols, you would see:

U __wrap_pthread_create
U __wrap_sendto
U __wrap_setsockopt
U __wrap_socket
U __wrap_write

etc...

In order to compile it correctly, see:
http://www.xenomai.org/index.php/Examples
If you want to understand how this works, see:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Co=
mpilation_flags.

--=20
					    Gilles.


