Subject: Re: kvm fpu warning on 4.14.89
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <d53140e58f60459694e2e66a94d0a518@systemceramics.com>
 <CAPR3TAhurhcwOGe9wfnOTUd=VBRvXuMLxZtNZ-3+QNyd=TOJnA@mail.gmail.com>
 <ebec2dcf-9549-fed2-6a48-299597bc7079@siemens.com>
 <CAPR3TAjFNV-0LgZ=+ydtseAQw-jdmYRHO4FQwybTjAHwDV59Xg@mail.gmail.com>
 <CAPR3TAhP1VwSE5OjKiznfuzsRXyigeN+ohQP1jQE-roLDMh5LA@mail.gmail.com>
 <32be3d2e-020f-468c-2940-26a09e96daeb@siemens.com>
 <CAPR3TAitTeY0rNVZ6v0moFzh0d_hA6zyS-R3fm+DK+HX4yj3PQ@mail.gmail.com>
 <04ffd701-4df7-5a2b-8000-cf5bec9d06d7@siemens.com>
 <CAPR3TAg=5on1=gJHSChHHwAb3AafZNx3jizMerdZvYKnN5YObA@mail.gmail.com>
 <9d5a6b6e-d7ba-00cd-3851-b26961ebbee7@siemens.com>
 <a7f863b1-9389-4a04-152d-8bc1ec0d723c@siemens.com>
 <CAPR3TAitwUBW8AzOX6cWyBgnp+bKhiNHWE3PBfs-OdAcQSCANw@mail.gmail.com>
 <48849a99-34f6-a84f-22cc-664028431ae7@siemens.com>
 <CAPR3TAg8-QsV+yENSF=Vy7GTfbes2Smtbjo-u2b=MNQ3EnSqLg@mail.gmail.com>
 <6ffa5a27-de0f-5372-8954-6791b52dcd84@siemens.com>
 <ac901e68-599f-3832-8272-aac089ff943f@siemens.com>
Message-ID: <e682fe6b-b0ce-9f5c-b236-556064024b61@siemens.com>
Date: Fri, 5 Apr 2019 20:29:44 +0200
MIME-Version: 1.0
In-Reply-To: <ac901e68-599f-3832-8272-aac089ff943f@siemens.com>
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
To: cagnulein <cagnulein@gmail.com>
Cc: xenomai@xenomai.org

On 05.04.19 15:27, Jan Kiszka wrote:
> On 05.04.19 11:42, Jan Kiszka wrote:
>> On 05.04.19 10:44, cagnulein wrote:
>>> Hi, yes I double checked the patch and it's applied correctly.
>>> Here you can find my config.
>>>
>>> CONFIG_DEBUG_STACKOVERFLOW is disabled.
>>>
>>> I can't get the uart on this system, is there any other way to catch log in
>>> this scenario?
>>
>> UART is mandatory for debugging such crashes. Use a PCI extension card if your
>> board has no UART connector anymore.
>>
>> Well, you may try to lift Xenomai with KVM inside a KVM VM and catch the UART
>> output of the first level VM. This is how I'm debugging.
>>
>>>
>>> Why should I test the 4.4.y? 4.9.146 works fine on the same system (with the
>>> same guest). Did I miss something?
>>
>> Well, 4.9 would be as broken as 4.4 currently is. But 4.4 is supported, 4.9 is
>> discontinued by now. In any case, this indicates we have another difference
>> caused by changed in 4.14 (and before).
>>
>> I'll see if I can reproduce by booting Win10 in my nested setup.
>>
> 
> Already running the UEFI BIOS triggers something, at least on 4.4. Let's see...
> 

As you will be able to see from the commits, there were a number of further issues:

https://gitlab.denx.de/Xenomai/ipipe-x86/commits/wip/kvm-4.14

With that, I'm able to start Win10 on the same core as the latency test. But 
only in my virtual setup (nested kvm) which may mean that real hw could expose 
further issue or latency problems. Please test.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

