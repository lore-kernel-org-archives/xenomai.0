From: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Date: Tue, 14 Jun 2016 04:23:26 +0000
Message-ID: <SG2PR01MB1230A72993D684166375BE97FF540@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610071612.GG1785@hermes.click-hack.org>
 <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610074538.GB18377@hermes.click-hack.org>
 <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB1230772D77FA28E0734AE2A5FF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613084232.GP1785@hermes.click-hack.org>
 <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>,
 <20160613085719.GR1785@hermes.click-hack.org>
In-Reply-To: <20160613085719.GR1785@hermes.click-hack.org>
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

I am done with building a new kernel from BBB. but it took me more than 4 h=
ours to complete the kernel compilation.


Now i have zImage and Image available in arch/arm/boot/ .... unable to inst=
all the kernel



Regards
Sripath Roy Koganti

________________________________
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Sent: 13 June 2016 14:27:19
To: Sripath Roy Koganti
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Resources for Installation of Xenomai 2.6 and 3 on i=
Mx6 Sabre Lite Dev Board

On Mon, Jun 13, 2016 at 08:52:11AM +0000, Sripath Roy Koganti wrote:
> Yes
>
> I tried running directly from BBB. but got an error stating timer
> files not found. Now im trying an alternate way doing from my PC
> and cross compiling.

Do not waste your time doing that. Please report the problem you get
when compiling directly on the board, but clearly, more than just
"got an error stating timer files not found", at which point, during
compilation, at run-time? etc... Send the full compilation logs if
this is an error at compilation time, or the full kernel logs if
this is a run-time error.

Changing where the compiler run will probably not change anything.

--
                                            Gilles.
https://click-hack.org
