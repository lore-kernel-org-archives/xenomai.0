Message-ID: <2786.81.252.86.91.1206522879.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0803251037y3c0d8735he1fc82895c349c3c@domain.hid>
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid> 
	<18400.53752.538963.384358@domain.hid> 
	<6621.81.252.86.91.1205927700.squirrel@domain.hid> 
	<2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid> 
	<10023.62.39.72.60.1205940829.squirrel@domain.hid> 
	<18407.43111.568301.509775@domain.hid> 
	<18407.58512.849738.173184@domain.hid> 
	<18408.10253.285795.914555@domain.hid> 
	<3551.81.252.86.91.1206464698.squirrel@domain.hid>
	<2ff1a98a0803251037y3c0d8735he1fc82895c349c3c@domain.hid>
Date: Wed, 26 Mar 2008 10:14:39 +0100 (CET)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Application crash
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

>> Result in Xenomai environment(Xenomai 2.3.4 kernel) :
>> ___ # ./test
>> T2 : 0
>> T2 : 1
>> T2 : 2
>> T2 : 3
>> T2 : 4
>> T2 : 5
>> T2 : 6
>> T2 : 7
>> T2 : 8
>> T2 : 9

> I have tested with Xenomai trunk and version 2.4.2 (same version as
> you). What do you mean by crash anyway ? Box lockup, application dying
> ? Is there no message on the console ? Did you try running your
> application inside gdb ?
>

Hello,

In my opinion, crash means that my application is frozen. On my console, =
I
ve got the T2 traces and when T1 must display its trace, my application
freezes.
As I use Xenomai threads with the highest priority, I cannot stop my
application with CTRL+C or a call to kill with my other console (Ethernet
-- ssh). I just can reset my ETX module.

I tried with gdb. If I didn't put breakpoints, my application froze. With
breakpoints, I hadn't got the crash but the thread behaviour is totally
different.

>
> If you suspect your xenomai environment, the best thing to do is to
> remove any trace of Xenomai on your test box, and recompile Xenomai
> from scratch, using the same version of Xenomai tarball for
> kernel-space support and user-space support.
>

I m going to try this.

thanks


