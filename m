Message-ID: <4933F0A8.4020406@domain.hid>
Date: Mon, 01 Dec 2008 15:11:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <002701c953bd$0899eec0$0f01a8c0@domain.hid>
In-Reply-To: <002701c953bd$0899eec0$0f01a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai on Blackfin BF537
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
To: Daniele Pagani <danielepagani@domain.hid>
Cc: xenomai@xenomai.org

Daniele Pagani wrote:
>  
> Dear Sirs,
> I'm using Xenomai with uclinux-dist-2008R1.5 on bf537.
>  
> Then, it is possible to use native api with a fdpic elf format?
>  
> I receive warning like "relocation references a different segment".
>  
> I compile with bfin-linux-uclibc-gcc .... -lnative.
>  

We do use the fdpic format for all libs on blackfin.

xeno-config --cflags
xeno-config --ldflags

should be used to get the proper compilation/link flags.

> In my code I create 2 real time tasks.
>  
> All works fine when I use flat format, but now I need to use fdpic elf
> format and I receive errors.x
>  
> Best regards,
> Daniele.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

