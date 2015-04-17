MIME-Version: 1.0
In-Reply-To: <CACreCVLwic+NqUotePQxbyiyKFLQdBHO9aZ2zgZG_vh8Ki+2iA@mail.gmail.com>
References: <CACreCVJiKuVmA5cnH7sLxK=3-nCJwo=Q-bJFugLgoM8LTDdYWQ@mail.gmail.com>
 <20150416132316.GD1589@hermes.click-hack.org>
 <552FBC6B.4070402@siemens.com>
 <CACreCVLZwXhFiWzpFewR+a6ab6+SyKQnPLFA7=mP5BcwEFzugA@mail.gmail.com>
 <20150416161819.GG1589@hermes.click-hack.org>
 <CACreCVLbXk1M=pf9o0QcRNbYEeoU_BinVHuokXMO2ec00yngNQ@mail.gmail.com>
 <5530BA92.4000708@xenomai.org>
 <CACreCVLwic+NqUotePQxbyiyKFLQdBHO9aZ2zgZG_vh8Ki+2iA@mail.gmail.com>
Date: Fri, 17 Apr 2015 16:36:35 +0800
Message-ID: <CACreCVLAczUGmcgah0CNUS7J_OG=n9FUD0RmOu2qd8q0W-PExg@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] CLOCK_HOST_REALTIME failure on Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 17, 2015 at 4:16 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
> On Fri, Apr 17, 2015 at 3:47 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 04/17/2015 09:01 AM, GP Orcullo wrote:
>>> The problem was due to uClibc; I was using buildroot for the initramfs.
>>>
>>> Compiling the tools under glibc fixed the switchtest issue.
>>>
>>
>> Xenomai 3.x works with uClibc, since is actually the typical Blackfin
>> configuration which I'm working with.
>>
>> --
>> Philippe.
>
> I'll try again. Maybe it could be due to the mixup between the git and
> -rc4 versions.
>

BTW, what does this smokey test failure means? "FAILURE
rt_thread_body:119: no SIGDEBUG_MIGRATE_FAULT received"

This is for the sigdebug test.

dmesg contains this line:

[ 2265.659390] [Xenomai] switching main to secondary mode after
exception #0 from user-space at 0x114f2 (pid 2866)


-- 
GP Orcullo

