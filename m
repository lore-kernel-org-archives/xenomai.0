MIME-Version: 1.0
In-Reply-To: <4F8B5F57.9040608@domain.hid>
References: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>
	<4F8B4B4E.7000202@domain.hid>
	<CAOiXNkDXL94Y17EghAZAOLh4PFSFfFoJNnEbguLxFY054reUhA@mail.gmail.com>
	<4F8B5DFD.8050502@domain.hid> <4F8B5F57.9040608@domain.hid>
Date: Mon, 16 Apr 2012 08:55:39 +0200
Message-ID: <CAOiXNkC1_rrtmTSit4XYjXqj1RxQFbb9yEko-Mw9-5KRDqw1WQ@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RTDM or native Xenomai API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Thank you very much Gilles for the explanations!
I think I understand the overall picture better now.

Thank you,
Andrey.

On 16 April 2012 01:52, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 04/16/2012 01:47 AM, Gilles Chanteperdrix wrote:
>> On 04/16/2012 12:53 AM, Andrey Nechypurenko wrote:
>>> Hi Gilles,
>>>
>>> Thank you very much for such low-latency reply! :-)
>>>
>>>> RTDM is the API of choice for developing drivers for real-time
>>>> applications using xenomai.
>>>
>>> Please correct me if I just misunderstand something here, but as I
>>> understand, RTDM is an abstraction layer with concrete implementation
>>> using xenomai API. As stated in the referenced paper from Jan Kiszka,
>>> the original reason for introducing this layer was to achieve
>>> portability across different RT solutions for Linux. Since that time,
>>> a lot of considered RT solutions becomes irrelevant. In fact, I would
>>> say, there are only Xenomai and preempt_rt. If this assumption is
>>> true, then I can not see the advantages of the additional layer unless
>>> it is more then just an abstraction layer. Does RTDM API makes certain
>>> tasks easier/better compared to the similar native xenomai API? Just
>>> to give concrete example - what is the advantage of using
>>> rtdm_task_init() vs. rt_task_create or xnintr_init() vs.
>>> rtdm_irq_request()?
>>
>> The native API is designed to write applications, not drivers. The RTDM
>> API is designed to write drivers. Using the native API in user-space is
>> deprecated, the native API is made for user-space.
>
> Using the native API in *kernel-space* is deprecated, the native API is
> made for user-space. Writing applications in kernel-space is not what we
> recommend, as much as writing drivers in user-space.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.

