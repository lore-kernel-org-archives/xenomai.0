From: trem <tremyfr@domain.hid>
Date: Thu, 23 Aug 2007 22:43:50 +0200
Message-ID: <46CDF186.4020706@domain.hid>
References: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>	<46C49070.8070807@domain.hid>	<46C4BAB8.20103@domain.hid>	<46C559A2.6090807@domain.hid>	<46C5E4AC.1090608@domain.hid>
	<46C692FD.4080302@domain.hid>	<46C9FFDA.8030200@domain.hid>
	<46CDEF34.2030003@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <46CDEF34.2030003@domain.hid>
Sender: news <news@domain.hid>
Subject: Re: [Xenomai-core] RTDM context_size question
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Hi Philippe,
> 
> sorry for the delay - I was and still am short on time.
> 
> trem wrote:
>> Hi
>>
>> Oh, I understand your point of view, and I found it fine. We do an
>> example quite complete (and with some sense), and we split it into step.
>>
>> The first complete example could contain :
>> - global buffer (one for all device)
>> - device buffer (one for each device)
>> - local buffer (one for each open)
>> - synchronization: semaphore used to block read when no data are ready
>> - ioctl: used to to select the active buffer (ie global, device, local)
>>
>> Now, how to split it ? I propose :
>>
>> tut01: global buffer + read/write
>> tut02: {global, device, local} buffer + ioctl + read/write
>> tut03: {global, device, local} buffer + ioctl + read/write + synchronization
>>
> 
> Let's write the full example first, look at the result, and then decide
> about the best split-up.
> 
> Jan
> 

Hi

Ok, I write it and I send it ASAP.

regard,
Philippe (trem)



