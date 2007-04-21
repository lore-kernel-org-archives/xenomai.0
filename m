Message-ID: <462A7220.2020200@domain.hid>
Date: Sat, 21 Apr 2007 22:20:48 +0200
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] version of __ipipe_restore_pipeline_head
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jean-Luc Pamart a =E9crit :
> Gilles Chanteperdrix a =E9crit :
>> Jean-Luc Pamart wrote:
>> =20
>>> (...)
>>> realtimedriver: disagrees about version of symbol=20
>>> __ipipe_restore_pipeline_head
>>> realtimedriver: Unknown symbol __ipipe_restore_pipeline_head
>>>
>>> My configuration :
>>> xeno 2.3
>>> hal 1.6-03
>>>    =20
>>
>> I hope you mean Adeos I-pipe 1.7-03, right ?
>>
>>  =20
>
> Well, not :-(   !
> I use the Adeos I-pipe 1.6-03 which is embedded with the xeno=20
> distribution ...
> So, I decided to pass to linux 2.6.20 and Adeos I-pipe 1.7-03
> but after problems of compilation (My linux box is a 2.4 kernel one=20
> apparently there is a binutils issue with the 2.4 kernel) I have tried=20
> 2.6.19 and  Adeos I-pipe 1.7-03.
>
> =20
>>> My linux version is 2.6.19
>>>
>>>
>>> We have __ipipe_restore_pipeline_head symbol in
>>> the kernel :
>>>
>>> c013f7b0 T __ipipe_restore_pipeline_head
>>> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_native]
>>> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_nucleus]
>>> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_rtdm]
>>> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_posix]
>>>
>>> but the module realtimedriver I want to insmod has
>>> been builded with the same sources.
>>>
>>>
>>> So what may I do ?
>>>    =20
>>
>> You likely changed a kernel option and recompiled the kernel without
>> recompiling the "realtimedriver" module. Try recompiling the module.
>>  =20
>
> Ok, I have change to 2.6.19 - Adeos I-pipe 1.7-03. After 2 days of
> building my emdedded distribution : all right !
> The realtimedriver can be load and user can be run.
>
> Nevertheless I have a slight but strange problem :
> When trying the user program with Timer int (#0)
> it says "cannot open demodev0"
> But when I change only inc.h like this :
> #define TIMER_INT       14 // for the hard disk
> or
> #define TIMER_INT       11 // for the net board
> it's ok : I have WRITE, READ etc. accordingly with
> the amount of work of the devices.
>
> I have a 100 Hz timer int.
> Perhaps too fast for the realtimedriver ???
> A idea ?
>
>
>
>
>



