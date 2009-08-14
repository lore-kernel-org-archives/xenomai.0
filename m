From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.62.0908141206480.14595@domain.hid>
References: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
	<4A853707.10509@domain.hid>
	<Pine.LNX.4.62.0908141206480.14595@domain.hid>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 12:13:51 +0200
Message-Id: <1250244831.3019.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] T_WARNSW ignored?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2009-08-14 at 12:08 +0200, Kolja Waschk wrote:
> > I do not know if that may be your issue, but gdb cause mode switches,
> 
> That explains the SIGXCPU after SIGINT.
> 
> > to run your application outside gdb and see if the MSW increments.
> 
> It does. But no XCPU occurs, neither when started via GDB nor when run
> standalone...
> 

What does /proc/xenumai/faults say? Does any counter value increase
while the app is running?

> Kolja
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



