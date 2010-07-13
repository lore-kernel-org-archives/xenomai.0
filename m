From: Flavio Alves <flavio.alves@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 15:45:02 -0300
Message-ID: <1279046702.31665.65.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Kernel compilation procedures for imx51
Reply-To: flavio.alves@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I would like to build a linux kernel with Xenomai to run on a iMX51
board (iMX51EVK).

I am currently using the last version of the BSP from Freescale website
(LTIB). If I apply the BSP's patches before the Xenomai's patches, the
patches are not applied. So, I first apply Xenomai's patches and then
BSP's patches.

The problem in this approach is that I have compilation errors, even if
I have all the patches successfully applied.

I saw at Denx homepage that there is a specific patch for Xenomai for
iMX51. But the patch provided by the website must be used into the
"rel_imx_2.6.31_10.02.00" tag in in Freescale's LTIB source tree. I
believe the release version of LTIB that I am using is 10.04.00 (and not
10.02.00) and maybe that's the reason why it is not compiling. How do I
get that release of LTIB?

I saw that the patch provided in the website
(adeos-ipipe-2.6.31-arm-1.15-01.patch) is different from the Xenomai
2.5.3 package (adeos-ipipe-2.6.31-arm-1.15-02.patch). Does it mean that
this topic was solved?

Best Regards,

Flavio



