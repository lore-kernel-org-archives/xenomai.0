From: Henry Bausley <hbausley@domain.hid>
In-Reply-To: <4A89DDE8.2010907@domain.hid>
References: <1250186541.23699.8.camel@domain.hid>
	<4A845C93.4060302@domain.hid>	<1250200537.28789.8.camel@domain.hid>
	<4A8808BA.4080504@domain.hid>	<1250543873.14029.5.camel@domain.hid>
	<4A89D5BC.3050006@domain.hid>  <4A89DDE8.2010907@domain.hid>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 08:29:35 -0700
Message-Id: <1250609375.19848.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
	pthread_setschedparam:	Resource	temporarily	unavailable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Thank you the memory leak is gone.

On Tue, 2009-08-18 at 00:47 +0200, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > Henry Bausley wrote:
> >> I used the defaults that came up for my 2.6.28.8 kernel I-pipe 2.4-05.
> >> I'll rebuild the kernel with 2.6
> > 
> > Ok. Forget it, I can reproduce it. I simply forgot to enable Xenomai
> > posix skin shared memories in the kernel configuration. The bug does not
> > happen on head though, only on 2.4. And this with the same version of
> > the I-pipe.
> 
> It should be fixed in the repository. Here is the patch:
> 
> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
> index ec0c102..898cc91 100644
> --- a/ksrc/skins/posix/syscall.c
> +++ b/ksrc/skins/posix/syscall.c
> @@ -2717,6 +2717,8 @@ static int __munmap_epilogue(struct pt_regs *regs)
>         xnlock_put_irqrestore(&pse51_assoc_lock, s);
> 
>         err = munmap(umap->kaddr, len);
> +       if (!err)
> +               xnfree(umap);
> 
>         return !err ? 0 : -thread_get_errno();
>  }
> 
> 



**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************

