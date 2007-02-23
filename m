Message-ID: <45DEF72C.2090807@domain.hid>
Date: Fri, 23 Feb 2007 15:16:12 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>	
	<45DEF122.2060406@domain.hid>
	<1172239058.26738.18.camel@domain.hid>	
	<45DEF28D.3090506@domain.hid> <1172239953.26738.29.camel@domain.hid>
In-Reply-To: <1172239953.26738.29.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Philippe,

>>>> But I don't get the output of __backtrace()!
>>> Before calling your backtrace helper, try adding:
>>>
>>> 	ipipe_set_printk_sync(ipipe_current_domain);
>> And then use printk() instead of my_printk()?
>>
> 
> Yes, switching this on is a brute force attempt to bypass any
> bufferization and allow printk to call the console driver directly
> regardless of the current domain - this may, or may not work, depending
> on the level of brokenness of the current situation (this said, if I
> don't get why printascii() as used by my_printk() does not send the
> characters to the uart as expected).

Ok. Thanks.

But since BUG() does the backtrace as well, there's no need for my hack.
As you said replacing return with BUG() is enough.

But as you can see from the backtrace, there's not muzch info ....

Steven


