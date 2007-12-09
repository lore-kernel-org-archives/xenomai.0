MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18268.5917.619555.657394@domain.hid>
Date: Sun, 9 Dec 2007 17:26:05 +0100
In-Reply-To: <475C13C6.8080508@domain.hid>
References: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
	<475C13C6.8080508@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] BUG while modprobing nucleus - no SMI workaround
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Giammarco Zacheo wrote:
 > > Just installed kernel 2.6.23.9 with Xenomai 2.4-rc7 on my quad-core
 > > machine, and I got this on the console:
 > > 
 > ...
 > > 
 > > I-pipe: Domain Xenomai registered.
 > > Xenomai: hal/x86_64 started.
 > > Xenomai: real-time nucleus v2.4-rc7 (Bells Of Lal) loaded.
 > > Xenomai: SMI-enabled chipset found
 > > Xenomai: SMI workaround failed!
 > 
 > And that's a different story, likely. Can you post your lspci -nn?

"SMI workaround failed" does not mean that the chipset is not supported,
it means that the chipset is supported but that masking/settting the SMI
bits failed, probably because the BIOS locked the SMI bits.

-- 


					    Gilles Chanteperdrix.

