From: Zafar Iqbal <Zafar.Iqbal2@domain.hid>
Date: Wed, 15 Sep 2010 15:42:35 +0530
Message-ID: <76E258664B189C4CBEF125491CA11ECC945B6553D6@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>,
	<1284478817.2345.5.camel@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC945B6553D5@domain.hid>,
	<4C9092BE.4050206@domain.hid>
In-Reply-To: <4C9092BE.4050206@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or
 CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for your mail Stefan.

Can you please suggest me what are the kernel option and how can I disable =
them.


Thanks and regards,
Zafar
________________________________________
From: Stefan Kisdaroczi [kisda@domain.hid]
Sent: Wednesday, September 15, 2010 3:02 PM
To: Zafar Iqbal
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or CONFIG_XENO_OPT_PE=
RVASIVE disabled

Hi,

On 15.09.2010 10:46, Zafar Iqbal wrote:
> Thanks for your mail Sir,
>
> I have a doubt over here That My Kernel is not getting patched correctly.=

>
It looks correctly patched.
> As per the Suggestion of ED Hoffman.
>
> I went to the Real-time-Subsystem  after invoking the make menuconfig. bu=
t I did not get any option over there.
>

Some standard kernel options cause troubles with a realtime kernel, so
you need to disable them to be able to activate the realtime subsystem.

The problematic options are listed on your 2nd screenshot. If you have
disabled them, go back to the "real-time subsystem"-menu and instead of
the warning you should see the realtime options.

Regards Stefan

> I am attaching the snapshots taken by me after selecting the  Real-time-S=
ubsystem.
> Kindly review it and please suggest is it ok,  unless what has to be done=
.
>
>
> Thanks and Regards,
> Zafar
> ________________________________________
> From: Edward Hoffman [quantalgo@domain.hid]
> Sent: Tuesday, September 14, 2010 9:10 PM
> To: Zafar Iqbal
> Cc: Xenomai-help@domain.hid
> Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or CONFIG_XENO_OPT_=
PERVASIVE disabled
>
> Zafar,
>
> Rebuild the kernel after selecting support for pervasive:
>
> Real-time subsystem --->
>      [*]Pervasive real-time support in user space
>
> Regards,
>
> Ed
>
>
>
> On Tue, 2010-09-14 at 16:45 +0530, Zafar Iqbal wrote:
>
>> Dear Sir,
>>
>>
>> I Installed the Xenomai Successfully in MY System with Ubuntu 10.04.
>> Operationg System: Ubuntu 10.4
>> Xenomai Version: 2.5.4.
>> refrence for the installation: http://www.xenomai.org/index.php/Building=
_Debian_packages
>>
>>
>>
>> later I compiled the example code provided in the xenomai folder and i g=
ot compiled sucessfully but while running the executable I am getting the f=
ollowing different error:
>>
>> for POSIX Code:
>> root@domain.hid# ./satch
>> Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>> (modprobe xeno_posix?)
>>
>> for native code
>>
>> root@domain.hid# ./rtprint
>> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>> (modprobe xeno_native?)
>> root@domain.hid#
>>
>>
>> Please Suggest Me whats wrong here in the above code.
>>
>> Thanks and Regards
>> Zafar
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



