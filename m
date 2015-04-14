From: <romain.perier@scle.fr>
Date: Tue, 14 Apr 2015 09:17:59 +0200
Message-ID: <299A38B133279A4EBA47BCB60993FEAF858030C89D@xs203433.MELINDA.LOCAL>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RTNET
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,=0A=
=0A=
We're deploying Xenomai 3.0-rc4 (3.16.7 mainline kernel, in dual-kernel=0A=
mode) on a Zynq ZC702. Everything works fine except when we try to use=0A=
ethernet in the xenomai mode. The driver is called "macb" and it is=0A=
already ported to RTDM. macb is correctly loaded and initialized, the=0A=
mac controller is correctly connected to the phy, BUT, when I play a bit=0A=
with rtifconfig , the systems hangs.=0A=
=0A=
# rtifconfig rteth0 up=0A=
 [  495.846877] macb e000b000.ethernet eth0: link up (1000/Full)=0A=
 # and now everything is freezed (only when the cable is plugged)=0A=
=0A=
After some investigations, if I disable the call to rtdm_irq_request(),=0A=
the systems no longer freezes. So, It seems to be an issue caused by=0A=
interrupts handling.=0A=
I use the devicetree to tells to linux which driver I want to use for=0A=
the corresponding mac controller, I just change the "compatible" string.=0A=
I renamed xeno-macb compatible string to "cdns,rtgem" instead of=0A=
"cdns,gem" . In this way I can use the first mac controller in linux and=0A=
the second one in xenomai, each one with a different device driver. Both=0A=
interrupts are from Cortex-A9 GIC.=0A=
(I already tested to use only one mac controller at a time, same problem)=
=0A=
=0A=
I have two questions :=0A=
=0A=
1. Have you any ideas about the problem described above ?=0A=
2. I was wondering, if it is possible to use ethernet from a xenomai=0A=
application without rtdm and rtnet. in other words, it is possible to=0A=
use linux device driver from xenomai mode ? (if it is possible,=0A=
I guess that my application will switch from the primary mode to the=0A=
secondary mode very often, no?)=0A=
=0A=
Regards,=0A=
=0A=
Romain=0A=
=0A=

