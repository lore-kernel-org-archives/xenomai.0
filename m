Message-ID: <8ac55670-66b3-e8b3-d328-3cdead2283a7@siemens.com>
Date: Wed, 16 Mar 2022 11:35:22 +0100
MIME-Version: 1.0
Subject: Re: System hang on first PCIe MSI interrupt with I-pipe kernels newer
 than 4.14.62
Content-Language: en-US
References: <7dcdb005-cec4-322d-9f30-ce008fd57608@arcor.de>
 <546e60f7-e968-7715-d227-d4e5013ee676@siemens.com>
 <edcd6dfc-0a6e-6004-ef19-290a7f2465f7@arcor.de>
 <b36143c7-5f21-8ca1-d3d2-023b5e0b9b8b@arcor.de>
 <f6743b0c-0792-3a67-820c-e68742f3eb46@siemens.com>
 <b1311ea0-c669-1492-26b6-d7d0375f8c44@arcor.de>
 <2da03290-90d7-64d7-301a-2cad4ec21a66@arcor.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2da03290-90d7-64d7-301a-2cad4ec21a66@arcor.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Scott Reed <scott.reed@arcor.de>, xenomai@xenomai.org

On 16.03.22 10:58, Scott Reed wrote:
> 
> 
> On 3/15/22 9:42 AM, Scott Reed via Xenomai wrote:
>>
>>
>> On 3/15/22 7:32 AM, Jan Kiszka wrote:
>>> On 14.03.22 18:45, Scott Reed wrote:
>>>>
>>>>
>>>> On 3/11/22 2:13 PM, Scott Reed via Xenomai wrote:
>>>>>
>>>>> On 3/11/22 12:38 PM, Jan Kiszka wrote:
>>>>>> On 11.03.22 11:12, Scott Reed via Xenomai wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I am seeing an apparent issue with PCIe MSI interrupts and I-pipe
>>>>>>> when trying to move to a newer kernel and I-pipe patch.
>>>>>>>
>>>>>>> The issue is as soon as a PCIe MSI interrupt occurs, the system
>>>>>>> hangs with no message output on the serial console or in
>>>>>>> /var/log/messages.
>>>>>>>
>>>>>>> The platform I am working on is a "i.MX 6 Quad" and I am upgrading
>>>>>>> from a 4.14.62 kernel and I-pipe patch with Xenomai 3.07 to 5.4.151
>>>>>>> kernel and I-pipe patch with Xenomai 3.2.1.
>>>>>>>
>>>>>>> Our FPGA is connected to the i.MX 6 via PCIe and generates PCIe MSI
>>>>>>> interrupts to the CPU from, for example, an Altera Triple-Speed MAC.
>>>>>>>
>>>>>>> I have stable system running for some time with Linux 4.14.62 with
>>>>>>> Xenomai 3.07 although I did need to patch the PCIe driver [1]. Also
>>>>>>> some time back, I tried to move to 4.14.110 with I-pipe and also
>>>>>>> saw same scenario of my system hanging on the first PCIe MSI
>>>>>>> interrupt
>>>>>>> so I backed out back to 4.14.62. Now I am trying to move to 5.4.151,
>>>>>>> but
>>>>>>> see the same hang.
>>>>>>
>>>>>> What about 4.19.y-cip? Specifically because of
>>>>>> https://source.denx.de/Xenomai/ipipe-arm/-/commit/a1aab8ba3098e595f9fa8b23a011ce6d72f8699c.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Actually, that commit is also missing from the last tagged 5.4 ipipe
>>>>>> version (ipipe-core-5.4.151-arm-4). So try ipipe/5.4.y head instead.
>>>>>
>>>>> To do a quick test, I just applied the change from the commit you
>>>>> referenced above to my 5.4.151 ipipe kernel and it unfortunately
>>>>> did not
>>>>> help (hang still occurs with first interrupt).
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Before I dive into analyzing the hang, I wanted to ask:
>>>>>>>
>>>>>>> What are other people's experiences with using PCIe MSI interrupts
>>>>>>> and I-pipe?
>>>>>>>
>>>>>>> I am thinking of trying 5.10.103 Dovetail to see if I still see
>>>>>>> the problem. Would this be recommended?
>>>>>>
>>>>>> If you can migrate your test with reasonable effort, yes, definitely.
>>>>>
>>>>> I will try to migrate my test to 5.10.103 Dovetail with the hopes that
>>>>> it will not be too much effort and report back.
>>>>
>>>> I tried to migrate my test to 5.10.103 Dovetail and failed on the first
>>>> step, namely bringing up a standard (i.e. no Dovetail) 5.10.103 kernel
>>>> on my platform.
>>>>
>>>> The kernel boots without a problem, but the FEC Ethernet port on the
>>>> i.MX 6 is not working (cannot ping in or out).
>>>
>>> Do you have or did you have any custom patches on top?
>>
>> Only a patch to add the device tree include (dtsi) for our imx6 SOC:
>>     μQ7-962 - μQseven standard module with NXP i.MX 6 Processor
>>
>>>
>>>>
>>>> I looked at the trace with Wireshark and it looks like when pinging
>>>> out that the ARP packet is corrupt and therefore failing. The ARP
>>>> packet is corrupt in that it looks like various bits are flipped. For
>>>> example, the source MAC address should be
>>>>    00:09:cc:02:c1:b6
>>>> but is
>>>>    00:01:cc:02:01:36 or
>>>>    00:09:cc:02:c1:36
>>>> Wireshark also complains about the Frame check sequence
>>>> ([FCS Status: Unverified]
>>>>
>>>> I can provide Wireshark dumps if someone is interested, but for me
>>>> at this point I do not want to fight with getting a 5.10.x kernel
>>>> to work as I was pretty far along moving to a 5.4.x kernel with
>>>> ipipe before running into the original problem posted (with ipipe
>>>> my system freezes on the first PCIe MSI interrupt. Note: without
>>>> ipipe, I do not see any issues).
>>>>
>>>> As mentioned, I first saw this problem a while ago when trying
>>>> to move from 4.14.62+ipipe to 4.14.110+ipipe and at that time
>>>> then backed back down to 4.14.62+ipipe which works.
>>>>
>>>> I guess my next strategy is to try to figure out what changed
>>>> between 4.14.62+ipipe and 4.14.110+ipipe which triggers/causes
>>>> the hang as I hope the delta between them is not too large.
>>>>
>>>> If anyone has other suggestions or tips, they are more than welcome.
>>>
>>> As I wrote before: try the latest 4.19-cip-ipipe first.
>>
>> OK. Will do.
> 
> I was able to run my test where the system hangs on the first
> PCIe MSI interrupt on the latest 4.19-cip-ipipe (4.19.229) and
> unfortunately see the same behavior (system hangs).
> 
> PCIe MSI interrupts work as expected on a "vanilla" 4.19.229 kernel,
> but when I add  ipipe and Xenomai 3.2.1 to the kernel, then
> the system hangs on the first PCIe MSI interrupt.
> 
> As mentioned before, I first observed this behavior when moving from
> 4.14.62+ipipe and 4.14.110+ipipe so I think my best bet is to dive
> into what changed in this time frame. My goal is still to move to

Yes, that might be a way now to try to find the root cause. Problem: you
can't do bisection easily because of the merges with the I-pipe patch.
Therefore, it can be easier to actually debug where the system hangs, on
what. With some traces from there, it can then be simpler again to
analyse the differences between to working and non-working 4.14 kernels.

> 5.4.x+ipipe, but need to first understand what change is causing
> my problem. I assume it is a kernel change or i-pipe change which
> either causes the problem or triggers a problem in our system which
> was dormant up until now.
> 
> I suppose I could try the 4.14.101 kernel with the 4.14.62 ipipe
> patch (if the patch applies cleanly) to try and determine if the
> problematic change is in the kernel or ipipe patch.
> 
> A question in general. How "common" is it to use PCIe MSI interrupts
> and ipipe? Are other people running systems with PCIe MSI interrupts
> and ipipe without issues or is this simply not a typical use-case?
> 

PCIe and MSI are very common and well tested - on x86, possibly also on
arm64. It is very likely not that well on 32-bit arm, though.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

