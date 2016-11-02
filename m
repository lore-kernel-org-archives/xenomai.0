Date: Wed, 2 Nov 2016 22:57:29 +0000 (UTC)
From: Jinlong Shen <shenjinlong@yahoo.com>
Message-ID: <1535963144.720900.1478127449409@mail.yahoo.com>
MIME-Version: 1.0
References: <1535963144.720900.1478127449409.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] use of xenomai,
 how to build xenomai3 with graphical desktop in raspberry pi 2
Reply-To: Jinlong Shen <shenjinlong@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Since I may understand it incompletely, I try to give some details that may=
 help to get myself understood. =C2=A0
I wish to learn how to use Xenomai3 in cobalt mode. I followed the procedur=
e in the following link with some modification.=C2=A0http://www.blaess.fr/c=
hristophe/2016/05/22/xenomai-3-sur-raspberry-pi-2/I could generate Linux/Xe=
nomai image as well as the user space.=C2=A0
I am having difficult in using buildroot. Since I am not able to populate a=
 naive SD card with the bootloader(s) and file system, I installed Raspbian=
 to the SD card using Noobs. =C2=A0After that, I copied the aforementioned =
Linux/Xenomai image (renamed as kerlnel7.img) and User Space to the SD card=
.
Many thanks, the test functions worked!!! =C2=A0
My questions are as follows:=C2=A0
(1) I wish to avoid use of Noobs. How can produce a minimal system on a nai=
ve SD card from an engineering PC? I guess the minimal means the following=
=C2=A0 =C2=A0 =C2=A0 (a) the file system (b) bootcode.bin. (c) .elf for GPU=
. (d) configure file to specify memory division between GPU and ARM cores.=
=C2=A0
(2) The system created with Noobs is having nice HMI ( graphical desktop ov=
er HDMI + keyboard). In Xenomai, I do not have it. How and where can I conf=
igure it in order to have the normal HMI (keyboard, desktop) again?

Best regards,Jinlong
