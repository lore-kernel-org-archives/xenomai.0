Subject: Re: Deadlock during debugging
References: <VI1PR05MB5917D854245374A7BF4E34BFF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB591737F8DF2F37FBBE64101AF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB5917D9816484CC3559EB0D75F64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <ccfc971c-de91-f1dd-eec0-23a46f45ddad@siemens.com>
 <VI1PR05MB5917036B263793FF2B2EF000F64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d759b2a6-b572-c021-694e-71ec1beec727@siemens.com>
Date: Tue, 19 Nov 2019 07:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917036B263793FF2B2EF000F64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 18.11.19 18:31, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Montag, 18. November 2019 18:22
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: Re: Deadlock during debugging
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 18.11.19 17:24, Lange Norbert via Xenomai wrote:
>>> One more,
>>>
>>> Note that there seem to be quite different reports, from a recursive fault
>> to some threads getting marked as "runaway".
>>> I can reproduce the issue now easily, but its proprietary software I cant
>> reach around.
>>
>> Understood. Will try to read something from the traces.
>>
>> This is a regression over 3.0 now, correct?
> 
> No, can't say that. I had various recurring issues with 4.9, 4.14 and 4.19 kernels,
> aswell as 3.0 and and 3.1.
> It's hard to narrow down and often just vanished after a while, and my only
> gut-feeling is that condition variables are involved.
> I also have a couple cobalt threads *not* pinned to a single cpu.

I'm only talking about the crash during debug - one issue after the other.

Jan

> 
> Atleast I can now say it’s a single app causing the issue, not using rtnet or having additional cobalt applications running.
> Since I can easily reproduce the issue, I will now try using debian's gcc-8, to rule out troubles with the toolchain.
> 
> Norbert.
> 
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

