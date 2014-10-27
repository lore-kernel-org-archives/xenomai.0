From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Mon, 27 Oct 2014 13:21:00 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C674EE64@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Compiling drivers for Xenomai 2.6.4 on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Sirs,

I have successfully installed the Xenomai 2.6.4 on a Beaglebone Black (Linu=
x 3.8.13-bone67) by following the these recipes :
http://elinux.org/Talk:EBC_Xenomai
http://elinux.org/EBC_Installing_Kernel_Source

I can run the latency and klatency tests without problems.
The exercises from Nijmegen (http://www.cs.ru.nl/lab/xenomai/) compiles and=
 runs nicely.

My problem now is the lack of drivers under Xenomai.
I found the following:
https://github.com/nradulovic/xdrv-spi
https://github.com/nradulovic/xdrv-16c750a
According to README these drivers are designed for AM335X and Xenomai 2.6.2=
.1

The problem seem to be that the Makefiles stems from quite a different Xeno=
mai environment.
The ${LINUX_SRC} is not defined and the -Iinclude/xenomai does not exist.

Trying to mend this makes only the problems escalate.

Question:
Is it possible to make these drivers comply with the Xenomai 2.6.4 environm=
ent on the BBB?

Best regards
Terje Froysa



Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

