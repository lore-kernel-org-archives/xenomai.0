From: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Date: Mon, 13 Jun 2016 08:52:11 +0000
Message-ID: <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610071612.GG1785@hermes.click-hack.org>
 <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610074538.GB18377@hermes.click-hack.org>
 <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB1230772D77FA28E0734AE2A5FF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>,
 <20160613084232.GP1785@hermes.click-hack.org>
In-Reply-To: <20160613084232.GP1785@hermes.click-hack.org>
Content-Language: en-IN
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
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

Yes

I tried running directly from BBB. but got an error stating timer files not=
 found. Now im trying an alternate way doing from my PC and cross compiling=
.



Process i tried on BBB which resulted errors

  1.  ./prepare-kernel.sh --linux=3D/home/debian/linux-4.1.18 --arch=3Darm =
=96ipipe=3D/home/debian/xenomai-3.0.2/kernel/cobalt/arch/arm/patches/ipipe-=
core-4.1.18-arm-4.patch

  2.  make bzImage module -------- > under linux kernel tree



Regards
Sripath Roy Koganti
________________________________
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Sent: 13 June 2016 14:12:32
To: Sripath Roy Koganti
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Resources for Installation of Xenomai 2.6 and 3 on i=
Mx6 Sabre Lite Dev Board

On Mon, Jun 13, 2016 at 08:36:39AM +0000, Sripath Roy Koganti wrote:
> While installing the package in Jessie debian resulted no package found.
>
> arm-none-linux-gnueabi-gcc

So, you are trying to cross compile?
See:
https://xenomai.org/installing-xenomai-3-x/#Cross-compilation

--
                                            Gilles.
https://click-hack.org
