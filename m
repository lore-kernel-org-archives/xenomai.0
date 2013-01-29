From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Jan 2013 13:54:29 +0100
Message-Id: <3B6652EE-A4C6-4819-B3BB-DB02EFA1B08B@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] kconfig CONFIG_XENO_OPT_TIMING_PERIODIC=y/n
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm testing linuxcnc with John's 3.5.7 - 2.6.2.1 kernel and found an =
issue with the deprecated linuxcnc xenomai-kernel threads version (the =
userland threads version is fine; both using native skin). I traced that =
back to rt_timer_ticks2ns(30000) returning zero.

The config difference I see is: CONFIG_XENO_OPT_TIMING_PERIODIC=3Dy on =
3.5.7, unset on 3.2.21

The way I read back messages I'd think that should be unset for native =
and Posix skins; these are compiled in:

CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_SKIN_PSOS=3Dm
CONFIG_XENO_SKIN_UITRON=3Dm
CONFIG_XENO_SKIN_VRTX=3Dm
CONFIG_XENO_SKIN_VXWORKS=3Dm
CONFIG_XENO_SKIN_RTDM=3Dy

(not that we're about to use the other skins soon, but I understand John =
is shooting for a most generic setup)

Am I correct to assume the right thing to do is to set =
CONFIG_XENO_OPT_TIMING_PERIODIC=3Dn for that purpose?

thanks in advance,

Michael


