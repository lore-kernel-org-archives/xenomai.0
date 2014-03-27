MIME-Version: 1.0
In-Reply-To: <CAK4EZFSr_caXdr+ZsPG4-z5iXFcoBFTzwcM2jbb2H+QWOx_cpQ@mail.gmail.com>
References: <CAK4EZFTBCxVWrbMS9DTnR72bcVnSkrkEDCfCZye4u-BREFGoBg@mail.gmail.com>
 <5332A14F.2070303@xenomai.org>
 <CAK4EZFSWuzPgQ8QWn8tY8Wpmojca+vgezSkFMXsS13kBOx7qsA@mail.gmail.com>
 <201403271118.45617.paul_c@tuxcnc.org>
 <CAK4EZFSr_caXdr+ZsPG4-z5iXFcoBFTzwcM2jbb2H+QWOx_cpQ@mail.gmail.com>
Date: Thu, 27 Mar 2014 15:09:39 -0400
Message-ID: <CAK4EZFRmUsGQWUu4Tdw3_hoGD8ykpHb2fRfi-uVXBuTn3xS_ig@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Raspberry Pi Xenomai Linux + Minimal Raspian Net
 Install Guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Actually, I forgot I also copy over kernel sources.  So that, the
kernel headers, and the Raspbian package build-essential should be
removed to cut down on the size, if you're cross-compiling everything.
 Removing the kernel sources alone brings the disk usage to 320 MB.

Anyway, I need to focus on some other work.  If someone wants to take
the lead and modify this guide to be better, feel free to do so.

On Thu, Mar 27, 2014 at 2:10 PM, Adam Vaughan <vaughana@umich.edu> wrote:
> I wrote this guide as if I was starting from scratch.  I thought it
> would be helpful.  I don't intend for it to cover everyone's use case,
> but it covers all the steps to get a basic install working.
>
> I'm not aware of any other guide that talks about the recent 3.8.13
> patches for Xenomai which Gilles and Gregory figured out.  This is my
> primary reason for sharing it.
>
>
>> A netinstall on to an SD card is extremely slow, and quite honestly, not
>> really needed unless you are trying squeeze a minimal install on to a
>> small card - The standard Raspian images fit quite comfortably on to a
>> 2G card (which is the starting point for most).
>
> It's not slow.  It takes <10 minutes from start to finish.  It takes
> time to download an ~800 MB compressed Raspbian image and then load it
> onto an SD card too...
>
> As for space, I need space to store data files on a headless Raspberry
> Pi.  I do not need to waste space on X11 or any penguin games that
> might be installed.  Sure, there are other small custom options such
> as Buildroot, but honestly its easier / faster to start with a
> precompiled distribution with reasonably well tuned binaries.
>
> The author of the net installer says it can fit on a 512 MB SD card
> [1].  After I add compilation tools, the disk usage is 1.3 GB, which
> surprised me, but I haven't looked at it closely.  You can definitely
> build a smaller install with other tools, but I would like to just
> mention that there are other install options for the net installer,
> see [1].
>
>
>>> // Blow away existing tools...
>>
>> Why ?????
>
> Rather than attempting to figure out what a user may or may not have
> installed it's easier to just clear the two directories used.
>
> Feel free to add checking for existing tools.  If you want to also
> check for a Crosstool toolchain, make sure the most recent Crosstool
> is used.  In another thread I mentioned SD card issues that were due
> to a bad default Crosstool toolchain for the Raspberry Pi.  I haven't
> looked to find the actual cause, but it seems to be fixed in the most
> recent version.
>
> For what it's worth, I don't actually erase my tools each time.  I
> know the toolchain I currently have works.
>
>
>>> // Get RPi cross compile tools...
>>> git clone --depth=1 git://github.com/raspberrypi/tools.git
>>
>> One of the key points of GIT (and other VCS packages) is that you only
>> need to pull in changes - This reduces the amount of data being
>> transfered and reduces the load on the hosting servers. Some people
>> have to pay for each Gigabyte and won't thank you for needlessly
>> running up their bill !
>
> You're right, I took the easiest way out by not attempting to figure
> out whether the user has someone installed or not.  This could be
> improved, but it does not have any technical impact on the result.
>
> As for bandwidth, --depth=1 is there.  There are also companies that
> provide free bandwidth and understand there are users that use that
> bandwidth.  I'm very happy with DreamHost.com
>
>
>>> https://www.dropbox.com/s/dcju74md5sz45at/rpi_xenomai_config && mv
>>> rpi_xenomai_config .config && make ARCH=arm oldconfig #
>>
>> A less than optimal config with CPU Frequency scaling enabled along with
>> a whole bunch of debug/tracing options that impact on performance.
>
> I hadn't looked at it closely.  I didn't write it.  Thanks for pointing it out.
>
> A recommended configuration for debug and regular usage would improve
> this guide.
>
> [1]  https://github.com/hifi/raspbian-ua-netinst

