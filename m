Subject: Re: [Xenomai-help] More woes with linux 2.6.18 and xenomai 2.2.3
	or 2.2.4 - irq_desc structure changed
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1F695B041C4BC345AFB7BD5D647B85000119975A@mail.senetas.com>
References: <1F695B041C4BC345AFB7BD5D647B85000119975A@mail.senetas.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:21:02 +0100
Message-Id: <1162282862.4996.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: John Weston <john.weston@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 10:18 +1100, John Weston wrote:
> 
> Continuing from my previous email regarding xenomai 2.2.4 and linux
> 2.6.18 for ppc (8260), I have also noticed that the underlying
> irq_desc structure has changed (in include/linux/irq.h), which in turn
> breaks hal.c.
> 
> Are there any more recents patches available to fix this? Thanks in
> advance

The upcoming 2.3-rc1 fixes the issues raised by upgrading to 2.6.18 and
beyond (includes mutex and irq_desc conflicts). You can get this code
from the SVN trunk/, until -rc1 is rolled out (soon).

> 
> John  Weston 
> Senetas PL
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



