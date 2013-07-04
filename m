Message-ID: <51D565D9.2090007@xenomai.org>
Date: Thu, 04 Jul 2013 14:08:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAOfKkXHkoPvJmp1mFNWCMpiyH1vGP1fjOLs=6awoSc8gF3C_9Q@mail.gmail.com>
	<CAOfKkXE6rb1_aR_Jk_it=D5aVApUWERJxKHZg-4BXfEWdOeMvQ@mail.gmail.com>
	<208C6975C932E94F86239FEA59CCA6321892EB8C@AUSMXMBX02.mrws.biz>
	<51D53DCF.1070704@xenomai.org>
	<208C6975C932E94F86239FEA59CCA6321892EBB8@AUSMXMBX02.mrws.biz>
In-Reply-To: <208C6975C932E94F86239FEA59CCA6321892EBB8@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai processes crash with "Illegal instruction"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland-web.com
Cc: xenomai@xenomai.org

On 07/04/2013 01:20 PM, dietmar.schindler@manroland-web.com wrote:
>> Von: Philippe Gerum [mailto:rpm@xenomai.org]
>> Gesendet: Donnerstag, 4. Juli 2013 11:18
>>
>> On 07/04/2013 11:04 AM, dietmar.schindler@manroland-web.com wrote:
>>> We are having trouble with "Illegal instruction" (illegal opcode) crashes (dumping core) of
>> two different Xenomai programs on different computers, occuring approximately once every few
>> days. Here are some perhaps relevant details...
>>>
>>> Linux kernel version: 2.6.34
>>
>> Which I-pipe release?
>
> ... sorry for forgetting to mention - Adeos-Patch : ksrc/arch/powerpc/patches/adeos-ipipe-2.6.34.4-powerpc-2.10-05.patch
>
>>> So, the two cases look somewhat similar: The "Illegal instruction" is reported around
>> pthread_setcanceltype@plt; there are legal branch instructions there as well as at the branch
>> target locations; pthread_setcanceltype@plt is called from timed wait functions
>> (pthread_wait_np() and rt_task_sleep() resp.).
>>>
>>> We would be grateful for suggestions how to analyze and cure the problem.
>>
>> This looks like mm woes. Is CONFIG_XENO_HW_UNLOCKED_SWITCH enabled?
>
> Yes, CONFIG_XENO_HW_UNLOCKED_SWITCH=y. Should we try with it disabled?

Yes please. Until recently, enabling this feature introduced random 
mm-related issues under load. This only got properly fixed in patches 
for 3.5.7 and above.

-- 
Philippe.

