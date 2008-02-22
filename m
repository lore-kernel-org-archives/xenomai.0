Message-ID: <47BED507.3080706@domain.hid>
Date: Fri, 22 Feb 2008 14:58:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1203688198.3228.1.camel@domain.hid>
In-Reply-To: <1203688198.3228.1.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Error while executioning xeno-test
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
To: jwl <william.jing@domain.hid>
Cc: xenomai@xenomai.org

jwl wrote:
> Hello,
>         
>         I have to install xenomai2.3.0 on a PPC architecture board.

The current stable version is 2.4.2. 2.3.0 is not supported anymore.

>         I patched linux2.6.19.2 with adeos-ipipe-2.6.19-ppc-1.5-02.patch
>         and
>         built an Ramdisk with buildroot and ELDK.
>         
>         The kernel boot correctly. when I run /usr/xenomai/bin/xeno-test
>         I met this error:
>         
>         ------------------
>         /usr/xenomai/bin/xeno-load: line 239: /usr/xenomai/bin/latency:
>         No such file or directory
>        ------------------
>

Check your shell. /bin/sh should be on your ramdisk.

>         But latency exists and has the correct permissions.
>         
>         By the way I didn`t change anything in the kernel
>         configuration(Real-time sub-system -->)
>         
>         Does anyone know why this happend?
>         
>         Best Regards
>         William Jing
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

