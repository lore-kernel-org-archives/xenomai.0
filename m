References: <CAOuPNLjAKofnxqE3F-CAKzPrkNak=-ZQP35L-ZE2aTvYz5ORGw@mail.gmail.com>
 <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
 <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0f568dbf-4ced-6e6a-9851-d8d66a5f764a@siemens.com>
Date: Tue, 13 Feb 2018 18:14:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [rtnet] - help required with rtnet interface bring up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: jan.kiszka@web.de, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-02-13 17:25, Pintu Kumar wrote:
> On Tue, Feb 13, 2018 at 8:09 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> Have you confirmed that the rtnet drivers for your system are loaded?
>> Are they built into the kernel or built as modules?
>>
> 
> Yes, I have enabled RTDM and RTNET in kernel confirm as loadable
> module (M), and rent drivers are loaded successfully.
> As I said before, all the rtnet modules are visible from lsmod.
> 
> Also, as I said rtnet loopback (rtlo) is working fine.
> But rteth0 does not come up using rent script.
> 
> I even tried forcefully reserving the interface name to (eth0, eth1)
> by passing kernel command line argument.
> Now the interface name is shown as : eth0, eth1 (instead of enp0*)
> 
> But still I am not able to get rteth0, rteth1 interface.
> 
> Is there any thing I am missing?

I do not know the details of virtualbox and which kind of ethernet
hardware it exposes to the guest. You can check with "lspci -knn" which
kernel driver is registered for which PCI device, of which one will be
your (virtual) NIC. If the network controller is (likely) still owned by
a linux driver, check if there is a corresponding rtnet driver and
specify that in /etc/rtnet.conf, along with the device that shall be
rebound.

When using a more powerful virtualization solution like QEMU/KVM, you
will get e1000/e1000e compatible models. Those at least used to work
fine with RTnet.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

