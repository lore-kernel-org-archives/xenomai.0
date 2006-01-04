From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17340.951.310449.498691@domain.hid>
Date: Wed, 4 Jan 2006 18:19:51 +0100
Subject: Re: [Xenomai-core] RTDM timerbench problems
In-Reply-To: <1136391676.5443.57.camel@domain.hid>
References: <1136391676.5443.57.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Stelian Pop wrote:
 > Before hanging, sometimes it just prints:
 > 	Unable to handle kernel NULL pointer dereference at virtual address 0000004d
 > 
 > Sometimes the oops is more complete (note that sometimes it also hangs in the middle of
 > the printout):
 > 	Unable to handle kernel NULL pointer dereference at virtual address 0000004d
 > 	pgd = c0004000
 > 	[0000004d] *pgd=00000000
 > 	Internal error: Oops: 817 [#1]
 > 	Modules linked in: xeno_timerbench
 > 	CPU: 0
 > 	PC is at xnpod_schedule+0x6b4/0x7f0
 > 	LR is at xnpod_schedule+0x54c/0x7f0
 > 	pc : [<c0056cc4>]    lr : [<c0056b5c>]    Not tainted
 > 	sp : c7d41830  ip : c79e8044  fp : c7d41860
 > 	r10: c0283c2c  r9 : c0282
 > 
 > Does this rings a bell to someone ? 

Not much, but two remarks:
- last summer, there use to be such a problem on x86 because of some
  wrong FPU switch. So, is FPU enabled ? Are you compiling latency with
  -msoft-float ?

  When announcing the ARM Adeos port, you told us that not all
  exceptions were trapped by the Adeos patch. If one of the FPU
  exceptions is not trapped, it would explain why we do not get the
  usual message "Invalid use of FPU at ..." before the oops.

- as far as I know, xnpod_schedule never recurses, so, there is little
  chance for PC and LR to be both in xnpod_schedule. If I am not wrong,
  it means that you will have to have a look at the disassembly (sorry)
  and see in really what functions the bugs happen. Sometimes the -r and
  -S option of objdump help...

-- 


					    Gilles Chanteperdrix.

