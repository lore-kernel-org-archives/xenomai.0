Message-ID: <4B507B06.4080206@domain.hid>
Date: Fri, 15 Jan 2010 15:26:14 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1263470867-1533-1-git-send-email-wg@domain.hid>
	<4B5076F9.40508@domain.hid>
In-Reply-To: <4B5076F9.40508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH xenomai-2.5 0/3] rtcan: mscan: new
 OF	platform driver for MPC521x and MPC5200
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid, Wolfgang Grandegger <wg@domain.hid>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> From: Wolfgang Grandegger <wg@domain.hid>
>>
>> This patch series adds RT-Socket-CAN support for the MSCAN on the MPC512x
>> from Freescale by introducing a new OF platform driver for both, the
>> MPC521x and MPC5200, while still keeping the old driver for the MPC5200
>> for compatibility with older kernel versions.
> 
> Hi Wolfgang,
> 
> there seems to be something missing, because I get a compilation error
> on lite-5200:
> http://sisyphus.hd.free.fr/~gilles/bx/#powerpc

Well, I obviously did not test the driver with old versions of the Linux
kernel, sorry. For 2.6.29 and 2.6.30 the following patch should fix the
build:

diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
b/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
index 48abd89..47e34b6 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
@@ -76,7 +76,11 @@ static u32 __devinit mpc52xx_can_get_clock(struct
of_device *ofdev,
 	else
 		*mscan_clksrc = MSCAN_CLKSRC_XTAL;

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+	freq = mpc52xx_find_ipb_freq(ofdev->node);
+#else
 	freq = mpc5xxx_get_bus_frequency(ofdev->node);
+#endif
 	if (!freq)
 		return 0;

For 2.4 I will have a close look now.

This proves, your regression test build tool is really useful.

Thanks,

Wolfgang.

