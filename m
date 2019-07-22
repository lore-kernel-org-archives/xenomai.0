MIME-Version: 1.0
From: danwe <daniel.wenninger92@gmail.com>
Date: Mon, 22 Jul 2019 17:58:40 +0200
Message-ID: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
Subject: TDMA with RTnet on Xenomai
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have Xenomai 2 with RTnet on a BeagleBone Black. I ask myself how  I
can run TDMA on BeagleBone Black? Programs like RTping and Roundtrip
program are working.

I have changed the rtnet.conf file so that it will use TDMA.conf file.
In TDMA.conf all parameters like IP-address, clock cycle and slottime
are determined.
In rtnet file I saw some drivers like rtmac. Do I have to load that
driver for using TDMA as it is not loaded yet? Are there any other
drivers beside rtudp, rtipv4, rtpacket, rt_ticpsw, rt_davinci_mdio,
rt_smsc, rtnet and omap_rng which need to be loaded?

And now I ask myself how can I run TDMA? Is it just using the IPs
(which are written in your TDMA.conf file) for your microcomputer, and
that's it?
If TDMA will work, do I see any output of my communication cycle or
anything that shows that TDMA is running? At the moment I don't see anything.
What else do I have to change in rtnet.conf? I have just changed the
very last line for using TDMA.conf file and I have changed TDMA_MODE
to master for my master BBB and to slave for my slave BBB.

So just the short question: What to do to use TDMA?

Kind Regards

Daniel
