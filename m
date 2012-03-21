Message-ID: <4F69EEAE.9000006@domain.hid>
Date: Wed, 21 Mar 2012 16:07:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CB8F60DA.1EE9B%glen@domain.hid>
In-Reply-To: <CB8F60DA.1EE9B%glen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/21/2012 03:41 PM, Glen Wernersbach wrote:
> Hi guys,
>
> One thing about both of these drivers is they have been modified to set some
> GPIO pins.
>
> The come down to the pca9539_gpio_set_value() in this file.
>
> Do you see any reason why those would not take under Xenomai?

If these are input GPIOs to deliver IRQs, yes, in which case this might 
be a problem with the interrupt pipeline; as Gilles told you already, 
1.13 is fairly outdated.

But in that case, you should see the problem even with CONFIG_XENOMAI* 
fully disabled, provided CONFIG_IPIPE is still on.

If you don't, meaning that something in the Xenomai core does make a 
difference, then you could try disabling all Xenomai interfaces (i.e. 
CONFIG_XENO_OPEN_SKIN_RTDM, .._NATIVE, .._POSIX, etc.), only leaving the 
core enabled.

>
> Glen
>
>
> On 3/21/12 4:38 AM, "Philippe Gerum"<rpm@xenomai.org>  wrote:
>
>> On 03/21/2012 05:46 AM, Glen Wernersbach wrote:
>>> I am going to start trying to see if I can figure out what is not getting
>>> set.
>>>
>>
>> You could get useful information from the pipeline tracer, by enabling
>> CONFIG_IPIPE_TRACE, observing what exactly happens in kernel space from
>> the issuing of the ioctl() syscall until the the read() syscall on the
>> serial link.
>>
>> You could set markers using Xenomai's I-pipe trace API in userland to
>> highlight portions of interest in your app code, freezing the capture to
>> snapshot a particular moment in the execution timeline. See
>> http://xenomai.org/index.php/I-pipe:Tracer.
>>
>> NOTE: pay attention to the value in /proc/ipipe/trace/back_trace_points
>> to hold enough data.
>>
>>> By the way. This board also has 4 other serial ports on a 8250.c driver. It
>>> also fails under the xeno build.
>>>
>>>
>>>
>>>
>>> On 3/20/12 4:35 PM, "Gilles Chanteperdrix"
>>> <gilles.chanteperdrix@xenomai.org>   wrote:
>>>
>>>> On 03/20/2012 09:19 PM, Glen Wernersbach wrote:
>>>>> I actually think in is in the settings because if run just the setup part
>>>>> of
>>>>> the code without reading and writing, on the kernel that works my activity
>>>>> LED turns off.
>>>>>
>>>>> On the xeno kernel the LED never changes.
>>>>
>>>> I actually think that CONFIG_XENO_OPT_PERVASIVE does not make any
>>>> difference which could cause a difference of hardware behaviour. So, it
>>>> must be another option triggered by this config change. So, if you want
>>>> us to help you, please post the .configs.
>>>>
>>>
>>
>


-- 
Philippe.

