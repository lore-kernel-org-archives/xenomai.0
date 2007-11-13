Message-Id: <200711130737.lAD7bP5F014408@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Tue, 13 Nov 2007 08:37:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Sorry I had answered only to Gilles Chanteperdrix, I forgot you guys =
:-),
sorry!

PAtrick

-----Message d'origine-----
De=A0: Patrick [mailto:kpa_info@domain.hid
Envoy=E9=A0: lundi, 12. novembre 2007 17:52
=C0=A0: 'Gilles Chanteperdrix'
Objet=A0: RE: [Xenomai-help] RT, nonRT communication

Hi,

I have found the problem. The second parameters of rt_task_notify is =
named
signals and QT define a keywords named signals, and thus the QT =
pre-compiler

hangs on this declaration. Would it be possible to rename signals to
something like sigs or _signals?=20

Thank you,

Patrick

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: lundi, 12. novembre 2007 16:49
=C0=A0: Patrick
Cc=A0: jan.kiszka@domain.hid; xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] RT, nonRT communication

On Nov 12, 2007 3:00 PM, Patrick <kpa_info@domain.hid> wrote:
>
> Hi,
>
> I have another error when I try to compile Xenomai with g++ :
>
> /usr/xenomai/include/native/task.h:292: error: expected ',' or '...'
before
> 'protected'
>
> I have tried to include this file with and without extern "C" but the
issue
> is the same.
>
> Do you have an idea ?

Please post some example code that we can compile, because simply
#including <native/task.h> in a C++ program works here.


--=20
                                               Gilles Chanteperdrix


