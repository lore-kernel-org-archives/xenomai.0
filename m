Message-ID: <44EC976E.4000601@domain.hid>
Date: Wed, 23 Aug 2006 19:59:10 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB01081D6B@is-hdq-exchange.marel.net>	<44EC8B62.8020306@domain.hid>
	<44EC8EAB.8010201@domain.hid>
In-Reply-To: <44EC8EAB.8010201@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: [Socketcan-users] Select on a RTCAN socket
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Haukur Hafsteinsson <haukur@domain.hid>, xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid, Daniel Schnell <danielsch@domain.hid>

Jan Kiszka wrote:
> Hi all,
> 
> Wolfgang Grandegger wrote:
>> Hi Daniel,
>>
>> Daniel Schnell wrote:
>>> Hi,
>>>
>>>  
>>>
>>> I wanted to use select() on a socket to find out how many messages are 
>>> available. I have opened this socket to access the RTCAN sockets under 
>>> Xenomai. According to /usr/xenomai/lib/posix.wrappers select is not 
>>> "supported" by the realtime kernel. Accordingly it doesn't work. If i 
>>> start the according task under SCHED_FIFO, the task simply hangs when 
>>> initiating select(), in SCHED_OTHER it is simply returning: bad file 
>>> descriptor.
>> select is not supported and cannot be used, indeed.
> 
> And select is tricky to provide under hard-RT constraints.
> 
>>> Any ideas ? Is there any other way to find out, how many messages are 
>>> waiting ?
>> Select returns the sockets which have data but it does not tell you how 
>> many messages are waiting. You could use separate threads to read from 
>> sockets.
>>
>> BTW: this mail is off-topic on the socketcan MLs.
> 
> Mmh, do you mean it the other way around?

Well, I think this is a RTDM/Xenomai related questions and sending it to 
xenomai-help is OK. CAN related questions should go to the 
socketcan-users maling-list. Am I wrong?

> Anyway, is there a mechanism of the standard socket API the obtain the
> current incoming queue length? Don't think so actually, but it wouldn't
> be the first time I'm blind.

Not that I know of. For normal file I/O I remember vague some ioctl() or 
fnctl(). Does POSIX define a function for this purpose?

Wolfgang.


