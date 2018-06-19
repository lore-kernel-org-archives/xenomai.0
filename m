MIME-Version: 1.0
In-Reply-To: <CAFUnMkkeqNzU7Cb8BN34S+DoS4C36455Th=j1pAktXaShFo7yA@mail.gmail.com>
References: <CAFUnMknnfLVajKcd1qL5LS9EKFpjb=jM1GbNbY5i00jh7ZqPyA@mail.gmail.com>
 <CALLqZ8QKJkfwwuT1MVLLzXMzUggQ+8KMcYUEusBJC+-QBpYKtQ@mail.gmail.com>
 <CAFUnMkkc8oL92bUvdnP0K_5aoAfa1eDap2GAByU7D1og8kKvkA@mail.gmail.com>
 <CALLqZ8SxmAO2r6-dQOCotR6ryJu5u_wQLbEzVoX0L0G5hq7nHg@mail.gmail.com>
 <CAFUnMkk01LW1YFzexuwm-uz7KFTKySTR-dWecz77kn-POJ-1hQ@mail.gmail.com>
 <CALLqZ8SUsyWab-1qDWOKNswWK=18mvp_C01hVijaA_N70WAH2A@mail.gmail.com>
 <CAFUnMk=fAXftrKQFiCBW+_iz0Kc_RV=gkW0FAnzXBaE9UZPQLQ@mail.gmail.com>
 <CALLqZ8QM5FVq5JGy=JoKZy1us8XiVXuZNgq1zewGkcF9UBLO7g@mail.gmail.com>
 <CAFUnMkmtcjYRqFcCRzzEnDyzJa3MFivA0PBC4_uqRfDTGsXO_A@mail.gmail.com>
 <CALLqZ8T9kY6okStaL5gStuk52T_7PTRuKgvY3K0t1bf8ydJJSw@mail.gmail.com>
 <CAFUnMkma08P_3+LHZ2VJNVnmUhcD1UV8uYjSrW0VQ4bRyRBLyA@mail.gmail.com>
 <CALLqZ8T67OiOeMykP87aJQimmKCSvz_9dTr3ciqRSGxW+ADE+w@mail.gmail.com>
 <CAFUnMkm7+DwgciXPtpDX875O=kz4NJch1me-WJc8+JVV6BDiHA@mail.gmail.com>
 <CALLqZ8QZ+OZzwv8vxh11b9HFjiAMn3EWx5mONpWNg2=SqnN8aA@mail.gmail.com>
 <CAFUnMk=K_CRGo-1Yv93fEPVcTpTEAGViBZxnhWbN4uVUSJvEEg@mail.gmail.com>
 <CALLqZ8Sd4Mqx5n0_7mAPtd5xnj9L6PhqWo-nsDgA3CUrVKzpxQ@mail.gmail.com>
 <CAFUnMk=PqUSo0QWk6eyQwj01Jqv+X8+FciXdRj0BRL6NU_d7_A@mail.gmail.com>
 <CAFUnMkmJTbGcuCiSx5hx+dAqfTp3MJr8MAF9gR0KympRzFR55w@mail.gmail.com>
 <CALLqZ8TvSeEvXcPXn8hTeHxGtkU_VhePEOd2EHgOQNuukTcVdg@mail.gmail.com>
 <CAFUnMkkeqNzU7Cb8BN34S+DoS4C36455Th=j1pAktXaShFo7yA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 19 Jun 2018 14:46:19 -0400
Message-ID: <CALLqZ8R4sXv3E_TKCa0rhE6KK_BC_UbBJtpG2Y5rJRXZSkG0dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] xenomai modules - xeno_rtdm, xeno_hal,
 xeno_nucleus. not getting installed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

You can use RTNet with Xenomai-3, please look through the mail list,
there have been many threads about configuring RTNet and Xenomai-3.
RTNet is built into Xenomai-3, you don't need these modules.  The link
below has some good information on RTNet.

https://gitlab.denx.de/Xenomai/xenomai/wikis/Programming

For your module problem you need to look at the  make-kpkg command and
see how to use modules_image flag.  It should build your modules.

-Greg

On Tue, Jun 19, 2018 at 2:33 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
> I want to use xenomai with RTnet, so that I can use soem ethercat
> protocol for controlling applications for servo drive.
> for this I need to load the following modules.
>
> sudo modprobe xeno_rtdm.ko
> sudo modprobe xeno_hal.ko
> sudo modprobe xeno_nucleus.ko
>
> I followed this links to go with, but I got struck with the problem to
> get the modules installed,
> mainly rtdm modules which is used to open rteth0 for ethercat communication.
>
> https://gist.github.com/cbhust/62a01ff22007b9695ef1da2ccc16b993
>
> can you please help to solve the problems to configure and to build
> the kernel and installing the modules in x86_64 architecture.
>
> Thank you
>
>
> On Tue, Jun 19, 2018 at 11:11 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> You won't need them for Xenomai-3 if you aren't using things like
>> rtnet, ipc or any driver that can be found in the Xenomai tree.  Are
>> you using a Debian system?  This tutorial will get you started:
>>
>> http://rtt-lwr.readthedocs.io/en/latest/rtpc/xenomai3.html
>>
>> You'll post later tonight my steps on building an x86 kernel.  With
>> the above tutorial you'll need to do the modules_image step to
>> generate an image for the modules.  If you explain what you are trying
>> to achieve I may be able to help you configure you system better.
>>
>> -Greg
>>
>> On Tue, Jun 19, 2018 at 1:26 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>> can you please provide me steps to
>>> configure and to build xenomai -3 in x86_64 architecture.
>>>
>>> to get the modules xeno_rtdm.ko,xeno_hal.ko,xeno_nucleus.ko.
>>>
>>> thank you
>>>
>>> On Tue, Jun 19, 2018 at 10:35 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>> Ok I will go through the make-kpkg command can you please provide me
>>>> to how to build xenomai -3 in x86_64 architecture.
>>>>
>>>> to get the modules xeno_rtdm.ko,xeno_hal.ko,xeno_nucleus.ko.
>>>>
>>>>
>>>>
>>>> On Tue, Jun 19, 2018 at 10:24 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>> Look at the documentation for make-kpkg, you need to build the modules
>>>>> using 'modules_image'
>>>>>
>>>>> https://manpages.debian.org/jessie/kernel-package/make-kpkg.1.en.html
>>>>>
>>>>> I don't think this is a Xenomai problem, this is an issue with using make-kpkg.
>>>>>
>>>>> There are other ways to build a kernel for x86_64 that you can follow.
>>>>> If this isn't an existing project I really recommend using Xenomai-3
>>>>> instead of the older version.
>>>>>
>>>>> -Greg
>>>>>
>>>>> On Tue, Jun 19, 2018 at 12:45 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>> I have build  3.14.17-xenomai-2.6.4 and I have build
>>>>>> 3.14.17-xenomai-2.6.4 too using the links below
>>>>>>
>>>>>> https://github.com/lma-cfpp/cfppa-framework-old/wiki/Xenomai-Kernel
>>>>>> http://rtt-lwr.readthedocs.io/en/latest/rtpc/xenomai.html
>>>>>>
>>>>>> http://rtt-lwr.readthedocs.io/en/latest/adv-tutos/bicompil.html
>>>>>>
>>>>>> both gave me the same result, and I am using x86_64 architecture.
>>>>>>
>>>>>> On Tue, Jun 19, 2018 at 10:10 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>> You said before you are using 3.18.20?  Are you building for 3.18.20
>>>>>>> or 3.14.17? Are you seeing the object files in your build directory in
>>>>>>> the driver folder?
>>>>>>>
>>>>>>> On Tue, Jun 19, 2018 at 12:33 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>> in my lib/module/
>>>>>>>>
>>>>>>>> I am able to get this folder 3.14.17-xenomai-2.6.4 ,
>>>>>>>> in this folder I am able to get xeno_rtdm.o,xeno_hal.o,xeno_nucleus.o.
>>>>>>>> some where in arch , drivers, kernel directory , but I am not able to get
>>>>>>>> xeno_rtdm.ko,xeno_hal.ko,xeno_nucleus.ko,
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, Jun 19, 2018 at 9:56 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>> When you install your package what do you see under /lib/modules ?
>>>>>>>>>
>>>>>>>>> On Tue, Jun 19, 2018 at 12:13 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>>>> sudo make menuconfig
>>>>>>>>>>
>>>>>>>>>> make-kpkg --bzimage --initrd --append-to-version=-xenomai-2.6.4 -j8
>>>>>>>>>> kernel-image kernel-headers modules
>>>>>>>>>>
>>>>>>>>>> On Tue, Jun 19, 2018 at 9:41 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>>>> What command are you using to build the kernel?
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Jun 19, 2018 at 12:02 PM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>>>>>> I too have followed the steps as mentioned in
>>>>>>>>>>>> http://www.orocos.org/files/tut_install_orocos_hydro_xeno.txt
>>>>>>>>>>>>
>>>>>>>>>>>> in kernel config point number  7. Make appropriate changes to
>>>>>>>>>>>> Real-time sub-system.
>>>>>>>>>>>>
>>>>>>>>>>>> I am using x86_64 architecture ,64 bit processor
>>>>>>>>>>>> what features should I enable and disable to get these modules
>>>>>>>>>>>> xeno_rtdm.ko,xeno_hal.ko,xeno_nucleus.ko.
>>>>>>>>>>>> in Real-time sub-system. kernel configuration.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> # Configure and build kernel
>>>>>>>>>>>> # 1. Processor type and features -> Processor family -- select proper
>>>>>>>>>>>> #    processor.
>>>>>>>>>>>> # 2. Power management and ACPI options -> ACPI (Advanced Configuration and
>>>>>>>>>>>> #    Power Interface) Support -- turn of Processor.
>>>>>>>>>>>> # 3. Power management and ACPI options -> CPU Frequency scaling -- turn off
>>>>>>>>>>>> #    CPU Frequency scaling.
>>>>>>>>>>>> # 4. Power management and ACPI options -- turn off CPU idle PM support.
>>>>>>>>>>>> # 5. Kernel hacking turn off KGDB: kernel debugger.
>>>>>>>>>>>> # 6. Turn off Virtualization.
>>>>>>>>>>>> # 7. Make appropriate changes to Real-time sub-system.
>>>>>>>>>>>> # 8. Device Drivers -> IOMMU Hardware Support -- turn off
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Jun 19, 2018 at 9:24 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>>>>>> Make sure you do your make step with 'make modules'.  I used this
>>>>>>>>>>>>> tutorial [1] when i was building xenomai 2.6 a long time ago, it
>>>>>>>>>>>>> should help you as well.
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1] http://www.orocos.org/files/tut_install_orocos_hydro_xeno.txt
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tue, Jun 19, 2018 at 11:47 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>>>>>>>> In menuconfig I have used
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> the following
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> * General setup
>>>>>>>>>>>>>>   --> Local version - append to kernel release: -xenomai-2.6.5
>>>>>>>>>>>>>>   --> Timers subsystem
>>>>>>>>>>>>>>       --> High Resolution Timer Support (Enable)
>>>>>>>>>>>>>> * Real-time sub-system
>>>>>>>>>>>>>>   --> Xenomai (Enable)
>>>>>>>>>>>>>>   --> Nucleus (Enable)
>>>>>>>>>>>>>>       --> Pervasive real-time support in user-space (Enable)
>>>>>>>>>>>>>> * Power management and ACPI options
>>>>>>>>>>>>>>   --> Run-time PM core functionality (Disable)
>>>>>>>>>>>>>>   --> ACPI (Advanced Configuration and Power Interface) Support
>>>>>>>>>>>>>>       --> Processor (Disable)
>>>>>>>>>>>>>>   --> CPU Frequency scaling
>>>>>>>>>>>>>>       --> CPU Frequency scaling (Disable)
>>>>>>>>>>>>>>   --> CPU idle
>>>>>>>>>>>>>>       --> CPU idle PM support (Disable)
>>>>>>>>>>>>>> * Pocessor type and features
>>>>>>>>>>>>>>   --> Processor family
>>>>>>>>>>>>>>       --> Core 2/newer Xeon (if \"cat /proc/cpuinfo | grep family\"
>>>>>>>>>>>>>> returns 6, set as Generic otherwise)
>>>>>>>>>>>>>> * Power management and ACPI options
>>>>>>>>>>>>>>   --> Memory power savings
>>>>>>>>>>>>>>       --> Intel chipset idle memory power saving driver (Disable)
>>>>>>>>>>>>>> and in nucleus I have seleted RTDM drivers, in interfaces,drivers etc
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> and I am using x86_64 processor configuration.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Jun 19, 2018 at 9:12 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>>>>>>>> Under the Xenomai section of menuconfig, do you have them selected as
>>>>>>>>>>>>>>> modules you can load or built into the kernel?  Also you are using a
>>>>>>>>>>>>>>> pretty old version on Xenomai, have you considered using Xenomai-3
>>>>>>>>>>>>>>> instead?  I haven't used Xenomai 2.6 in a while so my support may be
>>>>>>>>>>>>>>> rusty.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, Jun 19, 2018 at 11:29 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I am getting xeno_rtdm.o,xeno_hal.o,xeno_nucleus.o. file but I am not
>>>>>>>>>>>>>>>> getting xeno_rtdm.ko, xeno_hal.ko, xeno_nucleus.ko
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I should get .ko file to load it in kernel module .
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thank you
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Tue, Jun 19, 2018 at 8:47 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>>>>>>>>>> Are you building the RTDM modules? Do you see them getting built in
>>>>>>>>>>>>>>>>> the kernel output.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Please refrain from continuously posting the same question, we will
>>>>>>>>>>>>>>>>> try to help you but it may take some time to respond.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> -Greg
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Tue, Jun 19, 2018 at 5:44 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I have turned modules ON, I have attached the enable modules section
>>>>>>>>>>>>>>>>>> in the kernel configuration
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> thank you
>>>>>>>>>>>>>>>>>> R.Ashokkumar
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Mon, Jun 18, 2018 at 7:30 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>>>>>>>>>>>> Did you turn them on in menuconfig when you built your kernel?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -Greg
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On Mon, Jun 18, 2018 at 1:40 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I have patched xenomai -2.6.4 with linux 3.18.20 .
>>>>>>>>>>>>>>>>>>>> and installed the patched kernel, and  compiled the xenomai library using below
>>>>>>>>>>>>>>>>>>>> commands
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> cd /usr/src
>>>>>>>>>>>>>>>>>>>> sudo mkdir build_xenomai-2.6.4
>>>>>>>>>>>>>>>>>>>> cd build_xenomai-2.6.4
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> sudo ../xenomai-2.6.4/configure --enable-shared --enable-smp --enable-x86-sep
>>>>>>>>>>>>>>>>>>>> sudo make -j8
>>>>>>>>>>>>>>>>>>>> sudo make install
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> in /usr/xenomai/ I am not able to get the modules directory and xenomai modules
>>>>>>>>>>>>>>>>>>>> are not available ,xeno_rtdm,xeno_hal,xeno_nucleus.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I used the below command to load the modules
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> sudo modprobe xeno_rtdm,
>>>>>>>>>>>>>>>>>>>> sudo modprobe xeno_hal
>>>>>>>>>>>>>>>>>>>> sudo modprobe xeno_nucleus
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> but the modules are not getting loaded.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> is there any modification should be done in the make file, or any
>>>>>>>>>>>>>>>>>>>> other options should be enabled in the configure options
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> kindly help me the get the xenomai modules available.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thank you
>>>>>>>>>>>>>>>>>>>> R.Ashokkumar
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> _______________________________________________
>>>>>>>>>>>>>>>>>>>> Xenomai mailing list
>>>>>>>>>>>>>>>>>>>> Xenomai@xenomai.org
>>>>>>>>>>>>>>>>>>>> https://xenomai.org/mailman/listinfo/xenomai

