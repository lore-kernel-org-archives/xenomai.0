Message-ID: <49CBF91A.1070201@domain.hid>
Date: Thu, 26 Mar 2009 22:52:26 +0100
From: Antoine Nourry <nourry@domain.hid>
MIME-Version: 1.0
References: <49CBB6C5.5000407@domain.hid> <49CBBD4B.7070800@domain.hid>
	<49CBEDE2.5040106@domain.hid> <49CBF29D.5020500@domain.hid>
In-Reply-To: <49CBF29D.5020500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Keyboard IRQ
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix a =E9crit :
> Antoine Nourry wrote:
>  =20
>> Sorry for my blurred question, i just wanted to point out the fact tha=
t=20
>> i managed to use most of Xenomai API functionalities when i was workin=
g=20
>> on an RTDM USB driver. However during my scattered tests i never manag=
ed=20
>> to catch properly IRQ 1 (i use a standard keyboard here). The goal is =
to=20
>> measure time reaction from the moment an image appears to the keypress=
=20
>> event.  Several months ago i asked you how to achieve this and wasn't=20
>> aware at all of the domain switching when calling non realtime functio=
ns=20
>> while being in RT mode. Thus i mixed non realtime and realtime functio=
ns=20
>> in the same realtime task... and among them there were different=20
>> keyboard event catch functions whichever are all non RT. I want a=20
>> deterministic program that could rely on Xenomai source clock and on i=
ts=20
>> IRQ handling in order to know when to take the measure.
>>
>> I first want to know if this could be a good way to do so or if i'm=20
>> totally wrong.
>>    =20
>
> I think I already told you that, but using Xenomai to do that is
> completely overkill.
>
>  =20
>> Secondly, i just made some new tests from the irq user example and=20
>> rt_intr_wait returns -38 (is it ENOSYS =3D function not implemented ?)=
 Do=20
>> i have to compile some functionality in the kernel or during Xenomai=20
>> install ?
>>    =20
>
> Yes, handling interrupts in user-space with the native and posix skins
> is discouraged. You should be using the RTDM skin. But if you absolutel=
y
> want to use these services, you have to enable them in the kernel
> configuration.
>
>
>  =20
I neither understand, is there a way to measure precisely the absolute=20
time of a keypress event on our computers ?


