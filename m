Date: Wed, 15 Jun 2016 15:50:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160615135004.GU23680@hermes.click-hack.org>
References: <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610074538.GB18377@hermes.click-hack.org>
 <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB1230772D77FA28E0734AE2A5FF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613084232.GP1785@hermes.click-hack.org>
 <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613085719.GR1785@hermes.click-hack.org>
 <SG2PR01MB1230A72993D684166375BE97FF540@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160614085937.GB3060@hermes.click-hack.org>
 <SG2PR01MB1230B7E711E9B9A0021E128CFF550@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB1230B7E711E9B9A0021E128CFF550@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
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

On Wed, Jun 15, 2016 at 12:54:35PM +0000, Sripath Roy Koganti wrote:
> I tried to install the following way
> 
> 
> Added this repo
> 
> add this repo
> deb [arch=armhf] http://repos.rcn-ee.com/debian/ jessie main
> 
> sudo apt-get install linux-image-3.8.13-xenomai-r78 linux-headers-3.8.13-xenomai-r78 linux-firmware-image-3.8.13-xenomai-r78
> 
> wget https://xenomai.org/downloads/xenomai/stable/xenomai-
> 2.6.4.tar.bz<http://2.6.4.tar.bz/>2
> tar xvjf xenomai-2.6.4.tar.bz<http://xenomai-2.6.4.tar.bz/>2
> cd xenomai-2.6.4
> ./configure
> make
> sudo make install
> 
> 
> after that i tried to run apps from /usr/xenomai/bin  i got this
> 
> 
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)

So, you changed the procedure again? Can you not finish just once
what you started? I am sorry, but I do not know that debian
repository and what it contains exactly, maybe it has a website with
some information?

Other than that, that error is documented in the troubleshooting
guide:
https://xenomai.org/troubleshooting-a-dual-kernel-configuration/#native_skin_or_CONFIG_XENO_OPT_PERVASIVE_disabled

-- 
					    Gilles.
https://click-hack.org

