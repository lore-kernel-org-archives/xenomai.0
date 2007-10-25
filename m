Message-ID: <4720FB07.10606@domain.hid>
Date: Thu, 25 Oct 2007 22:22:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4720F828.1030200@domain.hid>
In-Reply-To: <4720F828.1030200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Proposed arch/powerpc/sysdev/uic.c patch
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
> I applied the uic patch:
> 
> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
> index eeb38e2..5a38086 100644
> --- a/arch/powerpc/sysdev/uic.c
> +++ b/arch/powerpc/sysdev/uic.c
> @@ -48,7 +48,7 @@ struct uic {
>     int index;
>     int dcrbase;
> 
> -    spinlock_t lock;
> +    ipipe_spinlock_t lock;
> 
>     /* The remapper for this UIC */
>     struct irq_host    *irqhost;
> 
> However, this would not compile because of a type mismatch.  I have
> added the attached patch, and it now compiles and runs.  But I'm not
> sure if this is the right way to fix it.  Comments?
> 

This will work for the purpose of running an I-pipe enabled kernel, but
would fail with CONFIG_IPIPE disabled. Since we need to provide both,
I'm going to work on the proper patch for fixing the issue both ways.
Still, your patch will work as expected for running Xenomai.

>     Steve
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

