Message-ID: <45CB44CF.3090802@domain.hid>
Date: Thu, 08 Feb 2007 16:42:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 2.6.20 compiling problems
References: <45CB3B5C.9020200@domain.hid> <45CB42EB.400@domain.hid>
In-Reply-To: <45CB42EB.400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Maksym Veremeyenko wrote:
>=20
>>Hi!
>>
>>i try to compile xenomai-2.3.0 + kernel-2.6.20 +
>>adeos-ipipe-2.6.20-i386-1.7-01 but get a compiler errors:
>>
>>kernel/xenomai/nucleus/registry.c:71:70: error: macro "DECLARE_WORK"
>>passed 3 arguments, but takes just 2
>>kernel/xenomai/nucleus/registry.c:71: warning: type defaults to =E2=80=98=
int=E2=80=99 in
>>declaration of =E2=80=98DECLARE_WORK=E2=80=99
>>kernel/xenomai/nucleus/registry.c: In function =E2=80=98registry_proc_s=
chedule=E2=80=99:
>>kernel/xenomai/nucleus/registry.c:388: error: =E2=80=98registry_proc_wo=
rk=E2=80=99
>>undeclared (first use in this function)
>>kernel/xenomai/nucleus/registry.c:388: error: (Each undeclared
>>identifier is reported only once
>>kernel/xenomai/nucleus/registry.c:388: error: for each function it
>>appears in.)
>>make[3]: *** [kernel/xenomai/nucleus/registry.o] Error 1
>>make[2]: *** [kernel/xenomai/nucleus] Error 2
>>make[1]: *** [kernel/xenomai] Error 2
>>make: *** [kernel] Error 2
>>
>=20
>=20
> That's due to the work queue changes in 2.6.20. You need latest Xenomai
> SVN, either v2.3.x or trunk.

Please also note that Xenomai trunk is not yet fully ready for 2.6.20.
The FP support does not work at the moment. The work is in progress.

--=20
                                                 Gilles Chanteperdrix

