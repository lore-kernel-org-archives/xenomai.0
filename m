Message-ID: <45EBBFC2.7080101@domain.hid>
Date: Mon, 05 Mar 2007 07:59:14 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] syslogd breaking rt behaviour of xenomai?
References: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>	
	<cbe23c50703040845v7125317amd915c3e199c9fd5f@domain.hid>	
	<bc4264770703040952x61e3c15icc8d041bf108506@domain.hid>
	<cbe23c50703041007i743c2babjdf914d3b2b3ced91@domain.hid>
In-Reply-To: <cbe23c50703041007i743c2babjdf914d3b2b3ced91@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

Hi
  > You may want to try alternatives syslog daemon
>> > implementation like syslog-ng 
>> (http://www.balabit.com/products/syslog_ng/)
>> > which exhibits far better performance than "standard" syslogd.
>>
>> I'd much rather just switch it off entirely when I am running my
>> rt-task. If I have a problem and need to debug with it I can always
>> switch on.
> 
> For this then simply try
> 
> /etc/init.d/syslogd stop

I'll try this later to see whether it improves matters.

> 
>> During debugging I am not so worried about the hardness of
>> the RT behaviour.
>>
>> Anyone know how to switch off syslogd or block all calls to it?
> 
> May be you can post the log excerpt you have in order
> fo us to know where they come from?
> 
> log should show if they are coming from kernel or user process.

Off the top of my head (am not at the linux box right now)

xeno-(something): buffer overflow bla bla (fd=[number]), message discarded


The [numer has been anything between 0 and 5. I presume the useful part 
is the xeno-(something) where the something will tell us what is making 
the calls?

I will not be able to run the system today so I post this memory version 
so long. :)

Regards,

Roland.

> 
> 
> 

