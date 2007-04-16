From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17955.64120.90606.670609@domain.hid>
Date: Tue, 17 Apr 2007 00:36:40 +0200
In-Reply-To: <1176585372.15994.14.camel@domain.hid>
References: <1176585372.15994.14.camel@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Support EABI enabled kernels on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: xenomai@xenomai.org

Stelian Pop wrote:
 > Hi,
 > 
 > The attached patch adds an option to make Xenomai userspace issue EABI
 > syscalls. This is needed to make Xenomai work with kernels compiled with
 > CONFIG_EABI.
 > 
 > Note that due to a change in syscall handling when the EABI layer was
 > added in the kernel, this patch is needed for all EABI enabled kernels,
 > even if the CONFIG_OABI_COMPAT compatibility layer has been enabled.
 > 
 > All sensible combinations should be supported: old ABI userspace with
 > old ABI kernel, old ABI userspace with CONFIG_OABI_COMPAT kernels, EABI
 > userspace with EABI kernels. The other combinations will fail with a
 > SIGILL signal.
 > 
 > Don't forget to run 'scripts/bootstrap' after applying this patch...

Applied, thanks. And by the way, I am running Debian Etch, and its
version of autotools seems to complain that we do not use datarootdir in
xeno-config.in... 

-- 


					    Gilles Chanteperdrix.

