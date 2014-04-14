Message-ID: <534BD82E.6080205@xenomai.org>
Date: Mon, 14 Apr 2014 14:44:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>
In-Reply-To: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/14/2014 11:14 AM, Jeroen Van den Keybus wrote:
>
> [  143.797961] WARNING: at kernel/rcutree.c:480 rcu_irq_exit+0xb9/0xd0()
> [  143.797967] Modules linked in: xeno_native xeno_nucleus i915
> coretemp mperf ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
> glue_helper ablk_helper cryptd drm_kms_helper drm lpc_ich mfd_core
> ehci_pci ehci_hcd video backlight processor xhci_hcd e1000e igb
> usbcore firewire_ohci firewire_core i2c_algo_bit hwmon crc_itu_t ptp
> pps_core usb_common thermal fan
> [  143.798151] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 3.10.18-ipipe #17

Do you have CONFIG_NO_HZ_FULL enabled? If so, could you disable it and 
retry? Next step, same question for CONFIG_NO_HZ_IDLE.

TIA,

-- 
Philippe.

