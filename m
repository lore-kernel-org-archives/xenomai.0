MIME-Version: 1.0
Sender: johncandlish@gmail.com
In-Reply-To: <CAN0BPY_SzMoNrgOF2fBwrMA=7scopqTKPC+pxkk12wtGMsWdGQ@mail.gmail.com>
References: <CAN0BPY_SzMoNrgOF2fBwrMA=7scopqTKPC+pxkk12wtGMsWdGQ@mail.gmail.com>
Date: Fri, 31 May 2013 12:00:06 +0200
Message-ID: <CAN0BPY_gK3-_qLZVpq1hgoGWqqRRH++fRAcTdReo3ojf6U8Hfg@mail.gmail.com>
From: John Candlish <john.candlish@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Fwd: SMI problems with 2.6.2.1 and last weekends git
	version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Resent, because it bounced the first time.

---------- Forwarded message ----------
From: John Candlish <john.candlish@gmail.com>
Date: Tue, May 28, 2013 at 9:08 PM
Subject: SMI problems with 2.6.2.1 and last weekends git version
To: xenomai@xenomai.org


Hello

This was originally about linuxCNC, but was reminded to post my SMI
findings here.

from the emc-developers list:
http://thread.gmane.org/gmane.linux.distributions.emc.devel/9863

<quote>

What I found out about RTAI and Xenomai?

Xenomai 2.6.2.1 stable or GIT do not handle SMI masking correctly for my
ICH7 chipsets.  In the case of the stable download the chipset is detected
but the SMI workaround fails to apply.

---
May 25 07:42:05 sixis kernel: Xenomai: real-time nucleus v2.6.2.1 (Day At
The Beach) loaded.
May 25 07:42:05 sixis kernel: Xenomai: debug mode enabled.
May 25 07:42:05 sixis kernel: Xenomai: SMI-enabled chipset found
May 25 07:42:05 sixis kernel: Xenomai: SMI workaround failed!
---

In the case of the GIT version the kernel command line parameter
'xeno_hal.smi=1' is not respected.

---
 May 26 08:31:48 sixis kernel: Xenomai: real-time nucleus v2.6.2.1 (Day At
The Beach) loaded.
May 26 08:31:48 sixis kernel: Xenomai: debug mode enabled.
May 26 08:31:48 sixis kernel: Xenomai: SMI-enabled chipset found, but SMI
workaround disabled
May 26 08:31:48 sixis kernel:         (see xeno_hal.smi parameter). You may
encounter
May 26 08:31:48 sixis kernel:         high interrupt latencies!
---

I was seeing latency as high as 100us with Xenomai, so it is currently not
working for me.

</quote>

This is on a Dell gx620, Pentium D 820, ICH7 chipset machine.  I could do
more testing if it is a help.

I would very much like to get Xenomai working for me, but both the stable
version or the git version have SMI problems.

Thanksyou

jCandlish
.
