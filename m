Subject: Re: kvm fpu warning on 4.14.89
References: <d53140e58f60459694e2e66a94d0a518@systemceramics.com>
 <CAPR3TAhurhcwOGe9wfnOTUd=VBRvXuMLxZtNZ-3+QNyd=TOJnA@mail.gmail.com>
 <ebec2dcf-9549-fed2-6a48-299597bc7079@siemens.com>
 <CAPR3TAjFNV-0LgZ=+ydtseAQw-jdmYRHO4FQwybTjAHwDV59Xg@mail.gmail.com>
 <CAPR3TAhP1VwSE5OjKiznfuzsRXyigeN+ohQP1jQE-roLDMh5LA@mail.gmail.com>
 <32be3d2e-020f-468c-2940-26a09e96daeb@siemens.com>
 <CAPR3TAitTeY0rNVZ6v0moFzh0d_hA6zyS-R3fm+DK+HX4yj3PQ@mail.gmail.com>
 <04ffd701-4df7-5a2b-8000-cf5bec9d06d7@siemens.com>
 <CAPR3TAg=5on1=gJHSChHHwAb3AafZNx3jizMerdZvYKnN5YObA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9d5a6b6e-d7ba-00cd-3851-b26961ebbee7@siemens.com>
Date: Thu, 21 Mar 2019 09:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAPR3TAg=5on1=gJHSChHHwAb3AafZNx3jizMerdZvYKnN5YObA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: cagnulein <cagnulein@gmail.com>
Cc: xenomai@xenomai.org

On 21.03.19 08:04, cagnulein wrote:
> I've got a similar issue even with the 4.9.146 with a kvm guest on and latency 
> on too. It's quite deterministic. Any idea?
>

I didn't trigger your trace yet, but I can know study this splash:

[  140.794470] I-pipe: Detected illicit call from head domain 'Xenomai'
[  140.794470]         into a regular Linux service
[  140.797855] CPU: 0 PID: 1021 Comm: qemu-system-x86 Not tainted 4.14.103+ #43
[  140.799644] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[  140.799648] I-pipe domain: Xenomai
[  140.799650] Call Trace:
[  140.799654]  <IRQ>
[  140.799670]  ipipe_root_only+0xfe/0x130
[  140.799678]  ipipe_stall_root+0xe/0x60
[  140.799685]  lock_acquire+0x62/0x1a0
[  140.799692]  ? __switch_to_asm+0x40/0x70
[  140.799703]  kvm_arch_vcpu_put+0xb0/0x1a0
[  140.799707]  ? kvm_arch_vcpu_put+0x6e/0x1a0
[  140.799717]  __ipipe_handle_vm_preemption+0x2a/0x50
[  140.799723]  ___xnsched_run.part.76+0x371/0x590
[  140.799733]  xnintr_core_clock_handler+0x3f5/0x420
[  140.799745]  dispatch_irq_head+0x9a/0x150
[  140.799757]  __ipipe_handle_irq+0x7e/0x210
[  140.799768]  apic_timer_interrupt+0x7f/0xb0
[...]

Will let you know when I have details.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

