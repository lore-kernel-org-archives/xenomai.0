MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18116.12841.787589.835796@domain.hid>
Date: Thu, 16 Aug 2007 13:16:57 +0200
In-Reply-To: <46C3FFD8.7010105@domain.hid>
References: <46C3FFD8.7010105@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH] fls() not available in Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > the attached patch fixes the following compilation error with Xenomai's 
 > head of trunk under Linux 2.4:
 > 
 > kernel/kernel.o(.text+0x135a4): In function `__rthal_generic_full_divmod64':
 > /temp/rtcan/devel/linuxppc_2_4_devel-xenomai/kernel/xenomai/arch/generic/hal.c:918: 
 > undefined reference to `fls'
 > kernel/kernel.o(.text+0x135b4):/temp/rtcan/devel/linuxppc_2_4_devel-xenomai/kernel/xenomai/arch/generic/hal.c:918: 
 > undefined reference to `fls'

Should be fixed now, thanks.

-- 


					    Gilles Chanteperdrix.

