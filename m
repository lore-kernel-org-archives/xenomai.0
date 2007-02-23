Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DEF28D.3090506@domain.hid>
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>
	<45DEF122.2060406@domain.hid> <1172239058.26738.18.camel@domain.hid>
	<45DEF28D.3090506@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 15:12:33 +0100
Message-Id: <1172239953.26738.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

On Fri, 2007-02-23 at 14:56 +0100, Steven Scholz wrote:
> Philippe,
> 
> >> I tried! Attached the patch I used. Since teh scheduler hangs I can't use normal printk(), right?
> >>
> >> *ipipe_current_domain != ipipe_root_domain !
> >> *ipipe_current_domain = c01fc2c0
> >> *ipipe_root_domain    = c01af2c0
> >>
> >> But I don't get the output of __backtrace()!
> > 
> > Before calling your backtrace helper, try adding:
> > 
> > 	ipipe_set_printk_sync(ipipe_current_domain);
> 
> And then use printk() instead of my_printk()?
> 

Yes, switching this on is a brute force attempt to bypass any
bufferization and allow printk to call the console driver directly
regardless of the current domain - this may, or may not work, depending
on the level of brokenness of the current situation (this said, if I
don't get why printascii() as used by my_printk() does not send the
characters to the uart as expected).

> Steven
-- 
Philippe.



