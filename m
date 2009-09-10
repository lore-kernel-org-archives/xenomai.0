Message-ID: <4AA93B24.8010802@domain.hid>
Date: Thu, 10 Sep 2009 19:45:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>	<4AA6BC5D.8020704@domain.hid>	<7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>	<4AA7C4F7.6000903@domain.hid>	<7a15153d0909091206y5d16ffcck32d0c8cc3c120f6c@domain.hid>	<4AA820D4.8000302@domain.hid>
	<7a15153d0909101028p11716996q7929815b6b65ccb0@domain.hid>
In-Reply-To: <7a15153d0909101028p11716996q7929815b6b65ccb0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High Latency on PXA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> I'm a little bit lost about this issues cause when running the xenomai
> 2.4.8 with the patch that you send me it worked, but with new version it
> doesn't work.
> Acctually i using the kernel 2.6.27 and i understand what you told me ,
> in version 2.4.9.1 there aren't a patch to this kernel version, neither
> xenomai 2.4.8.  :S

2.4.8 appeared to work, but it had a bug.
See https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html

> 
> The problem is, I'm using a Voipac development kit, and the have only
> the kernel 2.6.27 BSP.
> 
> So , i tried to disable the float point emulation but the kernel didn't
> load OK .

It proves that your user-space support is compiled for hardware float,
but not PXA hardware floats. This is a pure waste of CPU power. See:

http://www.arm.linux.org.uk/mailinglists/faq.php#f3

Note that Xenomai applications compiled that way will not work either.

-- 
                                          Gilles


