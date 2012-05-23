Message-ID: <4FBCB442.5030208@wanadoo.fr>
Date: Wed, 23 May 2012 11:56:18 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] iMX6 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We are looking in a replacement solution for our obsolete 
pentium-Celeron calculator.
For many reasons, we would like to switch to the ARM architecture.
The aimed CPU is the iMX6 Quadcore.

Freescale provides a patched 2.6.35 and 2.6.38 kernel that do not have 
all the peripherals (the CAN seems to be missing)
and Emtrion, a CPU module manufacturer, say they provide the additional 
patches to have the complete BSP.
It is likely a 2.6.35 only, though.

 From my point of view, the remaining work would be to :

1) apply the Xenomai 2.6.0 patches on their kernel,
after having ported their diffs from 2.6.35 to 2.6.38

2) Once it is done, as we want CAN support, it remains the task to port 
the FlexCAN driver as an RTDM one,
that I estimate to 1 man/week work.

Do you experts see any possible issues or risks that I have not been 
thinking about ?
Any advice would be greatly appreciated.

Best Regards
Thierry Bultel

