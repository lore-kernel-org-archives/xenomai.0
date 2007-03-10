MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17906.62022.298174.875008@domain.hid>
Date: Sat, 10 Mar 2007 19:00:38 +0100
Subject: Re: [Xenomai-help] Mach - LPC22xx Support
In-Reply-To: <e45fe62b0703080713x6e6bc227n86d9f026a6cb4015@domain.hid>
References: <e45fe62b0703080135q7ec8865eg8cba0efe20102053@domain.hid>
	<45F00C03.7000604@domain.hid>
	<e45fe62b0703080608i7317ae60v8f261e17851cfd45@domain.hid>
	<45F01E0B.7010908@domain.hid>
	<e45fe62b0703080713x6e6bc227n86d9f026a6cb4015@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai@xenomai.org

Preetam Joshi wrote:
 > Hi Gilles,
 >            Thanks a lot for your quick response. I am doing the same
 > activity. I am trying to port the xenomai patchfor LPC22xx on uClinux. I am
 > getting Undefined references for the symbols in ipipe-core.c,  ipipe-root.c.
 > So i am trying to map and define the correct values  from those files to
 > LPC22xx related files in arch/arm/mach-lpc22xx and in arch/arm/kernel. Is
 > this right thing i am doing? If you have any idea about how to port , Please
 > Let me know. It would be a great help from you.

Yes, you are doing the right thing. A simple way to do it is to have a
look at other machines. What needs to be written for a new ARM machine is:
- the hardware timer interrupt handling and timestamp counter emulation,
  if your timer hardware is based on a decrementer, have a look at the
  integrator implementation, if your timer hardware is based on a
  free-running counter with match register, have a look at the PXA
  implementation;
- if needed, the GPIOs interrupt demultiplexing, all implemented ARMs so
  far have this, so have a look at any of them.

-- 


					    Gilles Chanteperdrix.

