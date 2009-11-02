Date: Mon, 2 Nov 2009 20:19:24 +0100
From: "gwenhael.goavec" <gwen@domain.hid>
Message-ID: <20091102201924.5f392e15@domain.hid>
In-Reply-To: <4AEF273B.3090402@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
	<20091020113725.9069.28060.stgit@domain.hid>
	<1256404942.2862.498.camel@domain.hid>
	<1257177854.2065.616.camel@domain.hid>
	<4AEF0BCC.2020208@domain.hid>
	<1257180716.2065.618.camel@domain.hid>
	<4AEF0F7F.2060603@domain.hid> <4AEF1E91.6030407@domain.hid>
	<4AEF22C3.4070303@domain.hid> <4AEF273B.3090402@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on ARMadeus
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

On Mon, 02 Nov 2009 19:38:51 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
wrote:

> By the way, did you make any change to the I-pipe patch to get it
> running on this board?

The only change realized, is made because Armadeus and
I-pipe does the same change on
mach-imx/include/mach/imxfb.h :

--- a/arch/arm/mach-imx/include/mach/imxfb.h
+++ b/arch/arm/mach-imx/include/mach/imxfb.h
@@ -14,7 +14,6 @@
 #define PCR_BPIX_8 (3 << 25)
 #define PCR_BPIX_12    (4 << 25)
 #define PCR_BPIX_16    (4 << 25)
+#define PCR_BPIX_MASK   (7 << 25)
 #define PCR_PIXPOL (1 << 24)
 #define PCR_FLMPOL (1 << 23)
 #define PCR_LPPOL  (1 << 22)

I take this opportunity to ask a question:
on APF27 with imx27, I found that the system freeze
when an interrupt handler is in place and an
interruption happens.
if interrupt handler is in place without interruption no
problems and if interruption happens without interrupt
handler it's ok too.

If someone could help or advise me. 
thank you very much

Gwenhael

Signed-off-by: gwenhael.goavec-merou@domain.hid

