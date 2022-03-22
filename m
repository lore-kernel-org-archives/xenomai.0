From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Tue, 22 Mar 2022 17:48:43 +0100
Subject: Bug in xenomai =?utf-8?q?3=2E2=2Ex?= on ARM
Message-ID: <cff-6239fe00-4d-24d08100@67302606>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

trying to port a running Xenomai 3.1.x/Linux 4.4.x system to Xenomai 3.=
2.x/Linux 4.4.x running on Zynq7000, I found a (maybe) bug in intr.c

In xnintr=5Fattach, the call to ipipe=5Fset=5Firq=5Faffinity (when in S=
MP) expects a 0 return code. However, on my platform, I end up in irq=5F=
gic.c in gic=5Fset=5Faffinity() which returns IRQ=5FSET=5FMASK=5FOK=5FD=
ONE (2) when everything is fine.

This IRQ=5FSET=5FMASK=5FOK=5FDONE does not seem very common in the kern=
el (I could find a few occurences, on Gic v3 so maybe AARCH64 has the s=
ame problem, plus some PCI devices).

I was wondering if this was something to fix in ipipe or xenomai ?

Fran=C3=A7ois


