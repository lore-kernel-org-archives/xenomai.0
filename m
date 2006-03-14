Message-ID: <4416888E.1010608@domain.hid>
Date: Tue, 14 Mar 2006 10:10:38 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user mode vs. kernel module
References: <44113E39.1010902@domain.hid> <44140395.7090702@domain.hid>
In-Reply-To: <44140395.7090702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum escribi=F3:
> Ignacio Garc=EDa P=E9rez wrote:
>> Hi,
>>
>> So far I've had my application implemented entirely as a kernel=20
>> module with some user mode helper programs. I've had in mind changing=20
>> to user mode but never felt compelled enough.
>>
>> Now, having a new requirement to implement, I think it's the moment=20
>> to give it a try, and I'm porting it. I have a couple of questions:
>>
>> 1- How significative, in real world terms, is the overhead involved=20
>> in operaing in user mode?. As far as I know all operations are=20
>> executed via "pods" which involve one or more system calls and=20
>> context switches. I'm using a Geode board right now but there are=20
>> plans to move to a more low-end platform (486).
>>
>> 2- ioperm. This is a true headache. I've spent countless hours=20
>> debugging this and banging my head agaist the wall. I'm not 100% sure=20
>> of what's going on here, but it looks like the ioperm call must be=20
>> issued from primary mode if you are doing the I/O from primary mode.=20
>> Something like this would segfault:
>>
>> ioperm(0x443, 0x01, 1);
>> rt_mutex_lock(...)
>> outb(0x01, 0x443)
>>
>> While this works fine:
>>
>> rt_mutex_lock(...)
>> ioperm(0x443, 0x01, 1);
>> outb(0x01, 0x443);
>>
>> While leads me to think that the rt_mutex_lock puts the task in=20
>> primary mode and then both ioperm and outb are executed in the same=20
>> mode so everything works.
>>
>> Is this right?
>
> No.
>
> . If so, I find this extremely inconvenient...
>>
>
> Fixed in the repository. Use iopl(3) as a work-around, or resync.
Whoa. Now that's a quick fix. I'll go for the cutting edge svn version,=20
though as pointed out in another message, I must anyway use iopl to=20
access ports above 0x3FF.

Thank you.

Nacho.


