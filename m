MIME-Version: 1.0
In-Reply-To: <CAH8NBSdJ_6pOsMb=4D0Z15ifr0q=0Qw7=8=rvW6B1wTH-AdT+g@mail.gmail.com>
References: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
	<51778082.4060504@xenomai.org>
	<CAH8NBSfP3ToQtYMFZymuPwB_E96q=7wBWsL_Ag2r2c=dSwa6yA@mail.gmail.com>
	<51779EF1.6010801@xenomai.org>
	<CAH8NBSfmRw8mGdH4Fo10bxCHP4YTpCcNkXDg_AFxxArQ7we6wA@mail.gmail.com>
	<CAH8NBSeCvBMAzGK8ewUvDW2TY4GYDzZSW8EF20+WyKFoMB2V0Q@mail.gmail.com>
	<5178F16B.504@xenomai.org> <5178F226.7090206@xenomai.org>
	<517A933F.6020908@xenomai.org>
	<CAH8NBSdJ_6pOsMb=4D0Z15ifr0q=0Qw7=8=rvW6B1wTH-AdT+g@mail.gmail.com>
Date: Tue, 30 Apr 2013 00:57:09 +0530
Message-ID: <CAH8NBSfdKt+-xXygF0i71QDg+8QpiFpRPfURPfNY-oubzECT1g@mail.gmail.com>
From: Srikanth C <srikanthc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Spurious interrupt are raised with 2.6.1 xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

Problem is resolved, issue with the hardware.

Thanks for your valuable time and support.

Regards,
Srikanth
On Apr 27, 2013 12:19 AM, "Srikanth C" <srikanthc9@gmail.com> wrote:

>
> CONFIG_PCI_MSI is disabled in kernel, still spurious interrupts are raised.
>
> I tried with 3.1.10 kernel with adeos 3.1.10 patch with the same config
> file but  no spurious interrupts are raised.
>
> adeos patches are working fine, problem only with ipipe series.
>
> why ppc_md.get_irq is reading FF when interrupt is raised (this is
> happening after patching the xenomai, without xenomai patch same kernel
> with same configuration is working fine).
>
>
> On Fri, Apr 26, 2013 at 8:16 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 04/25/2013 11:06 AM, Philippe Gerum wrote:
>>
>>> On 04/25/2013 11:03 AM, Philippe Gerum wrote:
>>>
>>>> On 04/25/2013 09:57 AM, Srikanth C wrote:
>>>>
>>>>> Test Results with adeos-ipipe patch:
>>>>>
>>>>> H/W Setup is same, S/W Changed to adeos-ipipe with 3.0.8 kernel.
>>>>>
>>>>> adeos-ipipe-3.0.8-powerpc-2.**13-04.patch applied to 3.0.8 kernel,
>>>>> spurious interrupt is not raised with this patch.
>>>>>
>>>>>
>>>> I still don't know what ppc platform you are running on, which does not
>>>> allow me to figure out which interrupt controller might be involved, and
>>>> how to try reproducing this issue.
>>>>
>>>> Again and I won't ask for this once more:
>>>>
>>>> - what is your ppc platform: 40x, 44x, 52xx, 82xx, 83xx, 85xx, 86xx,
>>>> anything else?
>>>>
>>>
>>> I need the cpu type _and_ the board type. Attaching your kernel .config
>>> would provide the required information.
>>>
>>
>> CONFIG_PCI_MSI as found in your configuration won't work, with any past
>> or current pipeline release for powerpc (3.0.8 was certainly a fluke, or
>> MSI was disabled there). The IRQ chip handlers are still attempting to mask
>> the MSI source upon interrupt, which won't fly in the I-pipe case.
>>
>> --
>> Philippe.
>>
>
>
