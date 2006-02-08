From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 8 Feb 2006 20:33:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602082033.52077.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Errors compiling fpu.o (xenomai trunk) if
	CONFIG_PPC601_SYNC_FIX=y
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I got the following errors when my .config contained
a CONFIG_PPC601_SYNC_FIX=y
  AS      arch/ppc/xenomai/fpu.o
/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xenomai/fpu.S: Assembler 
messages:
/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xenomai/fpu.S:54: Error: 
Unrecognized opcode: `begin_ftr_section'
<..>

After unsetting CONFIG_PPC601_SYNC_FIX, the compilation proceeded without any 
problem.

Best regards

-- 
Niklaus Giger

