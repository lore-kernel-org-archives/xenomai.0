From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 16 May 2010 23:57:43 +0200
Message-ID: <1274047063.2972.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-05-14 at 19:18 -0500, Steve Deiters wrote:
> I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux 2.6.33.4
> on a PowerPC MPC5121.  With small values of sleep ticks passed to
> rt_task_sleep, I get various sorts of crashes.  Here is a simple program
> using a delay loop that exhibits the behavior.

<snip>

> 
> I'm not sure if I have something misconfigured or what.  I am upgrading
> from Xenomai 2.4.10 on an older kernel and I did not have this same
> problem.
> 

Bug confirmed here. Your setup is not involved, I'll send a fix asap.

> Thanks.
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



