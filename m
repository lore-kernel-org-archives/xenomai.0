References: <1523454871.2312.15.camel@smigroup.net>
 <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
 <1523457598.2312.18.camel@smigroup.net>
 <627da48b-4a8d-e8e4-b521-a3fe99304cae@xenomai.org>
 <1524043270.2300.2.camel@smigroup.net>
 <CAOuPNLj9WoyAbv3d6jZjaFto9FT+_ZnvH6Skkopd26Z_4Bs9+w@mail.gmail.com>
 <CALLqZ8T+pFjMOt9Oqruy+NJuVxcV_6YgaXq_2_HqYUV2ew-VAg@mail.gmail.com>
 <CAOuPNLjvqxa+azvZhLzL4QEfs6J9ichrp2h--R5ffjimCffCEg@mail.gmail.com>
 <1524063580.2300.6.camel@smigroup.net>
 <CALLqZ8Qwq3OVVH2YbryvJV8R=jsoyzDomB1iALsokHTtagNwKw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f643e687-5d78-3fca-fbb6-b23ddc97a121@xenomai.org>
Date: Wed, 18 Apr 2018 20:33:24 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8Qwq3OVVH2YbryvJV8R=jsoyzDomB1iALsokHTtagNwKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_wait_period() does not return -EWOULDBLOCK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Mauro Salvini <mauro.salvini@smigroup.net>
Cc: xenomai <xenomai@xenomai.org>

On 04/18/2018 05:09 PM, Greg Gallagher wrote:
> No problem, I won't be able to look into it till the weekend so any
> help debugging is appreciated :)

Brown paper bag bug. The change was tested on Mercury only, where timer
ids cannot be zero; zero is a perfectly valid timer id with Cobalt. Oh,
well. I'll send a fix tested on both ends.

> 
> On Wed, Apr 18, 2018 at 10:59 AM, Mauro Salvini
> <mauro.salvini@smigroup.net> wrote:
>> On Wed, 2018-04-18 at 20:01 +0530, Pintu Kumar wrote:
>>> On Wed, Apr 18, 2018 at 7:15 PM, Greg Gallagher <greg@embeddedgreg.co
>>> m> wrote:
>>>> What version was this working in?  I'm assuming you are working out
>>>> of
>>>> stable-3.0.x? If you reverted to an older git commit please post
>>>> the
>>>> commit.
>>>>
>>>
>>> Sorry, I don't remember the previous working versions.
>>> My current xeno-config is:
>>> # xeno-config --info
>>> Xenomai version: Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20
>>> 12:13:33 +0100)
>>> Linux 4.9.51-x86-64-mine-xeno3-rtdm #1 SMP Mon Apr 9 21:35:39 JST
>>> 2018
>>> x86_64 x86_64 x86_64 GNU/Linux
>>> Kernel parameters: initrd=0:\initrd.img-4.9.51-x86-64-mine-xeno3-rtdm
>>> root=/dev/disk/by-partlabel/system ro ip=off
>>> I-pipe release #4 detected
>>> Cobalt core 3.0.6 detected
>>> Compiler: gcc version 5.4.0 xxx
>>> Build args:
>>>
>>> With this it is working fine.
>>>
>>> However, when I remove everything (/usr/xenomai/) and re-install the
>>> latest xenomai-3 (pulled today), it shows problem.
>>> I did not revert any specific commit and tried.
>>> May be I can check that later.
>>> Note: as of now the problem is seen only when using
>>> rt_task_wait_period(NULL).
>>>          When I use rt_task_sleep() then it works fine.
>>
>> Hi Greg and Pintu,
>>
>> commit 73de42cc87f8831694f119359472283f8c7a21e6 on stable branch
>> contains patch that Philippe sent to me some days ago.
>> He upstreamed it because I told him that patch was working, but in fact
>> as I said in previous mail patch actually corrects one bug
>> (rt_task_wait_period() that not return -EWOULDBLOCK if
>> rt_task_set_periodic() was never called) but exploits another
>> (rt_task_wait_period() return -EWOULDBLOCK also when
>> rt_task_set_periodic() was called).
>>
>> It is my fault because when Philippe sent me the patch I tested only
>> the previous non-working case and not the working, sorry for the mess.
>>
>> I'm trying to find where is the bug, but it's not simple because I
>> don't know Xenomai internals.
>>
>> Thanks, regards
>>
>> Mauro
>>
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

