Subject: Re: [PATCH v2] Enable retrieving of RTNET network packet timestamp
 OOB using recvmsg()
References: <10a0-61025980-117-29fb8780@204571764>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f4047d18-5e6e-519f-83e5-8ede36fde1e6@siemens.com>
Date: Mon, 2 Aug 2021 10:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <10a0-61025980-117-29fb8780@204571764>
Content-Type: text/plain; charset="utf-8"
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On 29.07.21 09:32, François Legal wrote:
> Le Mardi, Juillet 27, 2021 18:44 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 27.07.21 14:13, François Legal wrote:
>>> Le Lundi, Juillet 26, 2021 14:01 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 17.05.21 11:44, François Legal via Xenomai wrote:
>>>>> This patch enables retrieving, in realtime application, of RTNET enabled adapters packet timestamps.
>>>>> It uses the linux semantic SO_TIMESTAMPNS, and the linux code to put the timestamp in the control_msg structure.
>>>>>
>>>>> I tested this patch with af_packet sockets only. UDP  & TCP might be a little bit trickier as many fragment/segments get reassembled in a single recvmsg. I believe the linux code I used to put the timestamps in the control structure should be OK though.
>>>>
>>>> One of my question on v1 is still open: How does Linux handle stamping
>>>> the context of fragmented UDP and TCP packets? And given that you enable
>>>> it for those protocols as well, we should likely test that too.
>>>
>>> I thought I already gave an answer to this. Sorry.
>>> Linux does not handle time stamping of UDP and TCP as far as I understand.
>>
>> Does Linux return an error when you try to enable this for UDP or TCP
>> sockets?
> 
> Alright so I rechecked everything again. Linux does not return an error when requesting timestamping for UDP or TCP (or any other kind of socket it seems).
> 
> Despite my previous assertion, timestamping is supported for UDP  and if I understood the code correctly, only one timestamp is returned in any case (the time stamp of the last received datagram). This is done in reassembly queues, where the queue always keep the timestamp of the last received datagram, and when doing the reassembly, this last timestamp is reported to the re created skb.
> 
> For TCP it is definitely not supported.
> 
> So I should modify the patch to make it comply with what linux does I guess ?
> 

Yes, unless there is any good (RT/Xenomai-specific) reason speaking
against alignment, we should do this - least surprise.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

