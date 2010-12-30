From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <201012300654.27439.paul_c@domain.hid>
References: <201012300654.27439.paul_c@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Dec 2010 09:16:03 +0100
Message-ID: <1293696963.1837.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Bug in 2.6.35-7 patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Thu, 2010-12-30 at 06:54 +0000, Paul wrote:
> Compiling the current ipipe patch for x86 
> (adeos-ipipe-2.6.35.7-x86-2.8-00.patch), hit a problem with 
> __ipipe_spin_unlock_debug being unresolved. Digging in to 
> linux/ipipe.h, I see it is conditional on CONFIG_IPIPE_DEBUG_INTERNAL, 
> yet in core.c, it also depends on CONFIG_SMP. The blackfin & powerpc 
> patches are correct... Could someone please take a look at ipipe.h, 
> line 193 and confirm the error.

Confirmed. The fix is already pending in the GIT tree. I'll issue 2.8-01
today.

> 
> Regards, Paul.
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



