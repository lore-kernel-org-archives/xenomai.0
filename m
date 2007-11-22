Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Nov 2007 13:33:35 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB29E@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] rtai_free & rtai_malloc problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: zhangwei zhang <linda.zhangwei@domain.hid>, xenomai@xenomai.org

zhangwei zhang wrote:
>I try to install emc2 on xenomai (x86), the error is like this:

I have no idea what is emc2. Is this thing using the RTAI skin?

>gcc -I/usr/local -I../../../include -g -Wall -DDEBUG -g -O2
>-o .libs/usrmot usrmot-usrmotintf.o usrmot-usrmot.o usrmot-emcmotglb.o
>usrmot-pid.o usrmot-emcmotlog.o usrmot-emcmotutil.o
>-L/home/kyla/eldk/xeno-tux-0.1/src/libnml
>/home/kyla/eldk/xeno-tux-0.1/src/libnml/.libs/libnml.so
>-L/home/kyla/eldk/xeno-tux-0.1/src/emc/nml_intf
>/home/kyla/eldk/xeno-tux-0.1/src/emc/nml_intf/.libs/libemc.a
>-L/usr/xenomai/lib /usr/xenomai/lib/libnative.so -Wl,--rpath
                                     ^^^^^^^^^^^^
If your application uses the RTAI skin, then the library is wrong.
It should be librtai.so instead. Hence the _link_ error you've got.

Regards,
--=20
Stephane

