Message-ID: <4C454C0C.6000100@domain.hid>
Date: Tue, 20 Jul 2010 09:11:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid> <4C43D265.9080609@domain.hid>
	<4C43FC4F.3010006@domain.hid> <4C440D6F.1060204@domain.hid>
	<4C44E9C9.3020600@domain.hid>
In-Reply-To: <4C44E9C9.3020600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   The debounce clock is not the source of the problem.
> On the 2430 chip, the debounce clock is under software control. For the 
> OMAP3 chips, its been placed under hardware control. So the 2.6.31 
> kernel classifies the  this message as a warning...
> 
> 1053         host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
> 1054         /*
> 1055          * MMC can still work without debounce clock.
> 1056          */
> 1057         if (IS_ERR(host->dbclk))
> 1058                 dev_warn(mmc_dev(host->mmc), "Failed to get 
> debounce clock\n");
> 1059         else
> 
> In the 2.6.33 kernel the message has been made 2430 specific...
> 
> 1709         if (cpu_is_omap2430()) {
> 1710                 host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
> 1711                 /*
> 1712                  * MMC can still work without debounce clock.
> 1713                  */
> 1714                 if (IS_ERR(host->dbclk))
> 1715                         dev_warn(mmc_dev(host->mmc),
> 1716                                 "Failed to get debounce clock\n");
> 1717                 else
> ... snipped ...                                       " clk failed\n");
> 1724         }
> 
> I removed all of the patches  and rebuilt without the Adeos patch. I 
> lost host USB Host Port capability, but the BeagleBoard booted.
> 
> I then applied the Adeos patch, but disabled Xenomai. The result is the 
> same. The board hangs waiting for /dev/mmcblk0p2.

What about testing 2.6.33 ?

-- 
					    Gilles.

