MIME-Version: 1.0
In-Reply-To: <5106228D.8040403@zultron.com>
References: <CAMgy_J0idydJq8wzH3CwQoCa+BEbSyUyOJoWmvwc+oAB3jpZ6w@mail.gmail.com>
	<CAKvQZ_2Nzfgj7oK12+t3CtLj-YWBCB=nFYSDU6B4KqW4aWQpnQ@mail.gmail.com>
	<50B88506.6000002@xenomai.org>
	<CAKvQZ_3LJ-u2B0zc0+pobSGnMZ4nNviyxfuP1uiVRVuHw9Y9pQ@mail.gmail.com>
	<50B8F21B.5090503@xenomai.org>
	<CAKvQZ_13VsZV9sKjNLqMTHJhGn55pjkLqffsb8kYQb1b8H7rFw@mail.gmail.com>
	<50FE4116.8060508@zultron.com>
	<CAKvQZ_1BF99C7MDuwOL+XJMEG=T9DV3zetEUL85-EyNcGwkzVw@mail.gmail.com>
	<CAKvQZ_1JThr2=TJ-2knMBwi-VmZpXnVMO8_QPE3OZdpoYYjogg@mail.gmail.com>
	<5106228D.8040403@zultron.com>
Date: Mon, 28 Jan 2013 10:11:01 +0100
Message-ID: <CAKvQZ_2yaZyRBRjd6NxXeDaWd3v-dzerd7LzWo8uJPtdDBO4OQ@mail.gmail.com>
From: Willy Lambert <lambert.willy@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

2013/1/28 John Morris <john@zultron.com>:
> On 01/22/2013 02:31 AM, Willy Lambert wrote:
>> 2013/1/22 Willy Lambert <lambert.willy@gmail.com>:
>>> 2013/1/22 John Morris <john@zultron.com>:
>>>> Hi Willy,
>>>>
>>>> On 01/21/2013 06:43 PM, Willy Lambert wrote:
>>>>> Here is a first try.
>>>>> http://www.xenomai.org/index.php/Building_kernel
>>>>>  Don't hesitate to comment/correct this. I will add some links later to :
>>>>> _ a good complete kernel building guide (if you have some please share)
>>>>> _ x86 configure hints wiki page.
>>>>>
>>>>> The end is a bit specific to Debian/Ubuntu distros. Is it a problem ?
>>>>> Should I rework this ?
>>>>
>>>> Nice write-up.  I've done the same thing on the LinuxCNC website.  Feel
>>>> free to comment, fix, borrow, ignore....
>>>>
>>>> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernel
>>>>
>>>>         John
>>>>
>>>
>>> Arg, a pity I know this just after I write the xenomai wiki :D But
>>> anyway thanks for pointing
>>>
>>> I think a part of this stuff has to come to the xenomai wiki because
>>> the question rise from time to time. We need 2 things :
>>> _ something like my page, about general thinking,  maybe without the
>>> compilation details (which is not depending on versions)
>>> _ intructions to build everything with latests versions (which is more
>>> like your page), which we have to maintain... (it alredy exists
>>> somewhere on the wiki, but I think is is not about kernel compilation)
>
> Good point, that's an important distinction I hadn't thought of:
> general thinking vs. compilation recipe.
>
> The Xenomai wiki does have something like that recipe for both xenomai
> and kernel packages:
>
> http://www.xenomai.org/index.php/Building_Debian_packages
>
>>> One point is that I'm not taking care about cross compiling the kernel...
>
> I'd like to know more about that, too, since LinuxCNC is preparing to
> support the BeagleBone (ARM) and will need kernel packages.
>

I can't help on this, since I use x86 to avoid such complications (I
started lunux and so on from zero not so long ago, so one point after
the other ^^). But I know people using scratchbox2 to help to do this
transparently :
http://forum.wdlxtv.com/viewtopic.php?f=&t=3108

Else it would be compilation configuration with some "CC=" env
variables to define or some "./configure -arch=XXX" magics to do.
Anyway the __main__ thing is to make people aware that they have to
know how to do it on a vanilla kernel __before__ speaking about
xenomai. Then they will know how to customize default commands.

>> Btw I personnaly don't use the --revision option to manage different
>> tries because it is not completely visible when the packaged is
>> installed
>
> There are a number of shortcomings with the instructions on my wiki
> page, but as the page states, it is meant for one-off builds, and not
> meant for packages to be widely distributed.  What do you do instead?  I
> actually have never used Debian before, and have no idea what common
> practice is.

It's not a problem of distributing your kernel. Is a matter of
"you-will-have-to-do-several-tries-before-success-in-dev-phasis". So
you may have several versions partially working on different part. And
during the time you try to merge all this in your brand new ready to
use package, you will be happy to be abble to boot independantly from
different versions without loosing past semi-working versions so you
can go back. It goes beyond version control system because it shows
version in your binaries (with grub2 you will automatically have a
correctly named entry in your boot menu) and have several /lib/modules
dirs for each kernel versions.

Using only the revision part will creates the same entry in the boot
menu, be installed in place of last version (so you have to remove old
package and put the new one), have no way to determine where your
.config comes out of your VSC ...

I use :
General Setup -> Local version - append to kernel release (CONFIG_LOCALVERSION)
with something like :
-${my_institution}-${majorversion}.${dev version}
which is -ard-10.9 currently/

I change this before modifying anything in my .config for a new
package. I do 5 to 50 tries in dev phasis before launching a "public"
major version.

>
> I did spend some time preparing kernel packages that I hope will be
> suitable for distribution some day.  The packages are built with
> dpkg-buildpackage, not make-kpkg, and use the revision from
> debian/changelog.

I don't pretend to know the best tools to do the stuff. I have found a
working way so I keep going with it. If you find better/more up to
date ways, go with it.

> There is a separate wiki page here that discusses
> more 'general thinking' subjects:
>
> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
>
>         John

