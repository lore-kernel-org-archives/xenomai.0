Message-ID: <4F7AACC1.6080500@domain.hid>
Date: Tue, 03 Apr 2012 09:54:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F7A0F11.3080504@domain.hid> <4F7A128C.4040706@domain.hid>
	<4F7A133E.7000505@domain.hid> <4F7A2039.2040409@domain.hid>
	<4F7A211F.1080809@domain.hid>
In-Reply-To: <4F7A211F.1080809@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 04/02/2012 11:58 PM, Jan Kiszka wrote:
> On 2012-04-02 23:55, Gilles Chanteperdrix wrote:
>> On 04/02/2012 10:59 PM, Jan Kiszka wrote:
>>> On 2012-04-02 22:56, Jan Kiszka wrote:
>>>>> No luck, I am using qemu 0.12.5, there is no -global option documented,
>>>>
>>>> Err, that's prehistoric. Use stable 1.0.x at least to receive proper
>>>> HPET support.
>>>
>>> Oh, and there is one further pitfall: You need to provide
>>> -no-kvm-irqchip to use the HPET with MSI support because qemu-kvm does
>>> not forward those MSIs to the kernel irqchip model. I'm sitting on
>>> patches...
>>
>> Yes, I needed that. It works now, except that I could not find how to
>> use an NFS root filesystem. But with an ext3 file-backed filesystem, I
>> could get that:
> 
> If your NFS server runs on the host and you use userspace networking
> (default without additional parameters), the guest should be able to
> reach the server under 10.0.2.2 and use an IP like 10.0.2.15 (or dhcp).
> However, I recently failed to get this working as well but didn't dig
> deeper.

Well, with -net user, I do not get any network interface on the
simulated kernel. Maybe there a special network driver to enable in the
kernel? The documentation does not say which network card is simulated,
and I do not see any with lspci.

Something else, is it possible to run kvm using SCHED_FIFO policy? I
tried that and I almost got a lockup, was probably saved by throttling.

-- 
                                                                Gilles.

