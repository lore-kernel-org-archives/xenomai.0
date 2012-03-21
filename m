References: <CB8F60DA.1EE9B%glen@domain.hid> <4F69EEAE.9000006@domain.hid>
In-Reply-To: <4F69EEAE.9000006@domain.hid>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <0366870A-00FB-49CE-954E-05607D33D44E@jetsoftdev.com>
Content-Transfer-Encoding: quoted-printable
From: Glen Wernersbach <glen@domain.hid>
Date: Wed, 21 Mar 2012 12:53:33 -0400
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I did disable everything except pervasive and the problem happened.

I disabled pervasive also, it went away.


I can try turning pervasive off and ipipe on and see what happens.
--
Glen Wernersbach
President & CTO
Jetsoft Development Co
629 Old St. Rt. 74 - Suite 210
Cincinnati Ohio 45244
Custom Programming Web Site: www.JetsoftDev.com
Retail Product Web Site: www.ScanHelp.com
Phone: 513-528-6660
Fax: 513-528-3470

On Mar 21, 2012, at 11:07 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/21/2012 03:41 PM, Glen Wernersbach wrote:
>> Hi guys,
>>=20
>> One thing about both of these drivers is they have been modified to set s=
ome
>> GPIO pins.
>>=20
>> The come down to the pca9539_gpio_set_value() in this file.
>>=20
>> Do you see any reason why those would not take under Xenomai?
>=20
> If these are input GPIOs to deliver IRQs, yes, in which case this might be=
 a problem with the interrupt pipeline; as Gilles told you already, 1.13 is f=
airly outdated.
>=20
> But in that case, you should see the problem even with CONFIG_XENOMAI* ful=
ly disabled, provided CONFIG_IPIPE is still on.
>=20
> If you don't, meaning that something in the Xenomai core does make a diffe=
rence, then you could try disabling all Xenomai interfaces (i.e. CONFIG_XENO=
_OPEN_SKIN_RTDM, .._NATIVE, .._POSIX, etc.), only leaving the core enabled.
>=20
>>=20
>> Glen
>>=20
>>=20
>> On 3/21/12 4:38 AM, "Philippe Gerum"<rpm@xenomai.org>  wrote:
>>=20
>>> On 03/21/2012 05:46 AM, Glen Wernersbach wrote:
>>>> I am going to start trying to see if I can figure out what is not getti=
ng
>>>> set.
>>>>=20
>>>=20
>>> You could get useful information from the pipeline tracer, by enabling
>>> CONFIG_IPIPE_TRACE, observing what exactly happens in kernel space from
>>> the issuing of the ioctl() syscall until the the read() syscall on the
>>> serial link.
>>>=20
>>> You could set markers using Xenomai's I-pipe trace API in userland to
>>> highlight portions of interest in your app code, freezing the capture to=

>>> snapshot a particular moment in the execution timeline. See
>>> http://xenomai.org/index.php/I-pipe:Tracer.
>>>=20
>>> NOTE: pay attention to the value in /proc/ipipe/trace/back_trace_points
>>> to hold enough data.
>>>=20
>>>> By the way. This board also has 4 other serial ports on a 8250.c driver=
. It
>>>> also fails under the xeno build.
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> On 3/20/12 4:35 PM, "Gilles Chanteperdrix"
>>>> <gilles.chanteperdrix@xenomai.org>   wrote:
>>>>=20
>>>>> On 03/20/2012 09:19 PM, Glen Wernersbach wrote:
>>>>>> I actually think in is in the settings because if run just the setup p=
art
>>>>>> of
>>>>>> the code without reading and writing, on the kernel that works my act=
ivity
>>>>>> LED turns off.
>>>>>>=20
>>>>>> On the xeno kernel the LED never changes.
>>>>>=20
>>>>> I actually think that CONFIG_XENO_OPT_PERVASIVE does not make any
>>>>> difference which could cause a difference of hardware behaviour. So, i=
t
>>>>> must be another option triggered by this config change. So, if you wan=
t
>>>>> us to help you, please post the .configs.
>>>>>=20
>>>>=20
>>>=20
>>=20
>=20
>=20
> --=20
> Philippe.
>=20



