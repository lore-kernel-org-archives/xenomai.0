Message-ID: <45DEF28D.3090506@domain.hid>
Date: Fri, 23 Feb 2007 14:56:29 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>	
	<45DEF122.2060406@domain.hid> <1172239058.26738.18.camel@domain.hid>
In-Reply-To: <1172239058.26738.18.camel@domain.hid>
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

>> I tried! Attached the patch I used. Since teh scheduler hangs I can't use normal printk(), right?
>>
>> *ipipe_current_domain != ipipe_root_domain !
>> *ipipe_current_domain = c01fc2c0
>> *ipipe_root_domain    = c01af2c0
>>
>> But I don't get the output of __backtrace()!
> 
> Before calling your backtrace helper, try adding:
> 
> 	ipipe_set_printk_sync(ipipe_current_domain);

And then use printk() instead of my_printk()?

Steven

