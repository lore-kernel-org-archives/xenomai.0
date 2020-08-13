Subject: Re: [PATCH] kernel:cobalt:heap: replace kzalloc with kvzalloc
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
 <7a76268b-84f6-0073-7830-54a317106c7d@siemens.com>
 <fc87600a-0797-849d-2d35-f2d32d1a7a90@siemens.com>
 <CAAvDm6a2VPs_0uqZZChXc=mhnx7c4Z1sPstbbMRNGceYKZg7_Q@mail.gmail.com>
 <65a89852-1f02-663a-3d08-6e0ad2716044@siemens.com>
 <CAAvDm6b8DoYYz47K0VDoAzedk9y3w5kv3UA-4TzLipHxkX=z2Q@mail.gmail.com>
 <CAOuPNLhPejZsUwCrjOWm=kT_JLJipcV7WXt6TgiAA6UDXpOmvg@mail.gmail.com>
 <108d1c6f-5ae5-788a-e8ce-5e649c9b3642@siemens.com>
 <CAOuPNLixxP7+RkW716PZ97mq1dNNdzsMMdX_LAZ4+_DYkmREUw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45246226-b3ca-a00a-5729-9a28e558dda5@siemens.com>
Date: Thu, 13 Aug 2020 12:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLixxP7+RkW716PZ97mq1dNNdzsMMdX_LAZ4+_DYkmREUw@mail.gmail.com>
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
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, Pintu Kumar <pintu@codeaurora.org>, xenomai <xenomai@xenomai.org>

On 13.08.20 04:26, Pintu Agarwal wrote:
> On Wed, 12 Aug 2020 at 21:22, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 11.08.20 13:44, Pintu Agarwal wrote:
>>> Oh sorry about this.
>>> I can send a new patch set with kvmalloc that can work on all kernel versions.
>>>
>>
>> Yes, please do so to avoid that things become to messy when trying to
>> create that manually.
>>
> 
> Thank you so much for your confirmation.
> Yes I am preparing a patch-set v2 and will send it soon.
> But is there a way to use both kvzalloc and kvmalloc depending on
> kernel version ?
> I see that checking using below is also not valid any more in higher
> kernel version:
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 9, 0)
> 

This pattern still works, also in 5.x.

> Also I see in some versions directly kmalloc is used (not kzalloc).
> Moreover, kvmalloc also may not be available in 3.x kernel version as well.
> So wondering if kvmalloc would be fine or not ?
> 
> Is covering 4.x kernel version should be enough ?
> 

Yes, 4.4 is our lower boundary for Xenomai 3.1.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

