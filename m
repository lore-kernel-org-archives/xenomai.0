From: Alexander Herzog <aherzog@tuebingen.mpg.de>
Message-Id: <D89759E6-FF44-40AC-82AE-7381A82BA5C7@tuebingen.mpg.de>
Date: Thu, 18 Dec 2014 09:39:31 +0100
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Latency spikes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

We see latency spikes on our xenomai install whenever we open a window, =
take a screenshot or perform similar actions. The spikes are especially =
high (~2000) the moment an opengl window is opened (e.g. glxgears). =
Outside of these events (e.g. once a window is open) the latencies seem =
to be stable. The issue remains even, if we switch graphics cards (and =
graphics drivers) from a nvidia to a radeon card.=20

We are running Xenomai 2.6.3 on an Intel Xeon E5-2687W v3 310GHz =
processor and Ubuntu 12.04 (linux kernel version 3.8.13). I went through =
the troubleshooting section and made sure that the deprecated config =
flags (CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, CONFIG_KGDB, =
CONFIG_CONTEXT_TRACKING_FORCE) are disabled. We see the warning =
'SMI-enabled chipset found, but SMI workaround disabled', but passing =
'xenomai.smi=3D-1' to the kernel does not fix our issue.

I would be thankful for any hint on how I could further debug this =
issue.

Best regards,
Alex=
