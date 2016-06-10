From: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Date: Fri, 10 Jun 2016 07:32:30 +0000
Message-ID: <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>,
 <20160610071612.GG1785@hermes.click-hack.org>
In-Reply-To: <20160610071612.GG1785@hermes.click-hack.org>
Content-Language: en-IN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Should i do this process in a Linux Environment under the target board. Bas=
ically i am a newbie and its kindof looking complex. It would really help i=
f the process to be done can be explained.

Let me explain what i am trying to do.
I am deploying debian on Freescale with imX6 SOC
Then im looking for packages in debian (if they are precompiled) or else i =
will follow the proces you mentioned from knowledge base. Can you suggest w=
hich would be better.


Regards
Sripath Roy Koganti


________________________________________
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Sent: 10 June 2016 12:46:12
To: Sripath Roy Koganti
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Resources for Installation of Xenomai 2.6 and 3 on i=
Mx6 Sabre Lite Dev Board

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

