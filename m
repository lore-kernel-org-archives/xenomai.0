From: MONTET Julien <julien.montet@reseau.eseo.fr>
Subject: Xenomai ipipe x86 64 bits with 32 bits librairies 
Date: Wed, 2 Jun 2021 22:15:33 +0000
Message-ID: <PR3PR02MB620234FC0751074AE334B463D13D9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello the Xenomai team,

First of all I thank you for all your previous answers.
Xenomai 3.1 (skins included) is working fine on arm 32bits !
Now I am trying to find a way to do the same thing on x86 - ipipe 4.19.177+

My current code is supposed to work on 32bits and I can't upgrade it to 64b=
its.
I know x86_32 is officially no more supported for ipipe patch since Februar=
y, that is why my idea was to get an ipipe x86_64 (I already installed it o=
n the machine) and compile Xenomai librairies in 32bits.


My commands - I try to cross compile:
./configure --host=3Di686-linux-gnu CFLAGS=3D"-m32 -O2" LDFLAGS=3D"-m32" --=
with-core=3Dcobalt --enable-smp --enable-pshared
https://paste.ubuntu.com/p/h74GSvMjP9/
(I also tried to add -march=3Di686 in CFLAGS without success

The two lines below produce the same errors :
make ARCH=3Di686 CROSS_COMPILE=3Di686-linux-gnu-
make install DESTDIR=3D"[PATH]/xenomai-3.1/tmp_xenomai"
https://paste.ubuntu.com/p/M39PJgTM9X/


A similar thread on the Xenomai forum :
https://xenomai.org/pipermail/xenomai/2020-May/043000.html
The strange thing with the link above is the method should be working for -=
m32 (and not for -mx32). I tried with old librairies (3.0+), and I had the =
same issues


What I found :
The macro  #ifdef CONFIG_X86_X32 may not be defined because I have errors o=
n __COBALT_X32_BASE :
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/arch_2x86_2includ=
e_2asm_2xenomai_2syscall32_8h_source.html

What I have installed on my host :
sudo apt-get install linux-libc-dev:i386
sudo apt install gcc-i686-linux-gnu


Is there a way to use i686 (x86_32) code with Xenomai ?
Do you have any advices on this subject ?

Best regards,
Julien
<mailto:xenomai@xenomai.org>
