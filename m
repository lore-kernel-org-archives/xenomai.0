Message-ID: <178ad36c-1829-4e46-3390-bf48eff953d8@siemens.com>
Date: Tue, 24 May 2022 08:33:29 +0200
MIME-Version: 1.0
Subject: Re: Wrong CPU count on Apollo Lake platform
Content-Language: en-US
References: <CAEwYQ4RW220Mv4Ee1nVNtu2Y7PSyf_GbuySyegQuOx6HVoQgvg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAEwYQ4RW220Mv4Ee1nVNtu2Y7PSyf_GbuySyegQuOx6HVoQgvg@mail.gmail.com>
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
To: "dabbede@gmail.com" <dabbede@gmail.com>, xenomai@xenomai.org

On 20.05.22 13:41, dabbede--- via Xenomai wrote:
> Dear Xenomai community,
> 
> I'm writing here because of the following issue: I have compiled a
> xenomai-patched kernel that, when used on an Intel Atom E3950 (Apollo
> Lake family), return the wrong cpu count (i.e. nproc returns 1 instead
> of 4, and also lscpu claims CPU(s): 1).
> The very same kernel, when run on an Intel i5-7440EQ, returns nproc=4,
> which is correct.
> I'm using CONFIG_GENERIC_CPU=y, and this, to my knowledge, should be a
> safer option to handle both Atom and i5 or other platforms. I've also
> tried to use CONFIG_MATOM or CONFIG_MCORE2 without noticeable
> differences.
> 
> I attach here the full config and the dmesg that I obtain on the two
> platforms. Comparing the logs I've noticed the message "BIOS bug, no
> explicit IRQ entries, using default mptable. (tell your hw vendor)"
> but I'm not sure whether this is the cause or an effect of the
> problem.
> 
> Can you help me suggesting which CONFIG option I should change?
> 

[    0.057400] Processor #0 (Bootup-CPU)
[    0.057403] BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)
[    0.057412] Processors: 1
[    0.057416] smpboot: Allowing 1 CPUs, 0 hotplug CPUs

Seems first of all unrelated to Xenomai.

Did you already try to compile a Xenomai/I-pipe free kernel with 
defconfig settings, whether that is able to detect all CPUs? If not, you 
should really look for a BIOS update of your board. Or complain with its 
vendor about breaking standards and, thus, Linux.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

