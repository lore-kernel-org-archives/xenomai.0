From: Alex Plits <alex_plits@radwin.com>
Date: Thu, 7 Apr 2016 05:56:35 +0000
Message-ID: <AM3PR06MB1282EDA8459215FC1B64D3118F900@AM3PR06MB1282.eurprd06.prod.outlook.com>
References: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <20160405070232.GI20399@hermes.click-hack.org>
In-Reply-To: <20160405070232.GI20399@hermes.click-hack.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
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



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, April 05, 2016 10:03 AM
> To: Alex Plits
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
> 
> On Mon, Apr 04, 2016 at 01:42:11PM +0000, Alex Plits wrote:
> > Hi,
> >
> > We are currently porting some of our vxWorks  xenomai (copperplate)
> > APIs we use in our application to Posix (cobalt I guess).
> 
> Well, if you do not know whether you are using Cobalt or Mercury, we can
> not know it for you...
[Alex Plits] 
Cobalt :)
> 
> > We have started with the VxWorks "tasks" but it seems that we're
> > getting strange behavior on The remaining VxWorks APIs when used from
> the POSIX generated tasks (threads is the right word in posix) e.g. MsqQRecv
> function gets segfault but when it is used From a VxWorks generated task it
> works fine.
> > I understand from the comments in code it should work but I was
> wondering if there are known issues.
> >
> > We are using currently xenomai 3 rc-6 (I saw there were fixes in xenomai
> 3.0.2).
> 
> Could you send a self-contained, simplest possible test case which causes the
> problem for you, that we can test on the latest Xenomai release to see if the
> problem has not been already fixed?
> 
[Alex Plits] 
Attached code that is ripped from xenomai examples and initiates 2 threads using posix api then uses VxWorks MsgQ to communicate.
Please advise if this code works as expected -  it seems that when we use WAIT_FOREVER flag we have an issue.

Sorry in advance for the #ifdef's and comments in code -
Thanks,
Alex Plits.

> Regards.
> 
> --
> 					    Gilles.
> https://click-hack.org
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: posix_vxworks_test.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160407/e52fcb1d/attachment.c>
