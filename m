Subject: Re: Get packet timestamp in af_packet or other RTNET components
References: <35a5-604f1380-1a5-48dc0d80@57314281>
 <9cffc541-5e22-d874-8d60-8799a650e0b3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a39b7f5a-fb6d-6744-2ac8-c36ade15c050@siemens.com>
Date: Mon, 15 Mar 2021 09:03:07 +0100
MIME-Version: 1.0
In-Reply-To: <9cffc541-5e22-d874-8d60-8799a650e0b3@siemens.com>
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

On 15.03.21 08:59, Jan Kiszka via Xenomai wrote:
> On 15.03.21 08:57, François Legal wrote:
>> Le Lundi, Mars 15, 2021 08:16 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>  
>>> On 12.03.21 23:21, François Legal via Xenomai wrote:
>>>> Hello,
>>>>
>>>> working on a data recorder application, I would need to get access to each packet receive timestamp (populated during packet reception ISR generally in network drivers).
>>>>
>>>> I figured out, the cleanest way to do it would be using the
>>>>  "void __user *msg_control;	/* ancillary data */" / "__kernel_size_t msg_controllen;	/* ancillary data buffer length */"
>>>> members of the struct user_msghdr that is carried over when using the recvmsg call, plus possibly an ioctl to enable the timestamp retrieving
>>>>
>>>> Did anybody already do something like this in xenomai/RTNET ?
>>>> Any thought on the proposed vector ?
>>>> Any chance such modification could become mainline ?
>>>>
>>>
>>> I would add SO_RCVTIMEO support, like rtipc already has.
>>>
>>> Jan
>>>
>>> -- 
>>> Siemens AG, T RDA IOT
>>> Corporate Competence Center Embedded Linux
>>  
>> Hello,
>>
>> Isn't SO_RCVTIMEO used to set receive timeout ?
>>
>> What I intend to do is retrieve the receive time of the packet.
> 
> Sorry, wrong option. But I suspect there is something official to obtain
> the time stamps as well.
> 

SO_TIMESTAMP, and that takes you to those ancillary data.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

