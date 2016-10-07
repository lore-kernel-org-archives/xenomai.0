References: <664a4398-90bc-b0cc-eb9a-6c6ede1f0b61@seoultech.ac.kr>
 <20161006154527.1a113427@md1em3qc>
From: Raimarius Delgado <raim223@seoultech.ac.kr>
Message-ID: <02ad8430-4e3d-5067-ecc6-f9a5b898b0ed@seoultech.ac.kr>
Date: Fri, 7 Oct 2016 09:52:03 +0900
MIME-Version: 1.0
In-Reply-To: <20161006154527.1a113427@md1em3qc>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai latency test hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On 2016-10-06 오후 10:45, Henning Schild wrote:
> The problem is caused by the Intel SMAP feature of your CPU. It is
> fixed - at least partially - in Xenomai 3. For further details read the
> Mailing list archive, this topic was just discussed.
>
> A quick solution to your current problem is disabling CONFIG_X86_SMAP
> in your kernel config or booting the kernel with "nosmap"
>
> Henning
>
> Am Thu, 6 Oct 2016 21:06:26 +0900
> schrieb Raimarius Delgado <raim223@seoultech.ac.kr>:
>
>> Hi,
>> I have installed Xenomai 2.6.4 alongside Linux 3.14.17, 3.14.39, and
>> 3.14.44 on Ubuntu 14.04. I encountered a problem when I try to run
>> the latency test, the system hangs with no output if run in user
>> space and abruptly ends (killed) if run in kernel space.
>>
>> I've seen a similar thread in:
>> http://www.xenomai.org/pipermail/xenomai/2015-July/034658.html but
>> there was no solution offered to this problem. All the kernel version
>> sub-levels demonstrated the same results.
>>
>> I am working on an Intel Core i7 6700 (Skylake) on a Gigabyte
>> GA-B150M-HD3. I am attaching the kernel log files and configurations
>> for 3.14.39 and 3.14.44. I have used ipipe-core-3.14.17-x86-6,
>> ipipe-core-3.14.39-x86-9, and ipipe-core-3.14.44-x86-12, respectively.
>>
>> Hope somebody could help me. Thanks in advance.
>>
>
Thank you that really solved the problem. I got tunnel visioned by the 
Xenomai version and was not able to consider reading similar problems on 
the cobalt core. I will be more productive by reading the mailing list 
archive and try to help the community.
Again ,Thank you very much.

-- 
Raimarius Delgado, M.Sc.Eng. (레임)
Embedded Systems Laboratory
Seoul National University of Science and Technology
Dept. of Electrical and Information Engineering
Phone: +82-2-970-9868
Mobile: +82-10-2129-4987


