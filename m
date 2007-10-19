From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200710182116.25461.paul_c@domain.hid>
References: <200710182116.25461.paul_c@domain.hid>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 05:38:12 +0200
Message-Id: <1192765092.6252.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] 2.6.23 x86_64 broken for SMP ?
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2007-10-18 at 21:16 +0100, Paul wrote:
> Attempting to compile on x86_64 with SMP enabled, getting quite a few failures 
> cetered around ipipe_declare_cpuid being undeclared in 
> arch/x86_64/kernel/ipipe.c.

It seems I forgot to compile with IPIPE_COMPAT off before releasing...
Sorry for that. This one should be ok:

http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.23-x86_64-1.2-05.patch

> Should we be including ipipe_compat.h or 
> following the lead set in arch/i386/kernel/ipipe.c ?
> 

We really want to get rid of the ipipe_get/lock_cpu constructs, so i386
should be followed.

> 
> Regards, Paul.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



