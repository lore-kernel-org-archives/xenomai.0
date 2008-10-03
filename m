Message-ID: <48E5EB4D.4040401@domain.hid>
Date: Fri, 03 Oct 2008 11:52:13 +0200
From: Laurent BESSARD <laurent.bessard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] CONFIG_XENO_OPT_SYS_STACKPOOLSZ warning
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

Hello all,

Recently, I tried to compile a driver for Xenomai and I received this=20
warning while trying to include rtdm_driver.h:
In file included from /usr/xenomai/include/nucleus/xenomai.h:25,
                 from /usr/xenomai/include/rtdm/rtdm_driver.h:37
/usr/xenomai/include/nucleus/heap.h:110:5: warning:=20
"CONFIG_XENO_OPT_SYS_STACKPOOLSZ" is not defined

This symbol is provided by kernel config while compiling kernel, but=20
doesn't exist in any other context.

It would solve the problem if heap.h test if this symbol exist before=20
trying to use it, or define a default value for this symbol like:

#ifndef CONFIG_XENO_OPT_SYS_STACKPOOLSZ
#define CONFIG_XENO_OPT_SYS_STACKPOOLSZ 0
#endif

Thanks,

Laurent

--=20
LOLITech - TBI sarl
24, rue Pierre Evrat
88100 Saint-Di=E9 des Vosges
tel: 03 29 52 95 67
fax: 03 29 58 93 16
laurent.bessard@domain.hid <mailto:laurent.bessard@domain.hid>
http://www.lolitech.fr 	<http://www.lolitech.fr>


