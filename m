From: Kronander Klas <klas.kronander@epfl.ch>
Date: Wed, 27 Jun 2012 10:22:57 +0000
Message-ID: <D1DC5191D5CF3A45A867CD95644B92392162B41F@REXMF.intranet.epfl.ch>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] integrated drivers not built?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Is there some special configuration that must be set in order to build the =
integrated drivers (specifically the can-related ones)?

I built xenomai, but I am not able to load any of the drivers. When looking=
 in /lib/modules/[MYKERNEL]/ folder, I find the drivers listed in modules.b=
uiltin:

cat /lib/modules/[MYKERNEL]/modules.builtin | grep xeno

kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
kernel/kernel/xenomai/skins/native/xeno_native.ko
kernel/kernel/xenomai/skins/posix/xeno_posix.ko
kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
kernel/drivers/xenomai/can/xeno_can.ko
kernel/drivers/xenomai/can/sja1000/xeno_can_sja1000.ko
kernel/drivers/xenomai/can/sja1000/xeno_can_peak_pci.ko
kernel/drivers/xenomai/serial/xeno_16550A.ko
kernel/drivers/xenomai/testing/xeno_timerbench.ko
kernel/drivers/xenomai/testing/xeno_switchtest.ko

but I can't find any of these object files on the paths specified in the mo=
duels.builtin file.  There is no xenomai directory in /lib/modules/[MYKERNE=
L]/kernel/drivers, which I believe there should be?

Are the modules even built, and if so, where are they? I built xenomai usin=
g:
cd /usr/src/xenomai-2.5.5.2
sudo ./configure --enable-dlopen-skins
sudo make
sudo make install

I hope someone can clarify this, thanks in advance
Klas Kronander

