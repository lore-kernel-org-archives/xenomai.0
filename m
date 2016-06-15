From: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Date: Wed, 15 Jun 2016 12:54:35 +0000
Message-ID: <SG2PR01MB1230B7E711E9B9A0021E128CFF550@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610071612.GG1785@hermes.click-hack.org>
 <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610074538.GB18377@hermes.click-hack.org>
 <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB1230772D77FA28E0734AE2A5FF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613084232.GP1785@hermes.click-hack.org>
 <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613085719.GR1785@hermes.click-hack.org>
 <SG2PR01MB1230A72993D684166375BE97FF540@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>,
 <20160614085937.GB3060@hermes.click-hack.org>
In-Reply-To: <20160614085937.GB3060@hermes.click-hack.org>
Content-Language: en-IN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I tried to install the following way


Added this repo

add this repo
deb [arch=3Darmhf] http://repos.rcn-ee.com/debian/ jessie main

sudo apt-get install linux-image-3.8.13-xenomai-r78 linux-headers-3.8.13-xe=
nomai-r78 linux-firmware-image-3.8.13-xenomai-r78

wget https://xenomai.org/downloads/xenomai/stable/xenomai-
2.6.4.tar.bz<http://2.6.4.tar.bz/>2
tar xvjf xenomai-2.6.4.tar.bz<http://xenomai-2.6.4.tar.bz/>2
cd xenomai-2.6.4
./configure
make
sudo make install


after that i tried to run apps from /usr/xenomai/bin  i got this


Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)




Regards
Sripath Roy Koganti

________________________________
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Sent: 14 June 2016 14:29:38
To: Sripath Roy Koganti
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Resources for Installation of Xenomai 2.6 and 3 on i=
Mx6 Sabre Lite Dev Board

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
