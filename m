Message-ID: <54272B11.9000403@xenomai.org>
Date: Sat, 27 Sep 2014 23:24:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABVE6k3zmPJBYMGvN9H_GVNyBT=WJFGgpBmJiDzw6=H3NekwTw@mail.gmail.com>
 <542724CE.6010701@xenomai.org>
 <CABVE6k3RJRMWy3HX57esnuhcB4FNBghZrqw9KHk1wCJffxKxjQ@mail.gmail.com>
 <CABVE6k1BTsTZsbGQ5Ru0-X8_qcx=Km+=FdtGZwPFZV-Vqe30og@mail.gmail.com>
In-Reply-To: <CABVE6k1BTsTZsbGQ5Ru0-X8_qcx=Km+=FdtGZwPFZV-Vqe30og@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] error about patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SGFzcmV0IFNhcsSxeWVy?= <hsrtsryr@gmail.com>
Cc: Xenomai <Xenomai@xenomai.org>

On 09/27/2014 11:10 PM, Hasret Sarıyer wrote:
> 2014-09-28 0:06 GMT+03:00 Hasret Sarıyer <hsrtsryr@gmail.com>:
> 
>>
>>
>> 2014-09-27 23:57 GMT+03:00 Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org>:
>>
>>> On 09/27/2014 08:45 PM, Hasret Sarıyer wrote:
>>>> I used this guide <http://xenomai.org/2014/06/building-debian-packages/>
>>> for
>>>> installation xenomai. And until I run a command, everything was nice.
>>> But
>>>> when I run this command, I get an error message.
>>>>
>>>> The command is :
>>>> linux-3.10.32$ /usr/src/xenomai-kernel-sources/scripts/prepare-kernel.sh
>>>> --linux=. --adeos=/usr/src/ipipe-core-3.10.32-x86-2.patch
>>>>
>>>> The output şs :
>>>>
>>>> bash: /usr/src/xenomai-kernel-sources/scripts/prepare-kernel.sh: No such
>>>> file or directory
>>>
>>> Ok, got it. The package is named xenomai-kernel-source, not
>>> xenomai-kernel-sources. Will fix the documentation, thanks for the report.
>>>
>>>
>>> --
>>>
>>
>>
>>
>>>                                                                 Gilles.
>>>
>>
>>  You are right. Thanks for your care.
>>
> 
> Also, there is an error message
> "/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh: line 283:
> /usr/src/xenomai-kernel-source/config/config.guess: No such file or
> directory".
>  I look manually xenomai-kernel-source folder, there isn't config folder
> under it.

Ok, please use prepare-kernel.sh from the xenomai-2.6.4 directory then.
Or pass --arch=x86 or --arch=x86_64 (depending whether you are compiling
for x86 or x86_64) to prepare-kernel.sh

-- 
                                                                Gilles.

