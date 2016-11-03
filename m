Date: Thu, 3 Nov 2016 09:49:09 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20161103094909.6a61f436@md1em3qc>
In-Reply-To: <1535963144.720900.1478127449409@mail.yahoo.com>
References: <1535963144.720900.1478127449409.ref@mail.yahoo.com>
 <1535963144.720900.1478127449409@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] use of xenomai,
 how to build xenomai3 with graphical desktop in raspberry pi 2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jinlong Shen <shenjinlong@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hey,

that is not really a xenomai question. More a question on how to
prepare a root fs for the board. Or how to exchange the kernel in an
existing root fs.

As far as i understand it you modified an existing image, putting the
xenomai kernel and userland in. If that made you loose the GUI you
probably forgot some CONFIG_ in the kernel, or you did not copy the
kernel modules.
Try "make modules_install" with INSTALL_MOD_PATH in your kernel dir to
get the modules in a place where you can archive and copy them.
If the distro is using any external modules you will have to rebuild
and install those as well.

regards,
Henning


Am Wed, 2 Nov 2016 22:57:29 +0000
schrieb Jinlong Shen <shenjinlong@yahoo.com>:

> Since I may understand it incompletely, I try to give some details
> that may help to get myself understood. I wish to learn how to use
> Xenomai3 in cobalt mode. I followed the procedure in the following
> link with some
> modification.=C2=A0http://www.blaess.fr/christophe/2016/05/22/xenomai-3-s=
ur-raspberry-pi-2/I
> could generate Linux/Xenomai image as well as the user space. I am
> having difficult in using buildroot. Since I am not able to populate
> a naive SD card with the bootloader(s) and file system, I installed
> Raspbian to the SD card using Noobs. =C2=A0After that, I copied the
> aforementioned Linux/Xenomai image (renamed as kerlnel7.img) and User
> Space to the SD card. Many thanks, the test functions worked!!! My
> questions are as follows: (1) I wish to avoid use of Noobs. How can
> produce a minimal system on a naive SD card from an engineering PC? I
> guess the minimal means the following=C2=A0 =C2=A0 =C2=A0 (a) the file sy=
stem (b)
> bootcode.bin. (c) .elf for GPU. (d) configure file to specify memory
> division between GPU and ARM cores. (2) The system created with Noobs
> is having nice HMI ( graphical desktop over HDMI + keyboard). In
> Xenomai, I do not have it. How and where can I configure it in order
> to have the normal HMI (keyboard, desktop) again?
>=20
> Best regards,Jinlong
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


