From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <18837_1309425123_4E0C3DE3_18837_902_2_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283@domain.hid>
References: <18837_1309425123_4E0C3DE3_18837_902_2_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jun 2011 11:33:17 +0200
Message-ID: <1309426397.2228.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with Valgrind ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2011-06-30 at 11:12 +0200, VEYSSIERE Nicolas wrote:
> Hello,
> 
>  
> 
> I am asking for an already answered question from a very long time
> ago.
> 
>  
> 
> How can I use valgrind with Xenomai ?
> 

You can't.

>  
> 
> Here (https://mail.gna.org/public/xenomai-help/2006-03/msg00072.html)
> Gilles C. tells us to use --enable-atomic-core
> 
>  
> 
> But I can't find this option. Maybe it has been renamed ?
> 
>  
> 
>  
> 
> # valgrind ./trivial-periodic
> 
> ==27300== Memcheck, a memory error detector
> 
> ==27300== Copyright (C) 2002-2010, and GNU GPL'd, by Julian Seward et
> al.
> 
> ==27300== Using Valgrind-3.6.1 and LibVEX; rerun with -h for copyright
> info
> 
> ==27300== Command: ./trivial-peridic
> 
> ==27300==
> 
> --27300-- WARNING: unhandled syscall: 555
> 
> --27300-- You may be able to write your own handler.
> 
> --27300-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
> 
> --27300-- Nevertheless we consider this a bug.  Please report
> 
> --27300-- it at http://valgrind.org/support/bug_reports.html.
> 
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> 
> (modprobe xeno_native?)
> 
> ==27300==
> 
> ==27300== HEAP SUMMARY:
> 
> ==27300==     in use at exit: 0 bytes in 0 blocks
> 
> ==27300==   total heap usage: 0 allocs, 0 frees, 0 bytes allocated
> 
> ==27300==
> 
> ==27300== All heap blocks were freed -- no leaks are possible
> 
> ==27300==
> 
> ==27300== For counts of detected and suppressed errors, rerun with: -v
> 
> ==27300== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 7 from
> 7)
> 
>  
> 
>  
> 
>  
> 
> Thanks for all.
> 
>  
> 
> -- 
> 
> Nicolas VEYSSIERE
> 
>  
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



