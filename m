Message-ID: <1393935764.2258.YahooMailNeo@web163903.mail.gq1.yahoo.com>
Date: Tue, 4 Mar 2014 04:22:44 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] compiling kernel after xenomai-patch ends in error
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AI just patched vanilla kernel 3.10.18 with ipipe-core-3.10.18-arm-=
1 and get these errors:=0A=0Akernel/ipipe/core.c: In function =E2=80=98ipip=
e_probe_kernel_read=E2=80=99:=0Akernel/ipipe/core.c:1742:2: error: implicit=
 declaration of function =E2=80=98get_fs=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]=0Akernel/ipipe/core.c:1744:2: error: implicit declaration =
of function =E2=80=98set_fs=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]=0Akernel/ipipe/core.c:1744:9: error: =E2=80=98KERNEL_DS=E2=80=99 undecl=
ared (first use in this function)=0Akernel/ipipe/core.c:1744:9: note: each =
undeclared identifier is reported only once for each function it appears in=
=0Akernel/ipipe/core.c:1747:2: error: implicit declaration of function =E2=
=80=98__copy_from_user_inatomic=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]=0Akernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_writ=
e=E2=80=99:=0Akernel/ipipe/core.c:1761:9: error: =E2=80=98KERNEL_DS=E2=80=
=99 undeclared (first use in this function)=0Akernel/ipipe/core.c:1764:2: e=
rror: implicit declaration of function =E2=80=98__copy_to_user_inatomic=E2=
=80=99 [-Werror=3Dimplicit-function-declaration]=0A=0AWith previous kernel =
3.2 I got warning and errors before saving the kernel, now I didn't. Lookin=
g on the net for these errors, I find some postings, but none related to ip=
ipe. Any ideas?=0A=0AThanks.=0A
