Subject: Re: RTNet and setsockopt
References: <2018325684.72682.1587053305425.JavaMail.zimbra@wolfram.com>
 <VI1PR05MB59172B3C0D8909BD37F9E947F6D80@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <37888427.83114.1587056423222.JavaMail.zimbra@wolfram.com>
 <1173354937.92265.1587060278568.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c0ea7edb-f52e-9152-4451-c9f23e622073@siemens.com>
Date: Fri, 17 Apr 2020 08:18:32 +0200
MIME-Version: 1.0
In-Reply-To: <1173354937.92265.1587060278568.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 16.04.20 20:04, Per Oberg via Xenomai wrote:
> ----- Den 16 apr 2020, på kl 19:00, xenomai xenomai@xenomai.org skrev:
>> ----- Den 16 apr 2020, på kl 18:32, Lange Norbert norbert.lange@andritz.com
>> skrev:
> 
>>> Hello Per,
> 
>>> setsockopt is supported by rtnet (and wrapped with the POSIX skin). That said,
>>> it supports very little options you are used from Linux. Do a grep -r on
>>> xenomais sources.
>>> Xenomai mostly uses ioctls for bringing up Interfaces, etc.
> 
>>> There are subtile differences and limitations aswell. I am pretty sure now that
>>> most operations
>>> are behaving like you have an nonblocking filedescriptor / socket. The RT focus
>>> means that there
>>> typically is just a check if buffers are available, and no effort is made for
>>> waiting.
>>> So select will be your best friend.
>>> (I am just using packet sockets, but I believe it’s the same for all of them).
> 
>> Thanks, I readded the list again. The reason I started looking into this is that
>> I had issues with blocking sends. I wanted to see what happened if I pulled the
>> plug on the ethernet and tried to recover afterwards.
> 
>> Digging around a bit is seems like I might actually have a compiler flag issue
>> (again...). I tried compiling my network code as a shared library.
> 
> Progress, i guess. It was the read that was became non blocking.
> 
> Still: I believe that "setsockopt" is missing for PF_PACKET, SOCK_RAW. I can se that it is implemented for some of the packet types but there is no reference to it in af_packet.c.
> 
> That said, I don't see how setsockopt is mapped to the different variants. I can se how recv and recfrom is mapped using the structure with the ".recvfrom = xxx" syntax but setsockopt seems to be different.
> 
> Also, when looking in the code i see that "MSG_DONTWAIT" is supported for rt_packet_recvmsg and that it sets sock->timeout to -1. So it seems a small fix to make this work, if I only knew where how setsockopt was mapped..
> 

There is RTNET_RTIOC_TIMEOUT to set the timeout of blocked operations on 
the socket. I honestly do not recall right now what the reasoning for 
going separate was, but adding SO_RCVTIMEO compatibility would sure be 
doable.

Note that RT-TCP already supports SO_SNDTIMEO.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

