From: Leopold Palomo Avellaneda <leo@alaxarxa.net>
Date: Sun, 26 May 2013 02:24:59 +0200
References: <1369479458.60083.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51A0FE20.5040202@control.lth.se>
In-Reply-To: <51A0FE20.5040202@control.lth.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201305260224.59809.leo@alaxarxa.net>
Subject: Re: [Xenomai] Xenomai, rtnet and ethercat
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Franz Engel <franz_lambert_engel@yahoo.de>

A Dissabte, 25 de maig de 2013, Anders Blomdell va escriure:
> On 05/25/2013 12:57 PM, Franz Engel wrote:
> > Hi,
> > 
> > I have to connect my realtime xenomai system with an lasertracker. The
> > tracker is using ethercat. Has somebody experiences to do this? I would
> > like to use rtnet as realtime stack. Is it possible to use an ethercat
> > master with rtnet driver? Or is there a realtime ethercat master
> > available?
> > 
> > I found the following Ethercat projects (but I think they have no
> > ethercat capables): http://soem.berlios.de/
> > http://etherlab.org/en/ethercat/index.php
> 
> Read the licensing terms carefully, last time I looked, the EtherCAT
> license was not compatible with open licenses like GPL (see
> https://mail.gna.org/public/xenomai-help/2009-10/msg00074.html)
> 

I'm not a lawyer and I cannot make an opinion about that. I have read a lot 
about ethercat, and its license and I have to admit that it's a bit of mess. 

My recommendation is that if you don't want to make a commercial product, or 
sell your software, you can use any of the two  ethercat master: soem and 
etherlab. I don't think that Beckhoff makes you problems. If you want to do any 
commercial product, ask to Beckoff first.

About your question, etherlab provides a ethercat master under xenomai or 
rtai. You have a limited options of drivers with both, but realtime 
capabilities.

Etherlab provides also ethercat master with standard kernel drivers with 
PREMPT_RT, so you could have a softrealtime with any NIC supported by the 
kernel.

Soem provides also ethercat master, but it doesn't provides officially support 
under xenomai (or rtai). You must use any standard driver and could work under 
PREMPT_RT. 

The orocos developers have a version of soem that works with rtnet, but it has 
not been worked quit well for us, so by now, I cannot recommend it. However, I 
have to say that I have to review it because it has been changed a lot.

We have use soem with an standard ethernet driver and xenomai and we have been 
able to communicate with or servos at 1 ms.

Hope it helps.

Regards,

Leopold








-- 
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

