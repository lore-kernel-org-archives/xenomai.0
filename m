MIME-Version: 1.0
Date: Wed, 28 May 2008 14:50:37 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <df6ee85f837d916e8fffc4e64803ea79@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] 32 bits Xenomai application over x86-64 architecture
Reply-To: matthieu.connaulte_xenomai@domain.hid
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

Hi,

I'm on a x86-64 architecture and I try to compile a 32 bits application. =
I
use gcc with m32 option. I found out that Xenomai libraries are 64 bits
libraries since, by default, the compilation of Xenomai Kernel keep the
arch configuration. My problem is that there is no way I link a 64 bits
library to a 32 bits application. I can't change the 32 bits environment =
of
my application. Well, I investigate mail archives and I found some thread=
s
about installing Xenomai in 32 bits over a 64 bits arch, but I didn't fou=
nd
any issue. So my question is what can I do ? Use a configure the kernel
with option like --arch=3Dx86 ? Patch my kernel with 32 bits option for A=
deos
Kernel (prepare-kernel.sh --arch=3Di386 ) ? Reinstall my SuSE Linux ? Is
there any wrapper that allow me to use 32 bits application over 64 bits
Xenomai installation ?

Matthieu



