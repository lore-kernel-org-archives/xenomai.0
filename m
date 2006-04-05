Message-ID: <4433D801.6050100@domain.hid>
Date: Wed, 05 Apr 2006 16:45:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems building xenomai 2.1 for ppc
References: <02AA386EB831044F8537A696BA785C78A664EF@ILEX5.IL.NDS.COM>
In-Reply-To: <02AA386EB831044F8537A696BA785C78A664EF@ILEX5.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

Landau, Bracha wrote:
> I'm trying to build xenomai 2.1 for an 8272 architecture using kernel 2.6.14.
> I've successfully put in the adeos patch.
> Here are the problems I've encountered.
> 
> 1) When doing ./scripts/prepare-kernel.sh I get an error that it can't find the file /include/asm-powerpc/ipipe.h.
> I copied the file ipipe.h from /include/asm-ppc and reran prepare-kernel.sh with no errors.
> 

You don't need to move kernel files around manually (actually, this 
almost never works properly). Please have a look at README.INSTALL, 
section 1 "Preparing the target kernel".

> 2) After doing the above and configuring the "prepared" kernel for running with xenomai, I tried to build the kernel. I got link errors doing it. An example of such a link error is:
> 
> kernel/built-in.o: In function 'rthal_init':
> :undefined reference to 'rthal_arch_init'
> 
> 
> (The list is much longer - many undefined references of this sort.)
> 
> Any ideas what the problem may be?
> 
> ***********************************************************************************
> This email message and any attachments thereto are intended only for use by the addressee(s) named above, and may contain legally privileged and/or confidential information. If the reader of this message is not the intended recipient, or the employee or agent responsible to deliver it to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the postmaster@domain.hid and destroy the original message.
> ***********************************************************************************
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

