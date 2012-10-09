Message-ID: <5074430B.90307@xenomai.org>
Date: Tue, 09 Oct 2012 17:30:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmtLLcZnbJ5vXJFRkdyoy1Qk_wfGR84LdB0dkb8KynS+Yg@mail.gmail.com>
	<50743048.1050305@xenomai.org>
	<CANKLDmtU2XwFi3XmN1BL3CcZare7QFu4u6vL-2c5fkbR9TSpsw@mail.gmail.com>
	<50744267.9030702@xenomai.org>
	<CANKLDms-sbO6M8j0Mr9ich4Lam94ggx+-_-6XYNCUVfYhX+PSw@mail.gmail.com>
In-Reply-To: <CANKLDms-sbO6M8j0Mr9ich4Lam94ggx+-_-6XYNCUVfYhX+PSw@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Exporting __ipipe_get_cs_tsc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: xenomai@xenomai.org

On 10/09/2012 05:28 PM, Henri Roosen wrote:
> On Tue, Oct 9, 2012 at 5:27 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 10/09/2012 05:24 PM, Henri Roosen wrote:
>>> On Tue, Oct 9, 2012 at 4:10 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>> On 10/09/2012 02:32 PM, Henri Roosen wrote:
>>>>> Hi,
>>>>>
>>>>> I'm using the current git heads of core-3.4 and xenomai 2.6.1 for x86
>>>>> with the attached config file.
>>>>>
>>>>> When compiling the modules I get undefined symbols:
>>>>> ERROR: "__ipipe_get_cs_tsc" [kernel/xenomai/skins/posix/xeno_posix.ko]
>>>>> undefined!
>>>>>
>>>>> This is because the run time seleted __ipipe_get_cs_tsc assembly
>>>>> function is not exported for module use.
>>>>> I don't know how to export this or whether the symbol should be used
>>>>> by modules in the first place.
>>>>>
>>>>
>>>> Please try this:
>>>>
>>>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>>>> index 430aeea..2d2f83c 100644
>>>> --- a/arch/x86/kernel/ipipe.c
>>>> +++ b/arch/x86/kernel/ipipe.c
>>>> @@ -634,6 +634,11 @@ void update_vsyscall(struct timespec *wall_time,
>>>> struct timespec *wtm,
>>>>  void update_vsyscall_tz(void)
>>>>  {
>>>>  }
>>>> +
>>>> +#ifdef CONFIG_IPIPE_WANT_CLOCKSOURCE
>>>> +EXPORT_SYMBOL_GPL(__ipipe_get_cs_tsc);
>>>> +#endif
>>>> +
>>>>  #endif /* CONFIG_X86_32 */
>>>>
>>>>  struct task_struct *__switch_to(struct task_struct *prev_p,
>>>
>>> Thanks for looking into this.
>>>
>>> Unfortunately with the patch the compile results in:
>>> arch/x86/kernel/ipipe.c:640: error: =91__ipipe_get_cs_tsc=92 undeclared
>>> here (not in a function)
>>
>> The function is declared nowhere, because it was supposedly only be used
>> in assembly. So, you need to declare the function before the
>> EXPORT_SYMBOL. Its prototype would be:
>>
>> unsigned long long __ipipe_get_tsc_tsc(void);
>=20
> I tried that and I can confirm it works.
>=20

Ok, pushing the fix.

>>
>> --
>>                                             Gilles.
>=20


--=20
Philippe.

