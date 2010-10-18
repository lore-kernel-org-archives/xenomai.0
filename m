Message-ID: <4CBC0C7B.2080103@domain.hid>
Date: Mon, 18 Oct 2010 10:59:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <13402262.2612151287339120062.JavaMail.defaultUser@domain.hid>
In-Reply-To: <13402262.2612151287339120062.JavaMail.defaultUser@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error building xenomai 2.5.5.1 on kubuntu 10.10
 64	bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gprizzi@domain.hid" <gprizzi@domain.hid>
Cc: xenomai@xenomai.org

gprizzi@domain.hid wrote:
>  Hello everyone,
> 
>  I am a new user of xenomai.
>  I am trying to install xenomai on a system with the following
> characteristics:
> 
>  - Intel Q6600
>  - Kubuntu 10.10 - 64 bits version
>  - linux kernel 2.6.35.7
>  - xenomai 2.5.5.1
>  - ggc  compiler version (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5
> 
> 
> I followed the instructions for "Buildin Debian packages" from xenomai.org.
> Everything was OK till applying patch to kernel.
> 
> After that I tried to build the kernel executing the following command:
> 
> CONCURRENCY_LEVEL=2 CLEAN_SOURCE=no fakeroot make-kpkg --initrd --append-to-version -xenomai-2.5.5.1 --revision 1.0 kernel_image kernel_headers
> 
> but i get the following errors and build fails.
> (...)
> Please can anyone help me to solve this problem?

.config, please.

-- 
					    Gilles.

