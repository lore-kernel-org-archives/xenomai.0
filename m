MIME-Version: 1.0
In-Reply-To: <0f568dbf-4ced-6e6a-9851-d8d66a5f764a@siemens.com>
References: <CAOuPNLjAKofnxqE3F-CAKzPrkNak=-ZQP35L-ZE2aTvYz5ORGw@mail.gmail.com>
 <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
 <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
 <0f568dbf-4ced-6e6a-9851-d8d66a5f764a@siemens.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 13 Feb 2018 23:38:15 +0530
Message-ID: <CAOuPNLghM1YTfFtFg46raKU-NLZO5LGrG1sEXUjPpsXTK627-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [rtnet] - help required with rtnet interface bring up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: jan.kiszka@web.de, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Feb 13, 2018 at 10:44 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-02-13 17:25, Pintu Kumar wrote:
>> On Tue, Feb 13, 2018 at 8:09 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>> Have you confirmed that the rtnet drivers for your system are loaded?
>>> Are they built into the kernel or built as modules?
>>>
>>
>> Yes, I have enabled RTDM and RTNET in kernel confirm as loadable
>> module (M), and rent drivers are loaded successfully.
>> As I said before, all the rtnet modules are visible from lsmod.
>>
>> Also, as I said rtnet loopback (rtlo) is working fine.
>> But rteth0 does not come up using rent script.
>>
>> I even tried forcefully reserving the interface name to (eth0, eth1)
>> by passing kernel command line argument.
>> Now the interface name is shown as : eth0, eth1 (instead of enp0*)
>>
>> But still I am not able to get rteth0, rteth1 interface.
>>
>> Is there any thing I am missing?
>
> I do not know the details of virtualbox and which kind of ethernet
> hardware it exposes to the guest. You can check with "lspci -knn" which
> kernel driver is registered for which PCI device, of which one will be
> your (virtual) NIC. If the network controller is (likely) still owned by
> a linux driver, check if there is a corresponding rtnet driver and
> specify that in /etc/rtnet.conf, along with the device that shall be
> rebound.
>
> When using a more powerful virtualization solution like QEMU/KVM, you
> will get e1000/e1000e compatible models. Those at least used to work
> fine with RTnet.

Its a oracle virtual box 5.x with Ubuntu16 32-bit running on it as
guest. The host machine is HP Pavilion Laptop with Windows 7.
Yes, I also have e1000 module shown under the module list.
This is my module list with rtnet enabled.

# lsmod | grep rt
rtmac                   7879  1 tdma
rtcfg                  32455  0
rt_loopback             1143  1
rtpacket                5768  0
rtudp                   9262  0
rt_eepro100            14398  0
rtipv4                 21568  2 rtudp,rtcfg
rtnet                  46929  8
rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rtcfg,tdma

My question is what is the normal process for bringing up rtnet
interface (rteth0).
If you list down the steps, I will compare with mine and see if
anything is missing.

Normally for me, I follow this:
a) Install xenomai 3.0.6 kernel (using prepare_kernel) on linux mainline kernel.
b) In menuconfig, enable RTDM/RTNET driver, RTCAP and others using (M) option.
c) Enable RTDM serial driver as well (in built) - for later use.
d) Boot the Xenomai kernel.
e) Verify the /dev/rtnet and /dev/rtdm/ is available.
f) Check that ethernet is available in ifconfig.
    It could be: eth0, eth1 OR: enp0s8 etc.
g) Make changes in rtnet.cfg config to enable RTCAP=yes and loopback=yes
h) Start the rtnet script:
     /usr/xenomai/sbin/rtnet start
i) Do "lsmod" and verify that all rt drivers are loaded.
j) Check ifconfig : here we see only rtlo added (along with previous).

I am not making any changes in tdma.conf

Do we need to make any other changes in rtnet.conf file ?
Or do we need to use rtcfg to setup something before starting rtnet ?


Because if we start rtnet , I get this error:
rteth0: ERROR while getting interface flags: No such device
rteth0-mac: ERROR while getting interface flags: No such device

Regards,
Pintu


>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

