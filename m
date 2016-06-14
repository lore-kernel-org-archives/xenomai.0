Date: Tue, 14 Jun 2016 10:59:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160614085937.GB3060@hermes.click-hack.org>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610071612.GG1785@hermes.click-hack.org>
 <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610074538.GB18377@hermes.click-hack.org>
 <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB1230772D77FA28E0734AE2A5FF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613084232.GP1785@hermes.click-hack.org>
 <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613085719.GR1785@hermes.click-hack.org>
 <SG2PR01MB1230A72993D684166375BE97FF540@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB1230A72993D684166375BE97FF540@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
Subject: Re: [Xenomai] Resources for Installation of Xenomai 2.6 and 3 on
 iMx6 Sabre Lite Dev Board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jun 14, 2016 at 04:23:26AM +0000, Sripath Roy Koganti wrote:
> I am done with building a new kernel from BBB. but it took me more
> than 4 hours to complete the kernel compilation. 

Yes, that is the downside of compiling on target. Did you expect a
processor with such a low consumption to have the power of your PC?

> Now i have zImage and Image available in arch/arm/boot/ ....
> unable to install the kernel

I have the same remark as before. You tell us something is wrong,
but you do not give us any information. We need to see the exact
error you get in order to be able to help you.

Anyway, what is needed to install the kernel depends on the
distribution you use, the bootloader you use etc... but the good
news is that installing the kernel with Xenomai included is not
different from installing a custom-built Linux kernel, so the
information you find on your board website apply.

-- 
					    Gilles.
https://click-hack.org

