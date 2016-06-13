Date: Mon, 13 Jun 2016 10:57:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160613085719.GR1785@hermes.click-hack.org>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610071612.GG1785@hermes.click-hack.org>
 <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610074538.GB18377@hermes.click-hack.org>
 <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB1230772D77FA28E0734AE2A5FF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160613084232.GP1785@hermes.click-hack.org>
 <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB123046BD62C63FCE5467025BFF530@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
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

