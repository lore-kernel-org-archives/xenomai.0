From: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Date: Fri, 10 Jun 2016 07:51:27 +0000
Message-ID: <SG2PR01MB1230165E11DF45A8D3E2F7DBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB12300E6F7AC1284011B6FBBBFF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
 <20160610071612.GG1785@hermes.click-hack.org>
 <SG2PR01MB1230DD21BB16D91C6E68F1D5FF500@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>,
 <20160610074538.GB18377@hermes.click-hack.org>
In-Reply-To: <20160610074538.GB18377@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks

I am going ahead with following the instructions from the given page.
https://xenomai.org/installing-xenomai-3-x/

I will do the following (Correct me if i am wrong)
1) Install Debian on Sabre Lite Board
2) Download Xenomai Kernel (in the target board running Debian)
3) Follow the process given in the link https://xenomai.org/installing-xeno=
mai-3-x/


Am i headed in a right way??


Regards
Sripath Roy Koganti

________________________________________
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Sent: 10 June 2016 13:15:38
To: Sripath Roy Koganti
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Resources for Installation of Xenomai 2.6 and 3 on i=
Mx6 Sabre Lite Dev Board

On Fri, Jun 10, 2016 at 07:32:30AM +0000, Sripath Roy Koganti wrote:
> Should i do this process in a Linux Environment under the target
> board. Basically i am a newbie and its kindof looking complex. It
> would really help if the process to be done can be explained.

The process is explained on the page I sent you. Whether you
cross-compile or not is your choice, the procedure is almost the
same in both cases.

>
> Let me explain what i am trying to do. I am deploying debian on
> Freescale with imX6 SOC Then im looking for packages in debian (if
> they are precompiled) or else i will follow the proces you
> mentioned from knowledge base. Can you suggest which would be
> better.

Your choice again. We have a page explaining how to build Debian
packages.
https://xenomai.org/2014/06/building-debian-packages/

My opinion on that is that building debian packages is more complex
than simply compiling and installing following the generic
instructions, so there are many more things that can go wrong. So, I
would only do it if I need the benefits of using debian packages:
being able to build the packages once, and deploy them on several
machines. But this is simply my opinion.

--
                                            Gilles.
https://click-hack.org

