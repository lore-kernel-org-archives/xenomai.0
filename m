Message-ID: <472F61D1.8040206@domain.hid>
Date: Mon, 05 Nov 2007 19:32:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1194284583.5882.10.camel@domain.hid>
In-Reply-To: <1194284583.5882.10.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai adeos patch for 2.6.16.11 kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Matt Kelsey <mattkelsey@domain.hid>
Cc: xenomai@xenomai.org

Matt Kelsey wrote:
> Greetings,
> I am updating a project built on the 2.6.10 Linux kernel with fusion
> 0.9.1 to the Freescale provided 2.6.16.11 kernel with MPC5200b specific
> patches (lite5200b).  I see that adeos patches are available for kernel
> versions 2.6.14 and 2.6.18.  
> Can anyone offer advise on how I might bridge the gap here?  Is it
> possible to adjust either of the available adeos patches to fit my
> Freescale supported version or would it be better to update my 2.6.16.11
> kernel to a adoes supported version( i.e. 2.6.18).  
> Any advise on how to accomplish this by these or other means would be
> appreciated.

Upgrading the old Adeos patch from 2.6.14 to 2.6.16 would probably be 
simpler than downgrading from 2.6.18 to 2.6.16. If you choose to upgrade 
the kernel, you can either go for 2.6.20, 2.6.21 or 2.6.23, based on the 
powerpc/ tree, which supports the lite5200b.

In both cases (Adeos or kernel upgrade), you will need to upgrade from 
fusion to Xenomai though (recommended), or at least backport the needed 
bits to support later kernels (very likely not as sane as upgrading from 
fusion to Xenomai anyway).

http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.20-powerpc-1.7-07.patch
http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.21-powerpc-1.7-05.patch
http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch

> 
> Thanks for your help,
> 
> Matt
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


