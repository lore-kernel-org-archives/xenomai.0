Subject: Re: [PATCH v2] Enable retrieving of RTNET network packet timestamp
 OOB using recvmsg()
References: <10a0-60fff880-111-29fb8780@204571665>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4ffc41e4-c59d-9886-d37d-71395c8275d8@siemens.com>
Date: Tue, 27 Jul 2021 18:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <10a0-60fff880-111-29fb8780@204571665>
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

On 27.07.21 14:13, François Legal wrote:
> Le Lundi, Juillet 26, 2021 14:01 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 17.05.21 11:44, François Legal via Xenomai wrote:
>>> This patch enables retrieving, in realtime application, of RTNET enabled adapters packet timestamps.
>>> It uses the linux semantic SO_TIMESTAMPNS, and the linux code to put the timestamp in the control_msg structure.
>>>
>>> I tested this patch with af_packet sockets only. UDP  & TCP might be a little bit trickier as many fragment/segments get reassembled in a single recvmsg. I believe the linux code I used to put the timestamps in the control structure should be OK though.
>>
>> One of my question on v1 is still open: How does Linux handle stamping
>> the context of fragmented UDP and TCP packets? And given that you enable
>> it for those protocols as well, we should likely test that too.
> 
> I thought I already gave an answer to this. Sorry.
> Linux does not handle time stamping of UDP and TCP as far as I understand.

Does Linux return an error when you try to enable this for UDP or TCP
sockets?

> I certainly plan to use the UDP timestamping feature at some point in the future, but maybe I can exclude UDP and TCP for the moment, and stick to af_packet which has be tested by myself. I'll resubmit another patch with (at least) udp support whenever I need it and have time to test it.
> 
> What do you think ?

We need at least a plan how to evolve that interface. Actually doing
that can then happen in steps, yes.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

