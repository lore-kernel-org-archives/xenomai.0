Subject: Re: kernel compile problem
References: <CA+K1mPGeCCHRX+rZO=Bp8cFirBUHMbGGP5EcXJ8VY9vN4fb6_Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1766ddd8-ab9c-47b3-e861-e7d6981a2d31@siemens.com>
Date: Fri, 1 Mar 2019 09:50:04 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPGeCCHRX+rZO=Bp8cFirBUHMbGGP5EcXJ8VY9vN4fb6_Q@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 01.03.19 07:46, C Smith via Xenomai wrote:
> I am unable to compile a xenomai-patched kernel. I get this message:
> warning: (XENOMAI) selects IPIPE which has unmet direct dependencies
> (HAVE_IPIPE_SUPPORT)
> 
> kernel sources from kernel.org: 4.14.89
> with ipipe-core-4.14.89-x86-2.patch applied
> gcc version 4.9.2 20150212
> 
> I have attached my .config here. My apologies if it gets inlined.
> This config came from a working xenomai 2.6.5, 3.18.20 kernel.
> 

Try building a 64-bit kernel instead. We no longer test 32-bit (like most 
projects), but we do support compat mode (32-bit userland on top of 64-bit kernel).

Also check the warnings regarding potential latency sources that menuconfig 
displays and disable CONFIG_COMPACTION and CONFIG_SCHED_MC_PRIO ... -> 
ACPI_PROCESSOR.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

