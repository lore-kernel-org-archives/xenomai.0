Message-ID: <44421F06.5070500@domain.hid>
Date: Sun, 16 Apr 2006 12:40:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] xeno-test: replace 'head -3' with 'head
	-n 3'
References: <443E68D1.5060004@domain.hid>
In-Reply-To: <443E68D1.5060004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> 
> heres an untested (still, low risk) patch for xeno-test
> which corrects an obsolete usage of head.
> 
> 

Applied, thanks.

> noted by Tobias Marschall on xeno-help.
> 
> 
> ------------------------------------------------------------------------
> 
> Index: scripts/xeno-test.in
> ===================================================================
> --- scripts/xeno-test.in	(revision 924)
> +++ scripts/xeno-test.in	(working copy)
> @@ -90,7 +90,7 @@
>      loudly cat /proc/interrupts
>      loudly cat /proc/loadavg
>      [ -n "$prepost" ] && loudly $prepost
> -    loudly top -bn1c | head -$(( 12 + $workload ))
> +    loudly top -bn1c | head -n $(( 12 + $workload ))
>  }
>  
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

