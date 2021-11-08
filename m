From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai v3.2 has been released!
Message-ID: <a014822d-0408-df1a-811c-01e7176a7aa5@siemens.com>
Date: Mon, 8 Nov 2021 13:37:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

after a longer (or careful) -rc phase, 3.2 is now officially "done".

https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.2/xenomai-v3.2.tar.bz2

The highlight of this release is surely the enabling of Dovetail
support, thus adding support for newer kernels. Dovetail almost feels
like I-pipe to the end user at this point, maybe except that the clocks
of Linux and Xenomai are now in sync and interrupts are now all tracked
in /proc/interrupts. Performance appear comparable to us, in
micro-benchmarks sometimes even faster with Dovetail. But your mileage
may vary. So please test and share your impressions!

Let me try to summarize all the changes:

366 commits, 483 files changed, 13836 insertions(+), 5559 deletions(-)
 - support for Dovetail kernel patch
 - production support up to kernel 5.10
 - experimental support for kernel 5.15
 - I-pipe support tested against 4.19 and 5.4
 - support for recent gcc and glibc 
 - y2038-enabling of our kernel ABI, almost done, just few calls
   remaining
 - add kernel config check utility
 - gpio: use real-time clock timestamps by default
 - RTDM gpio drivers for OMAP, ZynqMP and Intel Cherryview
 - Add support of PEAK PCAN-PCIe FD cards family
 - dropped x32 ABI support
 - improved compat support (32-bit userland on 64-bit kernels)
 - various fixes, specifically (but not only) for the testsuite

Thanks a lot to all the contributors!

Jan Kiszka <jan.kiszka@siemens.com> (135)
Philippe Gerum <rpm@xenomai.org> (122)
Florian Bezdeka <florian.bezdeka@siemens.com> (29)
Hongzhan Chen <hongzhan.chen@intel.com> (20)
Song Chen <chensong_2000@189.cn> (17)
chensong <chensong@tj.kylinos.cn> (12)
Vitaly Chikunov <vt@altlinux.org> (5)
François LEGAL <devel@thom.fr.eu.org> (4)
Fino Meng <fino.meng@linux.intel.com> (3)
Quirin Gylstorff <quirin.gylstorff@siemens.com> (3)
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> (2)
Greg Gallagher <greg@embeddedgreg.com> (2)
Fabrice Fontaine <fontaine.fabrice@gmail.com> (1)
Greg Gallagher via Xenomai <xenomai@xenomai.org> (1)
Jan Leupold <leupold@rsi-elektrotechnik.de> (1)
Joshua Karch <jkarch48@hotmail.com> (1)
Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> (1)
Matúš Olekšák <oleksak.matus@gmail.com> (1)
Norbert Lange <nolange79@gmail.com> (1)
Pintu Kumar <pintu@codeaurora.org> (1)
Ronny Meeus <ronny.meeus@gmail.com> (1)
Stephane Grosjean <s.grosjean@peak-system.com> (1)
Stephen Freyder <steve@freyder.net> (1)
Wolfgang Grandegger <wg@grandegger.com> (1)

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

