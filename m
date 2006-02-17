Message-ID: <43F61611.7010902@domain.hid>
Date: Fri, 17 Feb 2006 19:29:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C01B4DA8.245A%steve@domain.hid>
In-Reply-To: <C01B4DA8.245A%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> Could my problem be caused by me using the latest SVN for xenomai? Should I
> try the released version instead?

You should first try my last suggestion, i.e. disable the forced periodic support 
from the configuration. If your application used to rely on the deprecated 
rt_timer_start() call for setting the oneshot mode, then enabling the periodic 
timing option is inappropriate.

> 
> Steven
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

