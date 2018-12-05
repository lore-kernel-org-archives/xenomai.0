Subject: Re: Fwd: Re: EAFNOSUPPORT despite kernel build in
References: <b24704e2-25c6-80fc-5e9e-b0ec19a15c4b@compador.de>
 <b4e63339-021e-93d1-93fe-2560b69817a2@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7a1f426d-1eb1-4440-08dc-d27c2aa37e1c@siemens.com>
Date: Wed, 5 Dec 2018 10:48:07 +0100
MIME-Version: 1.0
In-Reply-To: <b4e63339-021e-93d1-93fe-2560b69817a2@compador.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>
Cc: xenomai@xenomai.org

On 05.12.18 10:32, Johannes Holtz wrote:
> Am 04.12.18 um 14:46 schrieb Jan Kiszka:
>> On 04.12.18 12:04, Johannes Holtz via Xenomai wrote:
>>>
>>> Hello,
>>>
>>> When I request a socket with AF_RTIPC I get an EAFNOSUPPORT in return.
>>> int sock = socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP);
>>
>> You likely didn't wrap this posix application to link against the Xenomai 
>> libs, rather than normal libc. See manuals / wikis.
>>
>>>
>>> rtipc.h is included
>>> #include <rtdm/rtipc.h>
>>>
>>> I have build the support for RTIPC into the kernel (not a module) and
>>> expected this to work more or less out of the box. Did I forget something
>>> or must this feature be a module?
>>> I have searched for a solution but haven't found anything.
>>>
>>> Here information about the system:
>>>
>>> virtual machine (VBox) with 1 CPU,  2.5GB RAM, 15GB disk
>>>
>>> base kernel version is 3.18.20
>>>
>>> xenomai  version is 2.6.5 (from the download page not from the git repo)
>>
>> Don't start anything new on 2.6 anymore, it's long retired.
>>
>>>
>>> using the included ipipe patch
>>> xenomai-2.6.5/ksrc/arch/x86/patches/ipipe-core-3.18.20-x86-7.patch
>>
>> Same goes for such old kernels and patches.
>>
>>>
>>> the kernel config has the feature enabled
>>> root@xeno:~/kernelbuild# grep RTIPC /boot/config-3.18.20
>>> CONFIG_XENO_DRIVERS_RTIPC=y
>>> CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
>>> CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
>>> CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
>>>
>>
>> Jan
>>
> Ok I understand you made two points here:
> 
> 1. there might be a wrapper for these standard system calls thatneeds to be 
> activated, presumably with the right xeno-config parameter
> 
> 2. In general the 2,x Xenomai version shouldn't be used anymore.
> 
> Regarding 1:
> 
> After your answer I looked again if I had overlooked any wrappers or 
> documentation but couldn't find any. The xeno-config man page was not helping 
> either and I tried a multitude of different variations and look into what each 
> skin switch does.
> 
> Maybe I have a general problem here. My code only compiles if I use 
> --skin=native PLUS the -rtdm flag.
> 
> To elaborate: My application uses rt threads rt can devices and rt IPC. Perhaps 
> you can point me to documentation where I can find out which LD flags I really 
> need for this scenario.
> 

If you are using plain POSIX APIs (such as socket & Co.) under real-time 
constraints, check 
https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_To_Xenomai_POSIX (should 
apply to 2.6 as well).

If you prefer the Native/Alchemy API without having to wrap anything, use 
rt_dev_ prefixes for those POSIX I/O calls that target Xenomai. The latter is no 
longer prominently documented because in 3.x we recommend treating RTDM usage 
like POSIX.

> 
> Regarding 2:
> 
> The application I write is an upgrade of an existing Codebase which is bound to 
> a certain Environment. Upgrading is not an option at this time.

I can only recommend to *plan* an update, develop an idea of what needs to be 
done and a strategy for how. I've seen too many projects that were "suddenly" 
forced to do that without such a plan, and that always causes massive problems.

I assume, security plays no role for that target device because you are using an 
unfixed kernel. But even if that is true, keep in mind that one day the hardware 
will have to be upgraded (old chips no longer available) and newer hardware 
tends to have smaller or bigger issues with running on such old kernels.

> 
> However, I looked into the compatibility mode to run my 2.x application on a 
> Xenomai 3.x but had no success getting it to compile correctly. If there is a 
> document where you can point me to resolve this would also be appreciated.
> 

Check 
https://gitlab.denx.de/Xenomai/xenomai/blob/master/doc/asciidoc/MIGRATION.adoc. 
If anything should not be addressed, just let us know.

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

