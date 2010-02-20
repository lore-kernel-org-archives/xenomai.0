Message-ID: <4B805A4C.3010705@domain.hid>
Date: Sat, 20 Feb 2010 22:55:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460DD4DE8B@exchserver.basler.com>
	<181804936ABC2349BE503168465576460DDA2F4F@exchserver.basler.com>
	<181804936ABC2349BE503168465576460DE4CCFC@exchserver.basler.com>
	<4B7FBBB8.1010806@domain.hid>
	<181804936ABC2349BE503168465576460DE4CD0E@exchserver.basler.com>
	<4B803236.4040704@domain.hid>
	<181804936ABC2349BE503168465576460DE4CD12@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460DE4CD12@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supported I-pipe versions?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:

> I have read that.  In the README it lists the 2.6.24.6-DENX-2.4-03 patch
> in the list of older patches, and only makes a note that they are not
> guaranteed to work, but likely will as you try to maintain backward
> compatibility.  This patch was included in Xenomai 2.4.10 as
> 'ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24.6-powerpc-DENX-2.4-03.patc
> h', which seems to be leading to my confusion as this patch and kernel
> version seem to no longer work, and you are telling me it should have
> never worked.

I told you that it could appear to work, but was in fact buggy.

> 
> 
> So as to not dwell on this issue, is there a recommended version of the
> Linux kernel for running a PowerPC?  I was using a branch of the DENX
> tree for 2.6.24.6, as it had support for the MPC5121e.  The latest
> mainstream kernel that seems to have good support for this is the 2.6.33
> series, but I do not see an adeos patch for that version of the kernel
> either.  Maybe the 2.6.32 patch will work, but I haven't tried it.

The latest mainstream kernel release is 2.6.32, 2.6.33 was not yet
released, as you will find out by connecting to http://www.kernel.org.
So, there is a patch for the latest mainstream kernel release, and it is
included in Xenomai package, so, as said in the README file, you should
get better chances than by using a one year old kernel.

-- 
					    Gilles.

