Message-ID: <54C7A5E3.5060308@colgp.it>
Date: Tue, 27 Jan 2015 15:51:15 +0100
From: Luca Galvagno <luca.galvagno@colgp.it>
MIME-Version: 1.0
References: <54C760BC.7040301@colgp.it> <54C76713.2010904@xenomai.org>
 <54C76931.9080905@colgp.it> <54C76BB0.8060304@xenomai.org>
 <54C772AB.7010909@colgp.it> <54C7756B.6030604@xenomai.org>
In-Reply-To: <54C7756B.6030604@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux scheduling is hijacked from xenomai scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Hi Philippe,
we tried Xenomai 2.6.4, Kernel 3.8.13 and Adeos patch 
ipipe-core-3.8.13-powerpc-2.patch with success, no freeze !
We are doing some regression tests on our app.
Thanks for the support.
Regards

Luca Galvagno

Automation Systems R&D Manager
COL Giovanni Paolo S.P.A.
Stabilimento Catania
SP 14 n.93-95
95032 Piano Tavola, BELPASSO (CT)
tel. +39 095 7133088 ext. 4231
tel. +39 338 6096953
e-mail: luca.galvagno@colgp.it
Web: www.colgp.it

On 27/01/2015 12:24, Philippe Gerum wrote:
> On 01/27/2015 12:12 PM, Luca Galvagno wrote:
>> Hi Philippe,
>> we checked the kernel options you suggested and they are in line with
>> what you said.
>> When the system hangs we have the following log on console :
>>
>> [  391.382182] Unable to handle kernel paging request for instruction fetch
>> [  391.462985] Faulting instruction address: 0x00000000
>> [  391.522787] Oops: Kernel access of bad area, sig: 11 [#1]
> Well, bad news this is a crash, the CPU is jumping to some NULL handler
> it seems. You may want to enable CONFIG_KALLSYMS and
> CONFIG_DEBUG_BUGVERBOSE to get a backtrace with symbols.
>
> CONFIG_DEBUG_INFO is desirable too when looking for routines in the
> kernel assembly dump, and matching them to the source code.
>


