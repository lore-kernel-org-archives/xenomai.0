References: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
 <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
Date: Fri, 15 Dec 2017 12:04:45 +0100
MIME-Version: 1.0
In-Reply-To: <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/15/2017 11:46 AM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> On 06/12/17 18:37, Philippe Gerum wrote:
>>
> [...]
> 
>> If you depend on RTnet and want to help with testing, you may want to
>> give this branch a try. Any help with reviewing the changes would be
>> beneficial to the project too.
> 
> I have tested this branch in two x86 boards: one modern i7 witn PCIe 3x, etc,
> and another Dual-core. Both systems where tested with the same kernel:
> 
> - 4.9.51 patched
> - based in Debian stretch
> 
> 
> Mainly I tested the RTNet drivers, for the cards that I have: intel based e1000,
> e1000e, eepro100, igb, and r8168, and PCIe and PCI cards.
> 
> I haver also some 3Com but I have not tested because they are quite old.
> 
> The results are frustrating ...
> 
> 1) in the modern board, the integrated NIC Intel I219-LM was not detected by the
> rt driver.
> 
> 2) in both boards, none of the PCI cards worked: neither Intel or Realtek.
> 
> 3) the PCIe cards from intel worked (e1000e and igb) in both mobos
> 
> 4) in the modern PC, the r8168 was loaded and created the rtethX interface, but
> it was not operational (hangs the program). In the old PC do nothing.
> 
> 5) in the old PC (only tested there) the r8168 doesn't detect the
> RTL8111/8168/8411 PCIe cards although they are PCIe
>

Thanks for testing. The fixes I was referring too are not related to NIC
support, they can only be tested with a working NIC actually, since the
bugs they address were affecting the I/O path between the driver and
userland. We could test them with the loopback interface the same way.

This said, your results confirm that the RTnet support has severely bit
rotten (I only tested with the igb which is (only) the NIC I need, at
the moment).

> I guess that there's something in the kernel config or somewhere in 3.x that
> affects the PCI cards. In 2.6.x worked.

On x86, I'd dare to say that it worked mostly by accident, as revealed
by SMAP later on. RTnet was out of the Xenomai tree in 2.6.x, some
changes introduced during the merge into 3.x might have caused
regressions, or maybe some latent issues started to bite when transposed
in a different environment, just like the SMAP problem on x86, revealing
an ancient Rnet bug. I genuinely don't know when things started to hit
the fan.

> 
> Also, seeing the elephant, it's not obvious (at least for me) how to create or
> upgrade a network driver to work with Xenomai. So, some tutorial would help.
> 

I see this file in the distro which looks like a promising starting
point: kernels/drivers/net/doc/README.drvporting

-- 
Philippe.

