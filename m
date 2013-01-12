In-Reply-To: 
References: 
From: mfornero@aanddtech.com
Message-ID: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
Date: Sat, 12 Jan 2013 12:21:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

   Hi All,

   I'm looking for recommendations on how to best port ipipe support to a
   new ARM SoC. The SoC has started to show up in mainline, but many of
   the features haven't made it over yet. Xilinx maintains a git repo
   here:

   git://git.xilinx.com/linux-xlnx.git

   And it look like they've synced with mainline 3.6

   The two approaches I've considered were either trying to port ipipe to
   stock 3.6 (or at least the generic and ARM bits) or trying to backport
   the Xilinx code to 3.5.3. I started with the later approach, but some
   changes to the common clock architecture between 3.5 and 3.6 make this
   somewhat difficult.

   Any thoughts on which approach would be better?

   Best Regards,

   Matthew Fornero
   This email transmission may contain information that is confidential or
   legally privileged. If you are not the intended recipient, you are
   hereby notified that any disclosure, copying, printing, distribution or
   use of this transmission is strictly prohibited. If you have received
   this transmission in error, please notify the sender immediately and
   delete the original transmission and its attachments without reading or
   saving in any manner.
