Message-ID: <4AE086A0.1050703@domain.hid>
Date: Thu, 22 Oct 2009 18:21:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD3878D@rennsmail04.eu.thmulti.com>
	<4AE07632.7070404@domain.hid>
In-Reply-To: <4AE07632.7070404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Libpcap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Fillod Stephane wrote:
>> Hej!
>>
>> Benjamin Biegel wrote:
>>> I have a question regarding the use of Libpcap together with Xenomai. 
>>> The Libpcap library provides the ability to capture Ethernet frames
>> with 
>>> my NIC in promiscuous mode + time stamp the received frames on
>> Ethernet 
>>> level (through the clock of the NIC).
>>>
>>> My question is this: How do i set up an Xenomai real-time environment 
>>> that makes the time-stamping very accurate. How do I have influence on
>>> when pcap is scheduled? How do I make sure pcap is not preempted by
>> the OS?
>>
>> You have to know that the Linux network stack and libpcap on behalf of
>> your process won't be able to run under hard real-time even with
>> Xenomai.
>>
>> What you're looking for is RTnet: http://www.rtnet.org
>> So far, performance for high speed networking is rather poor IMHO,
>> esp. regarding the API. Please follow this proposal[1] (sorry for 
>> formatting), and feel free to revive the thread and the discussion.
>>
>> [1]
>> http://thread.gmane.org/gmane.linux.real-time.rtnet.devel/262/focus=263
> 
> To be a bit more precise. Rtnet has a capture interface (rtcap), which
> sends a copy of each packet received by the rtnet driver, to a Linux
> driver, which you can capture with libpcap.

Precisely. You can watch the traffic in real-time with wireshark etc.,
simply write it to file with tcpdump -w, or do whatever you want.

> 
> As far as I remember, however, the timestamping of each packet is done
> in the Linux domain, so, if you want to get the real timestamp, you have
> to modify rtnet to get the timestamp done in the Xenomai domain.

No, time stamping is actually done in the RTnet driver (it is a
by-product of RTmac/TDMA).

> 
> Unfortunately, that is not all, because if you get Xenomai's timestamp,
> they drift when compared to Linux timestamps. But if you look only at
> relative timestamps over short period of times, that is Ok.
> 

Yes, timestamps will drift compared to a precise reference clock or even
the Linux host clock. But I'm optimistic we can fix this in the neat future.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

