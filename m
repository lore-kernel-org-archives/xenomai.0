Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 May 2007 19:23:54 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C4@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
[...]
>> 2309      5.4062  xeno_nucleus             xeno_nucleus
(no symbols)
>
>We are lacking module symbols here. Dunno if one can teach them to
>oprofile (likely somehow), but the easiest approach would be to compile
>xeno_native and nucleus into the kernel.

You can pass --enable-debug to the configure script in order to enable
debug symbols (and don't strip programs/libs). For the kernel and
modules,
define CONFIG_XENO_OPT_DEBUG and CONFIG_DEBUG_KERNEL/CONFIG_DEBUG_INFO
to have symbols and all. OProfile is only able to look up virtual
address
when debug symbols are present in file. You may have to pass the=20
--vmlinux option to opcontrol. Compiling Xenomai like suggested by Jan
will make your life easier, and will bring you an extra mini speedup
if you're in that kind of business.

--=20
Stephane

