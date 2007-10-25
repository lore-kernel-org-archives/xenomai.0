Message-ID: <472105E2.4040801@domain.hid>
Date: Thu, 25 Oct 2007 23:08:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4721048B.3040703@domain.hid>
In-Reply-To: <4721048B.3040703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Compile-time patch for mm_struct
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> I needed the following patch to fix a forward reference (caught by gcc 4.1.1).  I posted this as part of an earlier discussion, but I then realized that it might be overlooked, so I'm reposting it as a new thread:
>

Thanks. This one was caught a few days back and only recently merged. I guess
it's time to roll out a new 2.6.23/powerpc I-pipe patch.

> --- /home/sfalco/ipipe.h	2007-10-25 12:59:12.000000000 -0400
> +++ include/linux/ipipe.h	2007-10-25 12:59:23.000000000 -0400
> @@ -31,6 +31,8 @@
>  #include <linux/ipipe_compat.h>
>  #include <asm/ipipe.h>
>  
> +struct mm_struct;
> +
>  #ifdef CONFIG_IPIPE
>  
>  #define IPIPE_VERSION_STRING	IPIPE_ARCH_STRING
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

