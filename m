Message-ID: <4911B86C.2040400@domain.hid>
Date: Wed, 05 Nov 2008 16:14:52 +0100
From: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
MIME-Version: 1.0
References: <49119A02.9020407@domain.hid> <49119FE3.9050701@domain.hid>
In-Reply-To: <49119FE3.9050701@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Xenomai-help] rt_intr_create issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix a =E9crit :
> C=E9dric Schaffter wrote:
>  =20
>> Hi List!
>>
>> I'm writing a programm where I need to use interruptions.
>>
>> To create it, I use the function "rt_intr_create(RT_INTR *intr, const=20
>> char *name, unsigned irq, rt_isr_t isr, rt_iack_t iack, int mode)".
>>
>> I included this header : #include <native/intr.h>.
>>
>> When I compile, I get these error messages :
>>
>> *error 'RT_INTR_HANDLED' undeclared
>> error too many arguments to function 'rt_intr_create'.*
>>
>> When I observe the file intr.h, I see there are two rt_intr_create (th=
e=20
>> one with six arguments which I need and an other one with only four).
>>
>> I tried to specifiy four parameters as requested by the other=20
>> *rt_intr_create* and it works, so I don't think there is a problem wit=
h=20
>> my include paths.
>>
>> Does someone already have these issues or can help me?
>>
>> In this file there is an other instruction that I don't understand :
>> "#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGE=
N_CPP)
>>    =20
>
> __KERNEL__ is defined when compiling a kernel-space module;
> __XENO_SIM__ is defined when compiling for xenomai simulator (which is
> probably not your case);
> DOXYGEN_CPP is defined when generating Xenomai documentation with doxyg=
en.
>
>  =20

Thanks Gilles and Sebastian !

Now it's clear.

Best regards,
C=E9dric


