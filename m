From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <24703926.1184851660664.JavaMail.ngmail@domain.hid>
References: <24703926.1184851660664.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 15:42:23 +0200
Message-Id: <1184852543.28303.67.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Thu, 2007-07-19 at 15:27 +0200, M. Koehrer wrote:
> > 
> > Mathias, I guess this test has not been run with the nucleus debug
> > option enabled. Any chance to get a disassembly of the rpi_pop routine
> > as compiled into your kernel, so that we could check if we are really
> > stuck on this lock, or rather on some infinite walk into a corrupted RPI
> > list?
> I tried last week with debug on and I did not get the freeze...
> However, I will try again. I will enable all Xeno debug options (CONFIG_XENO_OPT_DEBUG,
> CONFIG_XENO_OPT_DEBUG_NUCLEUS, CONFIG_XENO_OPT_DEBUG_QUEUE, 
> CONFIG_XENO_OPT_WATCHDOG) and run the test again...
> 
> For this test I leave CONFIG_XENO_OPT_RPIDISABLE unset (default).
> 

Yes.

> I hope to have more information on the results tomorrow morning...
> 

Ok, thanks. Meanwhile, there is some more thought on our side to fix the
locking sequence. Catch-22 looks so close.

> Regards
> 
> Mathias
> 
-- 
Philippe.



