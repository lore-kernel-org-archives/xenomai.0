MIME-version: 1.0
From: Tomasz Guszkowski <tomasz.guszkowski@pwr.wroc.pl>
Message-id: <fd35ecb7304a.4ffd9779@pwr.wroc.pl>
Date: Wed, 11 Jul 2012 15:10:49 +0200
Content-language: pl
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Subject: [Xenomai] Xenomai FlexCAN driver - where to start?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello!

I am to write a MPC8309 (powerpc made by Freescale) FlexCAN driver for Xenomai. I have a working non-RT driver for this machine. Xenomai 2.6.0 works flawlessly as far I can assess it.

I have started converting a non-RT version of the driver to rtdm (rtcan) API and after some time spent on it I have an impression it will last a good while. (I am new to Xenomai driver development.)

I have also analyzed mscan and sja1000 drivers and the conclusion is that RT and non-RT versions have almost no common parts, at least meld can't easily point them.

So the questions are:

What is the preferrable starting point for writing Xenomai CAN driver? 
Is my path (non-RT driver -> rtdm/rtcan driver) optimal? 
Does there exist a better way, for example a kind of a "template" for filling up with some HW-specific code?
Now I think about trying to use a crippled mscan version as a template, despite the fact that mscan and FlexCAN have no common parts besides using Flattened Device Tree for HW description.Is this a good idea?

Any hints are welcomed.

--
Tomek
