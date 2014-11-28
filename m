Message-ID: <54786583.5080205@siemens.com>
Date: Fri, 28 Nov 2014 13:07:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca> <20141127203400.GP7842@hermes>
 <54778CF6.6000909@siemens.com> <20141127231527.GC24076@hermes>
 <5478430B.9030602@siemens.com> <20141128095038.GA3832@hermes>
 <547846AC.6070204@siemens.com> <20141128095745.GB3832@hermes>
 <5478618F.1010506@siemens.com> <20141128115537.GB6395@hermes>
In-Reply-To: <20141128115537.GB6395@hermes>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-11-28 12:55, Gilles Chanteperdrix wrote:
> On Fri, Nov 28, 2014 at 12:50:39PM +0100, Jan Kiszka wrote:
>> On 2014-11-28 10:57, Gilles Chanteperdrix wrote:
>>> On Fri, Nov 28, 2014 at 10:55:56AM +0100, Jan Kiszka wrote:
>>>> On 2014-11-28 10:50, Gilles Chanteperdrix wrote:
>>>>> On Fri, Nov 28, 2014 at 10:40:27AM +0100, Jan Kiszka wrote:
>>>>>> On 2014-11-28 00:15, Gilles Chanteperdrix wrote:
>>>>>>> On Thu, Nov 27, 2014 at 09:43:34PM +0100, Jan Kiszka wrote:
>>>>>>>> On 2014-11-27 21:34, Gilles Chanteperdrix wrote:
>>>>>>>>> On Thu, Nov 27, 2014 at 02:14:38PM -0500, Lennart Sorensen wrote:
>>>>>>>>>> On Thu, Nov 27, 2014 at 07:51:27PM +0100, Jan Kiszka wrote:
>>>>>>>>>>> On 2014-11-27 19:18, Gilles Chanteperdrix wrote:
>>>>>>>>>>>> According to the filesystem hierarchy standard, /mnt is the standard
>>>>>>>>>>>> place for "temporarily mounted filesystems".
>>>>>>>>>>>>
>>>>>>>>>>>> http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
>>>>>>>>>>>
>>>>>>>>>>> Right, another reason to NOT mess around with it: if something was
>>>>>>>>>>> temporarily mounted there, we will create the mountpoint inside that
>>>>>>>>>>> filesystem with unforeseeable side effects.
>>>>>>>>>>
>>>>>>>>>> I always read that as "temporarily mounted there by the admin or some
>>>>>>>>>> other human".  Certainly not automatic mounts by software.  There is a
>>>>>>>>>> reason /media and such exists on many distributins.
>>>>>>>>>
>>>>>>>>> I would not venture an "always", autofs for instance, used to mount
>>>>>>>>> things under /mnt. and /media has not always existed either, we used
>>>>>>>>> /mnt/cdrom.
>>>>>>>>
>>>>>>>> FHS on /mnt purpose:
>>>>>>>>
>>>>>>>> "This directory is provided so that the system administrator may
>>>>>>>> temporarily mount a filesystem as needed. The content of this directory
>>>>>>>> is a local issue and should not affect the manner in which any program
>>>>>>>> is run."
>>>>>>>>
>>>>>>>> I think this makes it crystal clear that Xenomai is not supposed to
>>>>>>>> touch it.
>>>>>>>
>>>>>>> Just to add another argument. I just asked a friend who is a
>>>>>>> professional sysadmin. He creates directory under /mnt and mount
>>>>>>> things under these directories. So, I am not sure the standard is
>>>>>>> even applied by the people who should use it.
>>>>>>>
>>>>>>> If you read on the last site I sent, under the /media article: 
>>>>>>>
>>>>>>> Amid much controversy and consternation on the part of system and
>>>>>>> network administrators a directory containing mount points for
>>>>>>> removable media has now been created. Funnily enough, it has been
>>>>>>> named /media.
>>>>>>>
>>>>>>> Are you sure, 100% sure, that every Xenomai user expects to be able
>>>>>>> to use /mnt as a mount point? Or that they will create directories
>>>>>>> under /mnt like everybody has been doing since Linux exists?
>>>>>>
>>>>>> I'm both absolutely sure that a) has to be left alone by Xenomai because
>>>>>> of requirements of the FHS and the way /mnt is used and b) we should try
>>>>>> hard to avoid creating temporary dirs in persistent filesystems.
>>>>>
>>>>> This is ridiculous. Because the standard changed, and one
>>>>> distribution, Debian, decided to follow the new standard, which
>>>>> seems to be not widely accepted, and even controversial, you want to
>>>>> impose what Debian does to everybody. The distribution I use has
>>>>> mount points under /mnt. So, why following Debian and not the
>>>>> distribution I use, and what sysadmin have been doing for ages?
>>>>>
>>>>> You want the mount point to be somewhere else? Fine, put a symbolic
>>>>> link.
>>>>>
>>>>> mkdir /run/xenomai
>>>>> ln -s /run/xenomai /mnt/xenomai
>>>>
>>>> Again, this is not acceptible as /mnt changes all the time and exposes
>>>> various remote filesystems which will hide that link.
>>>
>>> You are missing the point. Yes, Debian does that, but not all
>>> distribution. Other distributions do not do that.
>>>
>>
>> SUSE, Ubuntu, Gentoo, Red Hat - it's already standard. But I will change
>> my patch to /var/run to avoid surprises with other/older distros.
> 
> Again, using /mnt/xenomai does not break any distribution following
> the standard.
> 
> Let us try things another way, the possibilities we have are:
> - /mnt/xenomai: a solution that used to be standard but ceased to be
> with the FHS which did not provide a standard replacement, but does
> not break any distribution

I don't remember that this was ever a standard. My distro (SUSE) never
used it like this as long as I can remember (~18 year).

> - /run/xenomai: a solution that relies on the existence on the /run
> directory, which is not standard, but is going to be, maybe.
> - /var/run/xenomai: a solution which does not violate any version of
> the standard, but is not standard either, does not make clear that
> the directory is a mount point (which /mnt does), breaks the

This is how it's used in practice:

gvfsd-fuse on /var/run/user/1000/gvfs type fuse.gvfsd-fuse
(rw,nosuid,nodev,relatime,user_id=1000,group_id=100)

Just to give one example.

> existing documentation, breaks the existing usages of Xenomai 3, and
> is longer to type.
> 
> So, I really find that /mnt/xenomai is the best compromise. There is
> no standard solution, at least /mnt/xenomai is a solution that used
> to be standard.

No, it remains a current standard (FHS 2.3) *violation*, it has to be
stopped.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

