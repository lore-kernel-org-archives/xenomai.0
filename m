Message-ID: <43F5F2E0.7050201@domain.hid>
Date: Fri, 17 Feb 2006 16:59:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C01B251A.2448%steve@domain.hid>
In-Reply-To: <C01B251A.2448%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> Turning on the SMI disable stuff, rebuilding the kernel and modules, and
> installing everything to my board did not solve the latency problem. My
> numbers keep growing as the latency tester runs.
> 
> Any other ideas? I've never had an rtai/xenomai/fusion/whatever system fail
> basic realtime requirements like this before in the 4 years I've been using
> this geode board.
> 

Yous seem to be running in periodic timing mode, with a default slice of 125 us.
Which parameters are passed to rt_task_set_periodic() and rt_task_wait_period() in 
your sampling task?

> Steven
> 
> 
> On 2/17/06 6:28 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:
> 
> 
>>Steven Seeger wrote:
>>
>>>Maybe I didn't set it up right? I followed the instructions in the
>>>README.INSTALL file. Attached is my linux tree's .config.
>>>
>>
>>Try enabling the SMI workaround (Xeno's "Machine" menu), just in case, since
>>you 
>>are running a Geode box.
>>
>>
>>>Steven
>>>
>>>
>>>
>>>>Until those numbers are sane, there is no point in trying anything else
>>>>though.
>>>>
>>>>Ok, the testsuite clearly fails on your board, and something in the current
>>>>setup 
>>>>prevents any real-time use. .config would help.
>>>>
>>>
>>>
> 
> 


-- 

Philippe.

