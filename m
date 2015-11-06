References: <75a98ced-93d1-467e-b9ac-61cd71e067c1@THSUMIDEUMSG04P.deu.umi.grp>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <563CC839.307@xenomai.org>
Date: Fri, 6 Nov 2015 16:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <75a98ced-93d1-467e-b9ac-61cd71e067c1@THSUMIDEUMSG04P.deu.umi.grp>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with rt_pipe after update
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: BECK Fabrice - Contractor <Fabrice.BECK@external.thalesaleniaspace.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: NARBONNE Frederic <Frederic.NARBONNE@thalesaleniaspace.com>

On 11/06/2015 04:03 PM, BECK Fabrice - Contractor wrote:
> Dear Xenomai support,
> 
> After a migration from CentOs 6.4 (linux-3.8.13_xenomai-2.6.3) to RHEL 7.1 (linux-3.10.32-xenomai-2.6.4) on a new workstation
> and update of Xenomai we have transfer rate problems.
> 
> On the old machine we managed to get transfer rates of 260 Mbps with our application.
> On the new machine we are stuck at 78 Mbps with our application.
> 
> With some test tool we are able to send at higher rates, so it seems not to be linked to our Ethernet driver.
> Our application is the same on both machines.
> 
> After some preliminary investigation, we suspect a problem with the rt_pipes (as the problems we see are part of the SW using them),
> yet we don't see anything wrong in the Xenomai configuration.
> Do you have an idea how we could track down this problem?
> 

I'm unsure to understand how you came up with such conclusion about
rt-pipes being involved in an ethernet traffic drop down for your
application, unless your application somehow relays the network traffic
via rt-pipes before it reaches the NIC.

Anyway, I would suggest:

1. to pull from the Xenomai 2.6.x maintenance branch, there are fixes
there not present in 2.6.4, some of which updating the rt-pipe support.
http://git.xenomai.org/xenomai-2.6.git/

2. check the behavior of your application by looking at
/proc/xenomai/stat when it runs, particularly the MSW column.

-- 
Philippe.

