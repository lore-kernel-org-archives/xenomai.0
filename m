Message-ID: <51076EF7.7070800@zultron.com>
Date: Tue, 29 Jan 2013 00:40:55 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
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
	<CAKvQZ_2yaZyRBRjd6NxXeDaWd3v-dzerd7LzWo8uJPtdDBO4OQ@mail.gmail.com>
In-Reply-To: <CAKvQZ_2yaZyRBRjd6NxXeDaWd3v-dzerd7LzWo8uJPtdDBO4OQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: xenomai@xenomai.org



On 01/28/2013 03:11 AM, Willy Lambert wrote:
> 2013/1/28 John Morris <john@zultron.com>:
>> On 01/22/2013 02:31 AM, Willy Lambert wrote:
>>> Btw I personnaly don't use the --revision option to manage different
>>> tries because it is not completely visible when the packaged is
>>> installed
>>
>> There are a number of shortcomings with the instructions on my wiki
>> page, but as the page states, it is meant for one-off builds, and not
>> meant for packages to be widely distributed.  What do you do instead?  I
>> actually have never used Debian before, and have no idea what common
>> practice is.
> 
> It's not a problem of distributing your kernel. Is a matter of
> "you-will-have-to-do-several-tries-before-success-in-dev-phasis". So
> you may have several versions partially working on different part. And
> during the time you try to merge all this in your brand new ready to
> use package, you will be happy to be abble to boot independantly from
> different versions without loosing past semi-working versions so you
> can go back. It goes beyond version control system because it shows
> version in your binaries (with grub2 you will automatically have a
> correctly named entry in your boot menu) and have several /lib/modules
> dirs for each kernel versions.
> 
> Using only the revision part will creates the same entry in the boot
> menu, be installed in place of last version (so you have to remove old
> package and put the new one), have no way to determine where your
> .config comes out of your VSC ...
> 
> I use :
> General Setup -> Local version - append to kernel release (CONFIG_LOCALVERSION)
> with something like :
> -${my_institution}-${majorversion}.${dev version}
> which is -ard-10.9 currently/
> 
> I change this before modifying anything in my .config for a new
> package. I do 5 to 50 tries in dev phasis before launching a "public"
> major version.

I see what you mean.  Yes, the linuxcnc.org wiki howto does also use
--append-to-version, but only to distinguish package flavors.  This
appends extra identifying information to the package name (which
incorporates the kernel version, evidently common practice for Ubuntu
kernel packages) instead of to the package version, and this extra
information can be easily seen on the grub boot menu and other places.

--append-to-version might also be a handy way to keep track of builds
more easily during development, yes.  Package development workflow is
beyond the scope of my simple howto, though.

	John

