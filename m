References: <mailman.94.1350341580.29827.xenomai@xenomai.org>
	<1350374085.35200.YahooMailNeo@web164604.mail.gq1.yahoo.com>
	<507D1EB8.3000406@xenomai.org>
Message-ID: <1350578804.89380.YahooMailNeo@web164606.mail.gq1.yahoo.com>
Date: Thu, 18 Oct 2012 09:46:44 -0700 (PDT)
From: Ahmet Tekelioglu <vtam370@yahoo.com>
In-Reply-To: <507D1EB8.3000406@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Beagleboard-XM
Reply-To: Ahmet Tekelioglu <vtam370@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you, Gilles. I am sorry for the delay in my reply but I only succeede=
d in cross-compiling a standard a kernel today and installed it on my Beagl=
eBoard-XM. Until now I didn't feel ready for Xenomai. I'll try to compile f=
or Xenomai tomorrow. =0A=0AAhmet=0A=0A=0A=0A=0A=0A_________________________=
_______=0A From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0A=
To: Ahmet Tekelioglu <vtam370@yahoo.com> =0ACc: "xenomai@xenomai.org" <xeno=
mai@xenomai.org> =0ASent: Tuesday, 16 October 2012, 11:45=0ASubject: Re: [X=
enomai] Beagleboard-XM=0A =0AOn 10/16/2012 09:54 AM, Ahmet Tekelioglu wrote=
:=0A> Hello,=0A> =0A> I am new. Is there a a step-by-step guide for install=
ing Xenomai on BeagleBoard-XM? =0A> =0A> I have gcc toolchain but can insta=
ll the Sourcery toolchain if necessary. =0A=0AThere is nothing special abou=
t the BeagleBoard-XM, the generic=0Ainstallation instructions apply, you ha=
ve them in xenomai sources, it is=0Athe README.INSTALL file, or can find th=
em on the web:=0A=0Ahttp://www.xenomai.org/documentation/xenomai-2.6/html/R=
EADME.INSTALL/=0A=0AWhat you may want to find is how to run a custom kernel=
 on your beagle,=0Adepending on what environment you use (debian, openembed=
ded, etc...).=0A=0AAlso note that xenomai 2.6.1 does not support thumb kern=
els or thumb=0Auser-space, so, if you are compiling with a toolchain which =
compiles for=0Athumb by default (like, it seems, linaro cross toolchain), p=
lease add=0A-mthumb to the cflags when compiling xenomai user-space. Also p=
ay=0Aattention not to enable CONFIG_THUMB2_KERNEL when compiling the kernel=
.=0A=0ARegards.=0A=0A-- =0A=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0 =A0 Gilles.
