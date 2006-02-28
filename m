Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Feb 2006 15:24:42 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DA2@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] undefined reference
	__xnarch_xchg_called_with_bad_pointer
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

Dear Gurus,

I have compiled ppc(!)-xenomai with debug information (configure =
--enable-debug), so far so good (compiling of xenomai itself and it=B4s =
libraries, testsuite etc. was successful). =20
Buuuut ..., when compiling the vxWorks-demos =
(ksrc/skins/vxworks/demos/*.c), I get an error message about an =
undefined refernce __xnarch_xchg_called_with_bad_pointer. I searched for =
this mysterious function, but could only find it in =
asm-powerpc/atomic.h, where it is declared as external (extern void =
__xnarch_xchg_called_with_bad_pointer(void);).

Does anybody know, where I can get the implementation of this function, =
or what I have to do else to get rid of the error message ?

Thank you
Roderik

----------------------------------
> make
ppc-linux-gcc -g -o satch satch.c -I. =
-I/home/arowil/mc45/xenomai/_install/include -g -D_GNU_SOURCE =
-D_REENTRANT -D__XENO__ -Wall -pipe -D__XENO_UVM__  -u__xeno_skin_init =
-L/home/arowil/mc45/xenomai/_install/lib -luvm -lnucleus -lpthread =
-lvxworks=20
/home/arowil/mc45/xenomai/_install/lib/libnucleus.a(module.o)(.text+0x9d0=
): In function `__xchg':
../../src/include/asm/xenomai/atomic.h:162: undefined reference to =
`__xnarch_xchg_called_with_bad_pointer'
/home/arowil/mc45/xenomai/_install/lib/libnucleus.a(module.o)(.text+0x9d0=
):../../src/include/asm/xenomai/atomic.h:162: relocation truncated to =
fit: R_PPC_REL24 __xnarch_xchg_called_with_bad_pointer
/home/arowil/mc45/xenomai/_install/lib/libnucleus.a(pod.o)(.text+0x6974):=
 In function `__xchg':
../../src/include/asm/xenomai/atomic.h:162: undefined reference to =
`__xnarch_xchg_called_with_bad_pointer'

--------------------------------------


