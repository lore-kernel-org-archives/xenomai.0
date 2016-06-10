Date: Fri, 10 Jun 2016 09:16:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160610071612.GG1785@hermes.click-hack.org>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
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

On Fri, Jun 10, 2016 at 06:33:32AM +0000, Sripath Roy Koganti wrote:
> Hi
> 
> 
> I need help with porting Xenomai on Sabre Lite Board with iMx6
> Quad. Can you specify the resources and process to be done.

There is nothing board-specific in Xenomai, only SOC specific
support. And since Xenomai has already been ported to imx6, you do
not need to port anything, you just need to install Xenomai. We
provide installation instructions here (not imx6-specific, but the
installation instructions are the same for any SOC).

For 3.x:
https://xenomai.org/installing-xenomai-3-x/

For 2.x:
https://xenomai.org/installing-xenomai-2-x/
(pay attention to the Caution at the beginning; in a nut shell, if
you are starting a new development, there is no reason to start with
2.x).

-- 
					    Gilles.
https://click-hack.org

