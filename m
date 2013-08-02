Message-ID: <51FB90A9.7060909@xenomai.org>
Date: Fri, 02 Aug 2013 12:57:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <004401ce8ca9$a2ad4870$e807d950$@z9.com>
	<51F97FF7.2030203@xenomai.org>
	<022801ce8e36$da4b7700$8ee26500$@z9.com>
	<51FAB95A.4000002@xenomai.org>
	<030f01ce8f2d$3672b330$a3581990$@z9.com>
In-Reply-To: <030f01ce8f2d$3672b330$a3581990$@z9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Permissions problem/interaction with udev on Xenomai
 current
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <gpontis@z9.com>
Cc: xenomai@xenomai.org

On 08/02/2013 05:05 AM, George Pontis wrote:

>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Thursday, August 01, 2013 12:39 PM
>> To: George Pontis
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] Permissions problem/interaction with udev on Xenomai
>> current
>>
>> On 07/31/2013 11:42 PM, George Pontis wrote:
>>
>>>> -----Original Message-----
>>>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>>>> Sent: Wednesday, July 31, 2013 2:22 PM
>>>> To: George Pontis
>>>> Cc: xenomai@xenomai.org
>>>> Subject: Re: [Xenomai] Permissions problem/interaction with udev on
>> Xenomai
>>>> current
>>>>
>>>> On 07/30/2013 12:19 AM, George Pontis wrote:
>>>>
>>>>> Permissions problem happening when building with the current git for
>>>> Xenomai:
>>>>>
>>>>> for i in   vxworks psos rtai uitron vrtx ; do rm -f
>>>> /home/gpontis/b2/g/output/target/usr/lib/lib$i.* ; if [ $i == "posix" ] ; then
>> rm
>>>> -f /home/gpontis/b2/g/output/target/usr/lib/posix.wrappers ; fi ; done
>>>>> if test -d /home/gpontis/b2/g/output/target/etc/udev/rules.d ; then for f
>> in
>>>> /home/gpontis/b2/g/output/build/xenomai-2.6/ksrc/nucleus/udev/*.rules ;
>> do
>>>> cp $f /home/gpontis/b2/g/output/target/etc/udev/rules.d/ ; done ; fi;
>>>>> cp: cannot create regular file
>>>> `/home/gpontis/b2/g/output/target/etc/udev/rules.d/rtheap.rules':
>>>> Permission denied
>>>>> cp: cannot create regular file
>>>> `/home/gpontis/b2/g/output/target/etc/udev/rules.d/rtpipe.rules':
>> Permission
>>>> denied
>>>>> make: *** [/home/gpontis/b2/g/output/build/xenomai-
>>>> 2.6/.stamp_target_installed] Error 1
>>>>> gpontis@ubuntuVm:~/b2/g$
>>>>
>>>>
>>>> Normally, this copy is run as root. Maybe you are trying to run "make
>>>> install" on a directory through NFS with root squashing enabled on the
>>>> server side?
>>>>
>>>> --
>>>>                                                                    Gilles.
>>>
>>> I could see running it as root if building and installing on the same computer.
>> In my case the
>>> build runs on a PC for an embedded target. There are many files that need to
>> be handled
>>> specially by the build environment. In my case this is buildroot, which tries to
>> take care of
>>> ownership and permissions when it creates a rootfs.tar.
>>>
>>> I see that something is testing sudo and the build is interrupted until the
>> users supplies
>>> the password. And under some conditions the target directory
>> etc/udev/rules.d is created
>>> as being owned by me, other times as being owned by root. When it is owned
>> by me, then
>>> the build succeeds. I could make a patch for buildroot to apply to a Xenomai
>> makefile or
>>> shell script. But I thought that I should ask before doing this, since we did not
>> experience
>>> this problem with xenomai current a couple of months ago.
>>
>>
>> in xenomai sources, the copy is run as root, by using the sudo command,
>> so, chances are that buildroot patches xenomai makefile and that is the
>> reason why you have this issue. IOW, this looks like a buildroot issue
>> more than a xenomai issue.
>>
>>>
>>> George
>>>
>>>
>>>
>>
>>
>>
>> --
>>                                                                   Gilles.
>
> It turned out that buildroot had a patch for this already. I just needed to adjust the offset for xenomai current
> and actually apply it. Their patch was a one line mod to make install-exec-local not depend on "devices".
> Sorry for the noise on the list.


Running make install-user instead of "make install" has the same effect 
as removing the dependency on "devices"..


-- 
                                                                 Gilles.

