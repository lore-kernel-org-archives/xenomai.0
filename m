MIME-Version: 1.0
References: <d44aeeb8-f265-81fd-01b8-3f2648949ead@freyder.net>
 <CALLqZ8Tr4e_ObU1+NCsd0nfDGiG96ok7nb-xCxHrK8Gk3KZ3AA@mail.gmail.com>
 <a5a2923a-a14c-8eb9-c272-0eadc63f047c@freyder.net>
In-Reply-To: <a5a2923a-a14c-8eb9-c272-0eadc63f047c@freyder.net>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 25 Feb 2021 15:06:56 -0500
Message-ID: <CALLqZ8R_H1MGXfNWZ0G7j93h-LkD8hweMGCj4XjXXkv=3kqABA@mail.gmail.com>
Subject: Re: [Xenomai] bad syscall <0x197>
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steve freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Feb 24, 2021 at 6:16 PM steve freyder <steve@freyder.net> wrote:

>
>
> On 2/24/2021 2:52 PM, Greg Gallagher wrote:
>
>
>
> On Wed, Feb 24, 2021 at 3:45 PM steve freyder via Xenomai <
> xenomai@xenomai.org> wrote:
>
>> Greetings Xenomai list,
>>
>>
>> I have a Linux OE 4.14.85 build with Xenomai 3.1 -next branch, and am
>> seeing this:
>>
>> root@ICB-G3L:~ # uname -a
>> Linux ICB-G3L 4.14.85_C01571-15S01A01.000.zimg+35a84af5b7 #1 SMP Mon Feb
>> 22 20:57:38 UTC 2021 armv7l GN
>> U/Linux
>> root@ICB-G3L:~ # smokey --run=posix_mutex
>> [  694.433129] [Xenomai] bad syscall <0x197>
>> posix_mutex OK
>>
>> I found this thread:
>>
>> https://www.mail-archive.com/xenomai@xenomai.org/msg17931.html
>>
>> But I can't get a clear picture on the proper resolution of this issue,
>> other than it's related to a non-existent syscall, perhaps glibc
>> version, and/or __real_usleep().  I'd like to get this working on either
>> 4.14 or 4.19, is there a simple workaround for this?
>>
>> Thanks in advance,
>>
>> Steve
>>
>>
>>
>>
>> I forgot all about this, I'll take a look tonight and see what's
> involved.  What gcc version are you using?
>
> Thanks
>
> Greg
>
>
>
> Greg,
>
> The compiler is gcc 9.3.0 using Yocto Dunfell.  glibc 2.31...
>
> I'm able to reproduce this with gcc 10, I'll hopefully have a fix or
solution shortly.

-Greg
