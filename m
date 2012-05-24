Message-ID: <4FBE6641.1070205@xenomai.org>
Date: Thu, 24 May 2012 18:48:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Testers wanted for 3.2.1/powerpc, P2020, any e500v2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai MailingList <xenomai@xenomai.org>


We need someone to checkout out the latest pipeline "core" series on a 
Freescale P2020 board. I ported the Xenomai core to P1022 over this 
significantly revised pipeline architecture lately, so we should not be 
that far from having this working on P2020.

More generally, if you have any result with other e500v2-based 
platforms, don't hesitate to let us know. Specifically, finding out the 
best default latency calibration figure to set in /proc/xenomai/latency 
for them would help.

If you can and want to help, please pull from this branch, and let me 
know how it goes.

git://git.denx.de/ipipe-2.6.git, branch core-3.2

TIA,

-- 
Philippe.

