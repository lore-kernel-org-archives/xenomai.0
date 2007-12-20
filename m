MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18282.49629.159795.612417@domain.hid>
Date: Thu, 20 Dec 2007 20:26:21 +0100
In-Reply-To: <456258.24487.qm@domain.hid>
References: <456258.24487.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

Michael Trimarchi wrote:
 > Hi,
 > 
 > > Ok. Could you try something ? It will work with I-pipe only but will
 > > break Xenomai, so do not try to run Xenomai over this modification.
 > > 
 > 
 > I tried the adeos-2.6.20-arm-1.8-02 patch and linux 2.6.20 and  I obtained the
 > same results. When the system is not loaded I can't receive from the serial
 > line using the adeos patch and null modem cable. 
 > 
 > AT91sam9260 8MB ram (using filesystem on ramdisk)
 > I removed spi flash support, mmc support.
 > I have only serial driver and using lrz for receiving file
 > 
 > Can I do some tests for you using my board? Do you have and updated patch 
 > for linux 2.6.23?

No, patch for Linux 2.6.23 is not there yet. Current I-pipe patch has
performance problems (probably a spurious interrupts masking section of
around 100us) which I would like to find first.

-- 


					    Gilles Chanteperdrix.

