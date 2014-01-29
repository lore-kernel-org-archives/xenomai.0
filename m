References: <1390987721.64002.YahooMailNeo@web163903.mail.gq1.yahoo.com>
 <52E8CF13.4070904@xenomai.org> <201401291346.49045.paul_c@tuxcnc.org>
Message-ID: <1391004375.1976.YahooMailNeo@web163906.mail.gq1.yahoo.com>
Date: Wed, 29 Jan 2014 06:06:15 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <201401291346.49045.paul_c@tuxcnc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cross-compile vanilla kernel to armhf fails
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

I just successfully cross-compiled the kernel using make. Actually, I assum=
e it was successful, as I didn't test it yet.=0AMay or should need --subarc=
h ? I read about it in posts, and the man file only says "some architecture=
s". Is there a (official) doc telling about armhf ? I do prefer make-kpkg a=
s I did that on x86, which made installing with dpkg a lot easier.=0A=0A=0A=
=0A=0AOn Wednesday, January 29, 2014 2:49 PM, Paul <paul_c@tuxcnc.org> wrot=
e:=0A =0AOn Wednesday 29 January 2014, Gilles Chanteperdrix wrote:=0A=0A> O=
n 01/29/2014 10:28 AM, Huub Van Niekerk wrote:=0A> > Hi,=0A> >=0A> > I'm tr=
ying to cross-compile xenomai-2.6.3 patched vanilla linux=0A> > kernel 3.5.=
7 to armhf using this command:=0A> >=0A> > /Downloads/linux-3.5.7$ CONCURRE=
NCY_LEVEL=3D2 CLEAN_SOURCE=3Dno=0A> > DEB_HOST_ARCH=3Darmhf fakeroot make-k=
pkg --arch arm --cross-compile=0A> > /usr/bin/arm-linux-gnueabihf- --initrd=
 --append-to-version=0A> > -xenomai-2.6.3 --revision 1.0 kernel_image kerne=
l_headers=0A> >=0A> >=0A> > and get this error:=0A> >=0A> >=A0 =A0 CC=A0 =
=A0 =A0 drivers/xenomai/testing/timerbench.o=0A> >=A0 =A0 LD=A0 =A0 =A0 dri=
vers/xenomai/testing/xeno_timerbench.o=0A> >=A0 =A0 LD=A0 =A0 =A0 drivers/x=
enomai/testing/xeno_switchtest.o=0A> >=A0 =A0 LD=A0 =A0 =A0 drivers/xenomai=
/testing/built-in.o=0A> >=A0 =A0 LD=A0 =A0 =A0 drivers/xenomai/built-in.o=
=0A> >=A0 =A0 LD=A0 =A0 =A0 drivers/built-in.o=0A> > make[1]: Leaving direc=
tory `/home/huub/Downloads/linux-3.5.7'=0A> > make: *** [debian/stamp/build=
/kernel] Error 2=0A> >=0A> >=0A> > I've tried to find a possible cause but =
found nothing. Can anyone=0A> > please direct me into a possible solution ?=
=0A>=0A> You are lacking the line with the actual error. The full log shoul=
d=0A> contain it. Otherwise you can try without CONCURRENCY_LEVEL, in which=
=0A> case make should stop immediately after the error.=0A=0AYou may also n=
eed:=0A=A0=A0=A0 --subarch armhf=0Aas an option passed to make-kpkg...=0A=
=0ABut the first question should be, can you cross compile a kernel for the=
 =0Atarget using the standard kernel make ?=0A=0AIf you can't, then using m=
ake-kpkg will fail also.=0A=0A_____________________________________________=
__=0AXenomai mailing list=0AXenomai@xenomai.org=0Ahttp://www.xenomai.org/ma=
ilman/listinfo/xenomai
