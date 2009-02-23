Message-ID: <BAY135-W50A146D755045D42A23F66C6AE0@domain.hid>
From: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Date: Mon, 23 Feb 2009 11:32:37 -0700
In-Reply-To: <49A2D47D.90609@domain.hid>
References: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>
	<49A1DEBE.6020002@domain.hid> <BAY135-W25DA8BBF5E569E370DB25DC6AE0@domain.hid>
	<49A2D47D.90609@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org


Hi=2C

CONFIG_SCHED_SMT is not set.
I manually overwrite CONFIG_X86_HT to n but every time I run make-kpkg it w=
ill overwrite CONFIG_X86_HT to y.

Thomas


----------------------------------------
> Date: Mon=2C 23 Feb 2009 17:53:17 +0100
> From: jan.kiszka@domain.hid
> To: thomas_schaefer_canada@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: rt_task_create with mode T_CPU(1)
>
> Thomas Schaefer wrote:
>>
>> Hi=2C
>>
>> I downloaded kernel 2.6.28.7 and used the xenomai svn revision 4639.
>> BTW. I can't update my svn repository i get "svn: Can't find a temporary=
 directory: Internal error".
>> According to Google this means that your svn server is out of disk space=
.
>>
>> After running the new kernel and running ./latency -c1 it hangs after "w=
arming up...".
>> After ctrl+c I get:
>>
>> ^C---|------------|------------|------------|--------|------------------=
-------
>> RTS| 4699.016| 0.000| -4699.016| 0| 00:11:21/00:11:21
>>
>> and it still hangs. Except for this windows the system stays responsive.
>>
>> Revision 4595 seems to work as expected.
>>
>> I tried booting the kernel with maxcpus=3D2 but it yields the same resul=
t.
>>
>> I am running debian lenny on a quad core xeon with 3GB ram.
>> The Kernel is compiled for 64bit.
>> I attached the kernel config file.
>
> You've got CONFIG_X86_HT enabled. In case your CPU actually supports
> this feature=2C please try to disable it. Latency-wise=2C it's no good id=
ea
> for RT scheduling anyway. I'm not aware of problems related to it=2C but
> it's worth a try (and I couldn't test it ATM due to lacking comparable HW=
).
>
> Jan
>
> --
> Siemens AG=2C Corporate Technology=2C CT SE 2
> Corporate Competence Center Embedded Linux

_________________________________________________________________
How fun is this? IMing with Windows Live Messenger just got better.
http://www.microsoft.com/windows/windowslive/products/messenger.aspx=

