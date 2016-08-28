References: <5A2723010DA94C5A9E6C65B5AB3F5E7A@rtkbgeng>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <b367275f-dce5-4250-fd0c-286ab39b6762@grandegger.com>
Date: Sun, 28 Aug 2016 15:33:27 +0200
MIME-Version: 1.0
In-Reply-To: <5A2723010DA94C5A9E6C65B5AB3F5E7A@rtkbgeng>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Peak PCI CAN card problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Am 27.08.2016 um 10:21 schrieb Chunsheng Geng:
> Hi,sir
>
> I am testing the Peak PCI CAN,used the  xenomai-2.6.5 under the linux kernel-3.18.20.
> But,it can not to work.Can you give me some helps?
> Thanks.
>
> dmesg
> ======================================================================
> [    6.445321] ledtrig-cpu: registered to indicate activity on CPUs
> [    6.445564] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
> [    6.445584] RTCAN SJA1000 driver initialized
> [    6.445613] PEAK-PCI-CAN: initializing device 001c:0008
> [    6.450708] PEAK-PCI-CAN: base_addr=f8068000 conf_addr=f805e000 irq=18
> [    6.450733] rtcan: registered rtcan0
> [    6.450748] PEAK-PCI-CAN: base_addr=f806a400 conf_addr=f805e000 irq=18
> [    6.450760] ERROR -16: IRQ 18 is busy, check shared interrupt support!

Please enable shared interrupts (CONFIG_XENO_OPT_SHIRQ).

Wolfgang.


