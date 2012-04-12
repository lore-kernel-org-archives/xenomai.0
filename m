Message-ID: <4F87036D.1050605@domain.hid>
Date: Thu, 12 Apr 2012 18:31:41 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>	<4F75B5BF.8030401@domain.hid>	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>	<4F75C7D1.4020808@domain.hid>	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>	<4F79D5EA.3010501@domain.hid>	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>	<4F7D7A43.4060502@domain.hid>	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>	<4F8592F3.6070907@domain.hid>	<4F85B7BE.9080706@domain.hid>	<4F85B869.2060102@domain.hid>	<4F85D505.6080002@domain.hid>	<CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>	<4F8689BD.4050508@domain.hid>
	<CAGq8jPgV3aQrz6-Y0LqrjT1HA2udHG887o1EFd4bS5eFvp6gkw@domain.hid>
In-Reply-To: <CAGq8jPgV3aQrz6-Y0LqrjT1HA2udHG887o1EFd4bS5eFvp6gkw@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Minh GIANG <giang.hminh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 04/12/2012 10:51 AM, Minh GIANG wrote:
> Hello sir,
>=20
> Here is the message after doing your command:
>=20
> giang@domain.hid$
> make XENO=3D/usr/xenomai/bin
> --xeno-cflags is deprecated, use --skin=3Dname --cflags instead
> --xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead
> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
> -Werror-implicit-function-declaration -pipe -D__XENO__   -L/usr/xenomai=
/lib
> -lxenomai -lpthread -lrt  -lnative -lrtdm -Xlinker -rpath -Xlinker

That's how the program should be comiled and linked.

> /usr/xenomai/lib  cross-link.c   -o cross-link
> cross-link.c: In function =91write_task_proc=92:
> cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but =
argument 2
> has type =91ssize_t=92
> cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but =
argument 3
> has type =91ssize_t=92
> cross-link.c: In function =91read_task_proc=92:
> cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but =
argument 2
> has type =91ssize_t=92
> cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but =
argument 3
> has type =91ssize_t=92
> giang@domain.hid$
> ./cross-link
> Xenomai: binding failed: Operation not permitted.
> giang@domain.hid$=
 su
> Mot de passe :
> root@domain.hid=
s/serial#
> ./cross-link
> main : write-file opened
> main : write-config written
> main : read-file opened
> main : read-config written
> main : write-task created
> main : read-task created
> main : starting write-task
> main : starting read-task
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
>   0 |          104495 |          617720 |          722215
>   1 |          104649 |          617061 |          721710
>   2 |          104360 |          617820 |          722180
>   3 |          104906 |          617050 |          721956
>   4 |          105794 |          617188 |          722982
>   5 |          103504 |          618103 |          721607
>   6 |          104643 |          617084 |          721727
>   7 |          106633 |          617767 |          724400
>=20
> oh, it seems to work perfectly, i don't know why it works in this case =
when
> i lauched it in the terminal linux, i copied exactly the program in Ecl=
ipse
> C++ and it doesn't work. Ah the only thing i have changed (otherwise my
> program don't compile in Eclipse), is
>=20
> static const struct rtser_config read_config =3D {
> 0xFFFF,
> 115200,
> RTSER_DEF_PARITY,
> RTSER_DEF_BITS,
> RTSER_DEF_STOPB,
> RTSER_DEF_HAND,
> RTSER_DEF_FIFO_DEPTH,
> RTSER_DEF_TIMEOUT,
> RTSER_DEF_TIMEOUT,
> 1000000000, /* 1 s */
> RTSER_RX_TIMESTAMP_HISTORY,
> RTSER_EVENT_RXPEND,
> };
>=20
> static const struct rtser_config write_config =3D {
> RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,
> 115200,
> RTSER_DEF_TIMESTAMP_HISTORY,
> /* the rest implicitely remains default */
> };
>=20
> maybe, i don't compile with good parameters in Eclipse?

Yes, that's your problem. And exactly to avoid such problems, Xenomai
provides the script "xeno-config" to retrieve proper compiler and linker
options.

> my version Xenomai 2.6.0

I also recommend to update to a more recent version.

Wolfgang.

