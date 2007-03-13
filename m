Message-ID: <45F6AFE5.20700@domain.hid>
Date: Tue, 13 Mar 2007 15:06:29 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid> <45F6A44A.2030000@domain.hid>
	<45F6A73C.8030301@domain.hid> <45F6AA11.40707@domain.hid>
In-Reply-To: <45F6AA11.40707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

Roland Tollenaar wrote:
> HI Wolfgang,
> 
>> It was the IXXAT PCI card currently plugged into my test PC but I 
>> actually recommand the PEAK PCI card. It's also much cheaper, I guess. 
>> Tomorrow I'm going to repeat the tests with this card ... stay tuned.
> Clear. Thanks for the advice.
> 
>>
>>> I will continue development on my laptop with the dongle for the time 
>>> being. It would be interesting to see what happens to the latency 
>>> after your proposed changes are in effect.
>>
>> BTW, what are the latencies you measure on your system under load 
>> (without RT-Socket-CAN).
> Off the top of my head 25us average 30us to 35us max. I am not sure I am 
> "loading" the system though. How do I measure this load that is always 
> talked about?

While the latency test is running execute in other windows:

- while ls; do ls; done
- ping -f <remote-host>"
- dd if=/dev/zero of=/dev/null

and let it run for a few hours. And also search the file TROUBLESHOOTING 
for "stress".

Wolfgang.

