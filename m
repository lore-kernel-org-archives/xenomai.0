From: Wojciech Domski <wojciech.domski@gmail.com>
References: <0320e06c-4014-9294-0ff6-8cd6515fba24@gmail.com>
 <6e5a44b3-2ad4-ee3f-cd89-247b0b0ad7ac@gmail.com>
 <CALLqZ8T+5WSdTYGMiJr8S6x8gFaAN8tmp8Dtri8Fu+uxPwXUMw@mail.gmail.com>
 <f735d7fe-da3f-da95-0aac-a5a77430dac9@gmail.com>
 <6fc75021-86b5-0120-a59e-fd81ba6f40f6@gmail.com>
Message-ID: <a74daedf-fd85-e6b6-0d3b-ecc279b0f837@gmail.com>
Date: Thu, 18 Oct 2018 20:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <6fc75021-86b5-0120-a59e-fd81ba6f40f6@gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai v.3.0.7 on Ubuntu 18.04 and kernel 4.9.90
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I have conducted some additional tests and it seems that the patch is
the problem itself.

To confirm that the kernel is working properly I have compiled it as it
is using configuration from Ubuntu stock kernel. However, that doesn't
really say that everything is ok. After that I have configured the
kernel as I did for Xenomai but without patching it in the first place.
The configuration included disabling frequency scaling and etc. (based
on the tips in
https://gitlab.denx.de/Xenomai/xenomai/wikis/Configuring_For_X86_Based_Dual_Kernels).
After compilation of the kernel I can confirm that it works. I can boot
into the system.

I'm assuming that patching is causing booting issues. That said, do you
have any advice how to proceed further?

Wojciech Domski

domski.pl | blog.domski.pl

W dniu 11.10.2018 o 19:23, Wojciech Domski pisze:
>
> Here are kernel configurations files:
>
> https://pastebin.com/zuucW3WW (for clean 4.9.90)
>
> https://pastebin.com/AvD9T9Lx (for 4.9.90 with xenomai 3.0.7)
>
> I have also checked if there is anything in /var/log/kern.log. Beside
> normal kernel's logs there is nothing for the Xenomai flavoured
> version. It seems about right because it is stuck at "Loading initial
> ramdisk".
>
>
> Wojciech Domski
>
> domski.pl | blog.domski.pl
> W dniu 11.10.2018 o 17:00, Wojciech Domski pisze:
>>
>> I will post the kernel config file shortly and get back to you.
>>
>> As for the prints, no, there is nothing only those two lines:
>>
>> Loading Linux 4.9.90-xenomai-3.0.7 ...
>> Loading initial ramdisk ...
>> _ (here is the cursor)
>>
>> Best regards,
>>
>> Wojciech Domski
>>
>> domski.pl | blog.domski.pl
>> W dniu 11.10.2018 o 16:34, Greg Gallagher pisze:
>>> Posting the config may help.  Can you get any early printks?
>>>
>>> -Greg
>>>
>>> On Thu, Oct 11, 2018 at 7:48 AM Wojciech Domski
>>> <wojciech.domski@gmail.com <mailto:wojciech.domski@gmail.com>> wrote:
>>>
>>>     Hi!
>>>
>>>     I did additional test to rule out that Xenomai is the issue.
>>>
>>>     I have compiled kernel 4.9.90 without Xenomai and it turns out
>>>     that it
>>>     works. Having this in mind what could cause problem on Xenomai side?
>>>
>>>     If needed I will add additional information to trace the problem.
>>>
>>>     Best regards,
>>>
>>>     Wojciech Domski
>>>
>>>     domski.pl <http://domski.pl> | blog.domski.pl
>>>     <http://blog.domski.pl>
>>>
>>>     W dniu 10.10.2018 o 23:56, Wojciech Domski pisze:
>>>     > Hi!
>>>     >
>>>     > I am trying to set up Xenomai v.3.0.7 on Ubuntu 18.04 with
>>>     kernel 4.9.90.
>>>     >
>>>     > I have downloaded Xenomai from git and checked out the v.3.0.7
>>>     tag for
>>>     > stable version of Xenomai.
>>>     >
>>>     > To set up the new kernel I have copied the configuration from
>>>     currently
>>>     > running version (4.15.0-36-generic). Also I am preparing the
>>>     kernel with
>>>     > following
>>>     >
>>>     > sudo xenomai/scripts/prepare-kernel.sh --linux=/usr/src/linux
>>>     > --arch=x86_64 --ipipe=/usr/src/ipipe-core-4.9.90-x86-6.patch
>>>     >
>>>     > In kernel configuration I have turned off the following:
>>>     >
>>>     > Power management and ACPI options -> ACPI (Advanced
>>>     Configuration and
>>>     > Power Interface) Support -> Processor
>>>     > Power management and ACPI options -> CPU Frequency scaling -> CPU
>>>     > Frequency scaling
>>>     > Power management and ACPI options -> CPU Idle -> CPU idle PM
>>>     support
>>>     >
>>>     > Unfortunately, I could not turn off page migration since it is
>>>     build in
>>>     > the kernel and "hard fixing" it in the kernel configuration
>>>     file did not
>>>     > seemed to the best idea.
>>>     >
>>>     > After that I have build the kernel with following:
>>>     >
>>>     > sudo make-kpkg --initrd --append-to-version=-xenomai-3.0.7 -j8
>>>     > kernel-image kernel-headers modules
>>>     >
>>>     > and that
>>>     >
>>>     > sudo dpkg -i linux-image-*.deb
>>>     > sudo dpkg -i linux-headers-*.deb
>>>     > sudo update-initramfs -c -k "4.9.90-xenomai-3.0.7"
>>>     >
>>>     > What I am facing right now is the following problem. When I
>>>     boot up the
>>>     > PC freezes on "Loading initial ramdisk ...". Did I missed
>>>     something? It
>>>     > does not seem like it is Xenomai related problem since there
>>>     is an issue
>>>     > during mounting the temporary file system.
>>>     >
>>>     > Best regards,
>>>     >
>>>
>>>
>>>     _______________________________________________
>>>     Xenomai mailing list
>>>     Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>>>     https://xenomai.org/mailman/listinfo/xenomai
>>>
>>
>

