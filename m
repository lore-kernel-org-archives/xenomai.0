Message-ID: <546e60f7-e968-7715-d227-d4e5013ee676@siemens.com>
Date: Fri, 11 Mar 2022 12:38:36 +0100
MIME-Version: 1.0
Subject: Re: System hang on first PCIe MSI interrupt with I-pipe kernels newer
 than 4.14.62
Content-Language: en-US
References: <7dcdb005-cec4-322d-9f30-ce008fd57608@arcor.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7dcdb005-cec4-322d-9f30-ce008fd57608@arcor.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Scott Reed <scott.reed@arcor.de>, xenomai@xenomai.org

On 11.03.22 11:12, Scott Reed via Xenomai wrote:
> Hello,
> 
> I am seeing an apparent issue with PCIe MSI interrupts and I-pipe
> when trying to move to a newer kernel and I-pipe patch.
> 
> The issue is as soon as a PCIe MSI interrupt occurs, the system
> hangs with no message output on the serial console or in
> /var/log/messages.
> 
> The platform I am working on is a "i.MX 6 Quad" and I am upgrading
> from a 4.14.62 kernel and I-pipe patch with Xenomai 3.07 to 5.4.151
> kernel and I-pipe patch with Xenomai 3.2.1.
> 
> Our FPGA is connected to the i.MX 6 via PCIe and generates PCIe MSI
> interrupts to the CPU from, for example, an Altera Triple-Speed MAC.
> 
> I have stable system running for some time with Linux 4.14.62 with
> Xenomai 3.07 although I did need to patch the PCIe driver [1]. Also
> some time back, I tried to move to 4.14.110 with I-pipe and also
> saw same scenario of my system hanging on the first PCIe MSI interrupt
> so I backed out back to 4.14.62. Now I am trying to move to 5.4.151, but
> see the same hang.

What about 4.19.y-cip? Specifically because of
https://source.denx.de/Xenomai/ipipe-arm/-/commit/a1aab8ba3098e595f9fa8b23a011ce6d72f8699c.

Actually, that commit is also missing from the last tagged 5.4 ipipe
version (ipipe-core-5.4.151-arm-4). So try ipipe/5.4.y head instead.

> 
> Before I dive into analyzing the hang, I wanted to ask:
> 
> What are other people's experiences with using PCIe MSI interrupts
> and I-pipe?
> 
> I am thinking of trying 5.10.103 Dovetail to see if I still see
> the problem. Would this be recommended?

If you can migrate your test with reasonable effort, yes, definitely.

Jan

> 
> Thanks,
> 
> Scott
> 
> [1] https://xenomai.org/pipermail/xenomai/2021-August/046138.html
> 
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

