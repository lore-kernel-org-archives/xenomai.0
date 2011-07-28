Message-ID: <4E318E47.8030609@domain.hid>
Date: Thu, 28 Jul 2011 18:28:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E160578.5020405@domain.hid> <4E16F032.1050905@domain.hid>
	<4E16F4E0.8020900@domain.hid> <4E1BEE2C.7030800@domain.hid>
	<4E1BF47F.3050406@domain.hid> <4E305BE7.9090002@domain.hid>
	<4E318DD3.3020202@domain.hid>
In-Reply-To: <4E318DD3.3020202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] ipipe: Prevent unwritable pages after
	mprotect
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 2011-07-28 18:26, Jan Kiszka wrote:
> On 2011-07-27 20:41, Gilles Chanteperdrix wrote:
>> On 07/12/2011 09:15 AM, Jan Kiszka wrote:
>>> On 2011-07-12 08:48, Gilles Chanteperdrix wrote:
>>>> On 07/08/2011 02:15 PM, Jan Kiszka wrote:
>>>>> On 2011-07-08 13:55, Gilles Chanteperdrix wrote:
>>>>>> On 07/07/2011 09:14 PM, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>>
>>>>>>> Page protection changes issued via mprotect, e.g. to enable executable
>>>>>>> stacks, cause spurious minor faults as they remove the write permission
>>>>>>> from the modified range again. Avoid this by faking shared pages so that
>>>>>>> vm_get_page_prot returns the desired page permissions.
>>>>>>
>>>>>> This looks dangerous to me. Have you checked that write to private heaps
>>>>>> will not end up corrupting shared data?
>>>>>
>>>>> Can't follow this yet.
>>>>>
>>>>> If you check the comment on protection_map in mm/mmap.c, the difference
>>>>> between private and shared is in real write vs. COW-able write. That's
>>>>> what my patch is exploiting to get the proper arch-dependent page
>>>>> protection bits.
>>>>>
>>>>> Are you aware of side effects or do you know a better way to inject
>>>>> write permissions into the protection flags?
>>>>
>>>> I would tend to think that shared and private mappings do not react the
>>>> same way when we write to them.
>>>
>>> Yes, private mappings can undergo COW.
>>
>> My point exactly, so, say, if the mapping is an anonymous mapping with
>> only the zero page mapped, you will allow writing to the zero page, this
>> does not look like a sane thing to do. The same goes for private file
>> mappings where the code need to be modified (for instance relocations
>> when mixing non PIC code with PIC code).
> 
> To my understanding, and testing seems to confirm this, the branch under
> vma_wants_writenotify in mprotect_fixup: if there is a need to fault
                                         ^handles this

> even on shared pages (or pseudo-shared in our case), vm_page_prot will
> be overwritten anyway.
> 

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

