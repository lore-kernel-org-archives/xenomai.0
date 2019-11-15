Subject: Re: [PATCH] rtdm: Do not return an error from send/recvmmsg if there
 are packets
References: <02a4475e-f687-8e87-1971-1948cecfbf34@siemens.com>
 <4cdc4d6a-f073-611b-1b0e-306dfeecb176@xenomai.org>
 <34b58531-0004-ea65-0384-e338341435e4@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fe10a1df-6846-f706-6e12-85ba252ecce1@siemens.com>
Date: Fri, 15 Nov 2019 10:42:55 +0100
MIME-Version: 1.0
In-Reply-To: <34b58531-0004-ea65-0384-e338341435e4@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 15.11.19 10:39, Philippe Gerum wrote:
> On 11/15/19 10:37 AM, Philippe Gerum via Xenomai wrote:
>> On 11/14/19 7:59 PM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This is in line with Linux behavior.
>>>
>>> We likely still miss an equivalent to sk_err in recvmmsg, though.
>>
>> Ack. Tracing on early exit due to null vlen in sendmmsg() is still missing; having this might help in debugging issue(s) at call site.
>>
> 
> Likewise in recvmmsg().
> 

Yes, I'll simply remove the "vlan == 0" optimization.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

