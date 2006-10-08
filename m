Message-ID: <4528F38B.90401@domain.hid>
Date: Sun, 08 Oct 2006 14:48:11 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcan_mscan compilation.
References: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
	<4526B48F.50705@domain.hid> <452767E0.3050107@domain.hid>
	<4527B59B.1030109@domain.hid> <4527E457.705@domain.hid>
	<4528B83D.2020803@domain.hid> <4528EAA7.4040402@domain.hid>
In-Reply-To: <4528EAA7.4040402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Ji Jan,
>>
>> Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>> Jan Kiszka wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> ...
>>>>>> Index: ksrc/drivers/can/rtcan_internal.h
>>>>>> ===================================================================
>>>>>> --- ksrc/drivers/can/rtcan_internal.h    (revision 1695)
>>>>>> +++ ksrc/drivers/can/rtcan_internal.h    (working copy)
>>>>>> @@ -111,6 +111,10 @@
>>>>>>  
>>>>>>  #ifndef compat_module_int_param_array
>>>>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
>>>>>> +# define compat_module_int_param(name) \
>>>>>> +    MODULE_PARM(name, "i")
>>>>>> +# define compat_module_charp_param(name) \
>>>>>> +    MODULE_PARM(name, "s")
>>>>>>  # define compat_module_byte_param_array(name, count) \
>>>>>>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "b")
>>>>>>  # define compat_module_short_param_array(name, count) \
>>>>>> @@ -118,6 +122,10 @@
>>>>>>  # define compat_module_int_param_array(name, count) \
>>>>>>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "i")
>>>>>>  #else
>>>>>> +# define compat_module_int_param(name) \
>>>>>> +    module_param(name, int, 0444)
>>>>>> +# define compat_module_charp_param(name) \
>>>>>> +    module_param(name, charp, 0444)
>>>>>>  # define compat_module_byte_param_array(name, count) \
>>>>>>      module_param_array(name, byte, NULL, 0444)
>>>>>>  # define compat_module_short_param_array(name, count) \
>>>>> No need, module_param comes even with 2.4. We only need wrapping for
>>>>> parameter arrays (due to different semantics of the macro arguments).
>>>> But with limitations, unfortunately:
>>>>
>>>>   /* type is byte, short, ushort, int, uint, long, ulong, bool. (2.6
>>>>      has more, but they are not supported).  perm is permissions when
>>>>      it appears in sysfs: 0 means doens't appear, 0444 means read-only
>>>>      by everyone, 0644 means changable dynamically by root, etc.  name
>>>>      must be in scope (unlike MODULE_PARM).
>>>>   */
>>>>   #define module_param(name, type, perm) \
>>>>         static inline void *__check_existence_##name(void) { return
>>>>              &name; } \
>>>>         MODULE_PARM(name, _MODULE_PARM_STRING_ ## type)
>>>>
>>>>   #define _MODULE_PARM_STRING_byte "b"
>>>>   #define _MODULE_PARM_STRING_short "h"
>>>>   #define _MODULE_PARM_STRING_ushort "h"
>>>>   #define _MODULE_PARM_STRING_int "i"
>>>>   #define _MODULE_PARM_STRING_uint "i"
>>>>   #define _MODULE_PARM_STRING_long "l"
>>>>   #define _MODULE_PARM_STRING_ulong "l"
>>>>   #define _MODULE_PARM_STRING_bool "i"
>>>>
>>>> Especially "s" is missing. But it could be wrapped with:
>>>>
>>>>   #define _MODULE_PARM_STRING_charp "s"
>>>>
>>>> Any idea why this is not already done?
>>> Likely because you mostly don't need it? I think mscan is an exception
>>> here, at least from my experience.
>> Well, a "find . -name '*.c'|xargs grep charp|grep module" reveals plenty
>> of references. And in 2.6 there is "module_param_string* as well, which
>> will copy the string directly into the preallocated array.
>>
>>> When _MODULE_PARM_STRING_charp helps to enhance module_param on 2.4,
>>> lets put it in Xenomai's wrapping header. I think we should also move
>>> the parameter array over (directing it officially through the RTDM layer
>>> can still be done later, at the latest when providing user-space
>>> support). I would support a patch doing this as well.
>> With the proposed modifications almost all module parameter use cases
>> can be handled in a portable way, including strings and arrays of
>> strings. I have moved it to the Xenomai's wrapping header file,
>> including compat_module_param_array ...
>>
>>>> I also want to replace the compat_module_*_param_array functions with
>>>> the attached code snippet.
>>> Ok, I'm awaiting a revised patch.
>> ... and updated the ISA and MEM driver as well in the attached revised
>> patch.
> 
> Thanks, applied.
> 
> Jan
> 
> 
> PS: I fixed a few (not all) trailing whitespaces. Maybe you can
> configure your editor to highlight them. Once we have Lindent'ed the CAN
> stack, this will become relevant anyway.

Ah, oh, sorry, thanks. My editor now shows trailing white space in _red_.

Wolfgang.



