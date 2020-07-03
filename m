Subject: Re: RTDM module ownership
References: <CAFLxGvxru2Y==qboUgwHdsQvOT5MEL2O8CexkhkQpKz0Qj+jqw@mail.gmail.com>
 <77dc555e-10dd-8e05-0770-1f1f673259fd@siemens.com>
 <1684715583.86100.1593757371692.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <50c505c0-39bc-26c0-6188-1e2a2fe41536@siemens.com>
Date: Fri, 3 Jul 2020 11:10:41 +0200
MIME-Version: 1.0
In-Reply-To: <1684715583.86100.1593757371692.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, xenomai <xenomai@xenomai.org>

On 03.07.20 08:22, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>>> In contrast, on regular Linux rmmod will refuse to unload the module
>>> if the device node is still open because fops_get() or other helpers
>>> gained a reference on the owner.
>>>
>>
>> First of all, your driver is apparently not reacting on the close
>> request that it receives in that case. This leads the the stall you see.
> 
> Huh? rmmmod triggers close of what?
> *confused*
>   

rmmod -> module cleanup -> rtdm_dev_unregister -> rtdm_device_flush_fds

>> Still, we could indeed run some module_put/get on open/socket/close. I
>> thought we did, but that was once RTnet [1].
> 
> Yes. Would be nice. :-)
> 

Just like a patch would be...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

