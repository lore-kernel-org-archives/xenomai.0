Message-ID: <43BE626A.6000500@domain.hid>
Date: Fri, 06 Jan 2006 13:28:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43BE5E3E.1060208@domain.hid>
In-Reply-To: <43BE5E3E.1060208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Oops, I broke something
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> my RTDM header "optimisation" broke the compilation of
> testsuite/latency. I need an extra link for the userspace compilation
> inside xeno now. Please apply this patch
> 
> --- configure.in        (Revision 372)
> +++ configure.in        (Arbeitskopie)
> @@ -348,6 +348,8 @@
> 
>  base=include
>  AC_CONFIG_LINKS([src/include/xenomai:$base])
> +base=rtdm
> +AC_CONFIG_LINKS([src/include/$base:include/$base])
>  base=asm-$XENO_TARGET_ARCH
>  AC_CONFIG_LINKS([src/include/asm/xenomai:include/$base])
>  base=asm-generic
> 
> and run bootstrap. Sorry.
> 
> But this raised the question to me again if we really need the "xenomai"
> prefix for all the skin headers /from within xenomai/. Why not doing the
> same linking dance for the other skins as well? Or do you also prefer
> that user include <xenomai/native/task.h> instead of just <native/task.h>?

We need this for building from within the kernel. Other options would 
require to either alter the Xenomai source tree adding symlinks there, 
pollute linux/include with symlinks to reach the individual Xeno 
components, or refer to some external tree that eventually redirects to 
the Xenomai tree, which is not acceptable in any case.

-- 

Philippe.

