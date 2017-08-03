MIME-Version: 1.0
In-Reply-To: <CAAaH=QHqX+eJaG4EUqa5GQ2jZs+gs1xy7bFQEsConLe6gyTU4Q@mail.gmail.com>
References: <CAAaH=QHqX+eJaG4EUqa5GQ2jZs+gs1xy7bFQEsConLe6gyTU4Q@mail.gmail.com>
From: mohamed atef <mohamedatefmohamed95@gmail.com>
Date: Thu, 3 Aug 2017 16:15:31 +0200
Message-ID: <CAAaH=QEQN-meXws0EF1JB-Cvskq8RNsEjai9uvonbChkXQmatg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Where is the board configuration?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I'm new to Xenomai and RTOSs in general and try to make my first steps
here. I succeeded in building Xenomai libraries for imx6quad as a practice.

Now I have a question. I have a "UDOO IMX6Quad" board and want to run
Xenomai on it. The problem is that I'm a little bit confused by something.
On the installing page here "http://xenomai.org/installing-xenomai-3-x/"
and as I understand I support the board name at the end of the make command
here for example, it's made for a CSB637 board.

"make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
O=3D$build_root/linux csb637_defconfig"

The *_defconfig files are in arch/arm/configs folder. The confusion comes
from here as I found a "imx_v6_v7_defconfig" file. I don't know why it's
here and imx is SoCs not boards!! and if I want to configure my board (UDOO
e.g. it's IOMuxing, etc), where should I place these files?

Thnx in advance.=E2=80=8B
--=20
=E2=80=8BMohamed Atef=E2=80=8B
=E2=80=8BComputer Department | Faculty of Engineering | Cairo University=E2=
=80=8B
