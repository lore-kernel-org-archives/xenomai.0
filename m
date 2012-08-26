From: Paul <paul_c@tuxcnc.org>
Date: Sun, 26 Aug 2012 22:52:27 +0100
MIME-Version: 1.0
Message-Id: <201208262252.27556.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] oops on ARM1176 SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Finally got hold of an RS232 interface for my ARM1176 board and have 
been trying to capture a fatal kernel crash log. Have compiled various 
kernels and pared the config down to a bare minimum - The trace for the 
latest crash is attached. This happens when unloading xeno-nucleus, 
kinda at a loss as to where to go from here, so any pointers would be 
much appreciated.

Regards, Paul.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: bcm2835-crash.log
Type: text/x-log
Size: 7076 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120826/4f9795c9/attachment.bin>
