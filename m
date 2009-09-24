Message-ID: <4ABBCBDB.90706@domain.hid>
Date: Thu, 24 Sep 2009 21:43:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460C3AE7CB@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460C3AE7CB@exchserver.basler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Printf stops working after receiving signal.
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

Steve Deiters wrote:
> I have a simple little test program, attached below.  When I hit CTL-C
> to break the program, not all of the "finished" lines will print.  If I
> remove either the rt_task_shadow call or the sigwait at the end, it will
> then print all of them.  Adding a fflush(stdout) to the end does nothing
> to help it.
> 
> I'm not sure if there's some interaction with the Xenomai domain I am
> just missing which is causing the print statements to be dropped.
> 
> This is running on a PowerPC kernel 2.6.24 with Xenoami 2.4.9.

Do not know if this is related, but sigwait is only guaranteed to work
if you wait for signals that are currently masked.


-- 
					    Gilles.

