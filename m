From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Mon, 13 Apr 2015 12:27:08 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342962C71@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xeno3.0 latency no /dev/rtheap under 3.18 i.mx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

when i start latency, i get the error:
Xenomai: /dev/rtheap is missing
(chardev, major=3D10 minor=3D254)

dmesg | grep Xeno shows:
[Xenomai] scheduling class idle registered.
[Xenomai] scheduling class rt registered.
I-pipe: head domain Xenomai registered.
[Xenomai] Cobalt v3.0-rc4 (Exact Zero)

cat /sys/module/xenomai/parameters/state
enabled

Always looks good, ore can I check more?

I have made this:

First I read the document: Installing Xenomai 3.x, because it is my first X=
eno3 touch.

Than git clone  https://git.xenomai.org/ipipe-gch.git -b for-ipipe-3.18<htt=
ps://git.xenomai.org/ipipe-gch.git%20-b%20for-ipipe-3.18>
Call /scripts/ipipe/genpatches
It generates the ipipe-core-3.18-arm-1.patches without any messages.

Get the vanilla 3.18 kernel
Prepare the kernel:
cd /platform-sm-arm/build-target/xenomai-"3.0-rc4" && \
                               scripts/prepare-kernel.sh --linux /platform-=
sm-arm/build-target/linux-3.18 \
                               --ipipe /platform-sm-arm/build-target/xenoma=
i-"3.0-rc4"/kernel/cobalt/arch/arm/patches/ipipe-core-3.18-arm-1.patch \
                               --arch=3Darm

Make imx_v6_v7_defconfig (for the i.mx6 sabresd board)
Call kernel menuconfig and check the settings.
Make the kernel.
Make dtb for imx6q-sabresd board.

Than configure the Xenomai-lib with:

      CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" \
      --host=3Darm-v7a-linux-gnueabi \
       --build=3Di686-host-linux-gnu  \
       --enable-shared \
       --with-core=3Dcobalt \
       --enable-smp  \
       --disable-doc-install

make and install it.

Put all on the target, boot and try latency...
Xenomai: /dev/rtheap is missing

I don't know what is my mistake.

There is a message in dmesg:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: inconsistent lock state ]
3.18.0 #1 Not tainted
---------------------------------
It is important about my problem?



With best regards,
Alexander

