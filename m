Message-ID: <1390987721.64002.YahooMailNeo@web163903.mail.gq1.yahoo.com>
Date: Wed, 29 Jan 2014 01:28:41 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Cross-compile vanilla kernel to armhf fails
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

Hi,=0A=0AI'm trying to cross-compile xenomai-2.6.3 patched vanilla linux ke=
rnel 3.5.7 to armhf using this command:=0A=0A/Downloads/linux-3.5.7$ CONCUR=
RENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno DEB_HOST_ARCH=3Darmhf fakeroot make-kpkg =
--arch arm --cross-compile /usr/bin/arm-linux-gnueabihf- --initrd --append-=
to-version -xenomai-2.6.3 --revision 1.0 kernel_image kernel_headers=0A=0A=
=0Aand get this error:=0A=0A=A0 CC=A0=A0=A0=A0=A0 drivers/xenomai/testing/t=
imerbench.o=0A=A0 LD=A0=A0=A0=A0=A0 drivers/xenomai/testing/xeno_timerbench=
.o=0A=A0 LD=A0=A0=A0=A0=A0 drivers/xenomai/testing/xeno_switchtest.o=0A=A0 =
LD=A0=A0=A0=A0=A0 drivers/xenomai/testing/built-in.o=0A=A0 LD=A0=A0=A0=A0=
=A0 drivers/xenomai/built-in.o=0A=A0 LD=A0=A0=A0=A0=A0 drivers/built-in.o=
=0Amake[1]: Leaving directory `/home/huub/Downloads/linux-3.5.7'=0Amake: **=
* [debian/stamp/build/kernel] Error 2=0A=0A=0AI've tried to find a possible=
 cause but found nothing. Can anyone please direct me into a possible solut=
ion ?=0A=0AThanks
