Message-ID: <4DF91176.9020608@domain.hid>
Date: Wed, 15 Jun 2011 22:09:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1308139320.2568.7.camel@domain.hid>
In-Reply-To: <1308139320.2568.7.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unexpected rt_task_sleep behaviour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christian Kapeller <christian.kapeller@domain.hid>
Cc: xenomai@xenomai.org

On 06/15/2011 02:02 PM, Christian Kapeller wrote:
> Hi,
> 
> I am using a KARO TX-51 board (imx 515) running linux 2.6.31.12 + karo
> supplied bsp patches. Xenomai is at version 2.5.6
> 
> In a userspace task i create an interrupt, and want to wait for 1 to 14
> ms. If I supply any non zero delay to rt_task_sleep, I get a delay of
> 830 ms (measured on scope) no matter what delay argument i use.
> 
> It seems something got wrong with the adeos patch. I also experience
> that the serial console is quite laggy.
> 
>  Can anyone give me some pointers where to start investigating this
> matter?

Please try cat /proc/xenomai/timer. You should see something like:
status=on:setup=1777:clock=503449790:timerdev=at91_tc0:clockdev=at91_tc0

If the "setup" time is very large, please try the following patch:
http://git.xenomai.org/?p=xenomai-head.git;a=commitdiff_plain;h=2442425ef628583485ece62cd637c1e6be500514;hp=7c901b868a4e96bba34311ed349b61ea74717c85

-- 
                                                                Gilles.

