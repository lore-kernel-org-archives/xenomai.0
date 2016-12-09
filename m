References: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
 <e1c90d44-be0d-91a7-98d4-e06ee0007ab1@xenomai.org>
 <340fed26-23db-86a4-faf5-4e58c15504cd@numalliance.com>
 <20161208084239.3f0c064b@md1em3qc>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <2af94483-4d8f-dbcf-0711-d2408d0802ef@numalliance.com>
Date: Fri, 9 Dec 2016 16:28:29 +0100
MIME-Version: 1.0
In-Reply-To: <20161208084239.3f0c064b@md1em3qc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 08/12/2016 =C3=A0 08:42, Henning Schild a =C3=A9crit :
> Am Thu, 8 Dec 2016 08:28:02 +0100
> schrieb St=C3=A9phane Ancelot <sancelot@numalliance.com>:
>
>> Le 07/12/2016 =C3=A0 17:16, Philippe Gerum a =C3=A9crit :
>>> On 12/07/2016 03:15 PM, St=C3=A9phane Ancelot wrote:
>>>> Hi,
>>>>
>>>> I noticed very bad memory allocation performance on some of my
>>>> graphic programs (standard linux applications).
>>>>
>>>> If you run any classic program, you won't sea any difference, but
>>>> it has been visible in the following context :
>>>>
>>>> I have an application that allocates thousends of graphic widgets,
>>>> label, input fields  at startup (a data editor) .
>>>>
>>>> Using the standard kernel, the applications starts very quickly.
>>>> But once the ipipe patch is applied to kernel, this application
>>>> makes lot of seconds before appearing.
>>>>
>>>> I am using a 3.18 kernel.
>>>>  =20
>>> Is there any question?
>>>  =20
>> Euhhh ... yes,  it sounds this problem comes from ipipe
>> modifications, But I have not managed to find the reason ???
>> Is it a bug , a regression , a kernel routine where the problem is
>> amplified once the patch is applied ?
>>
>> I remember I have not had this problem with previous kernel releases
>> (3.16.x) . I will check again with previous configurations, in order
>> to find a way of comparison.
> You can also try 4.1. And more information could be useful. Which
> version of xenomai are you using? Is your application using xenomai?
> Which architecture are you on?

I checked following things :

I have problem  with any kernel on this architecture patched with xenomai=
.

I tried kernel 3.16.7,3.18.20 and 4.1.18.
this happens in 32 bit or 64 bit, both SMP kernel

I made 2 traces to open with kernelshark (please advice if it is a=20
problem). you have to filter task : chg_cst

this one is when the problem is happening using the computer display.

https://drive.google.com/open?id=3D0B1JEDrsMi1E1YkZja1dsWTFRcDQ

and this one is when it runs fine through a ssh -X session.
https://drive.google.com/open?id=3D0B1JEDrsMi1E1WUVyOUFEbFdzWkk

comparing both tasks  diagram , I can sea that when it does not work,=20
the task is interrupted for a long time.
in other case, no interruption in it's activity diagram.


Regards,
S.Ancelot



>> Regards,
>> S.Ancelot
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

