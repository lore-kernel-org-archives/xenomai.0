From: <dietmar.schindler@manroland-web.com>
Date: Tue, 20 Sep 2016 06:18:45 +0000
Message-ID: <b4c844ac2faa4a4a8d56a4e41e67fb6f@AUSMXMBX04.mrws.biz>
References: <1560138.jJyhniltkJ@indiana>
In-Reply-To: <1560138.jJyhniltkJ@indiana>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Cannot create a share library linked against Xenomai
 libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> Von: Xenomai [mailto:xenomai-bounces@xenomai.org] Im Auftrag von Leopold =
Palomo-Avellaneda
> Gesendet: Montag, 19. September 2016 22:45
>
> I'm trying to build a shared library, using the posix skin with Xenomai 3=
.0.3.
> I have built xenomai with:
>
> '--with-core=3Dcobalt' '--enable-smp' '--enable-pshared' '--enable-fortif=
y'
> '--enable-shared
>
> I built withour any error. However, when I try to build a library (shared=
)
> that uses xenomai I got this error:
>
> /usr/bin/ld: /usr/xenomai/lib/xenomai/bootstrap.o: relocation R_X86_64_32
> against `.rodata.str1.1' can not be used when making a shared object;
> recompile with -fPIC

Here is an answer to a similar problem: http://stackoverflow.com/a/38431538=
/2413201
It says to use the compiler flags -Wformat=3D0 or/and -Wno-format-security;=
 perhaps it helps also in your case.
--
Best regards,
Dietmar
________________________________
manroland web systems GmbH -- Managing Director: Alexander Wassermann
Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No.: 2681=
6 -- VAT: DE281389840

Confidentiality note:
This eMail and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you are not the intended recipient, you are hereby notified that any use=
 or dissemination of this communication is strictly prohibited. If you have=
 received this eMail in error, then please delete this eMail.
________________________________

