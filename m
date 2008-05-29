Message-ID: <483E6EF8.6090501@domain.hid>
Date: Thu, 29 May 2008 10:53:12 +0200
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <483D0AB7.4010303@domain.hid>
	<2ff1a98a0805280101q4e1cc3d9oe73b3de64316f07b@domain.hid>
In-Reply-To: <2ff1a98a0805280101q4e1cc3d9oe73b3de64316f07b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] valgrind
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
Cc: xenomai-help <xenomai@xenomai.org>, valgrind-users@domain.hid



Gilles Chanteperdrix a =E9crit :
> On Wed, May 28, 2008 at 9:33 AM, St=E9phane ANCELOT <sancelot@domain.hid> =
wrote:
>  =20
>> Hi,
>> I tried xenomai integration in valgrind .
>>
>> I have got some problems with __native_muxid  .
>>
>> Is there an easy way to retrieve this value (is it a const?) or is it =
a
>> variable I have to store and reuse ?
>>    =20
>
> The muxid is returned by the "xn_sys_bind" system skin syscall. So,
> you have to get it at run-time.
>
>  =20
OK, but unfortunately, in valgrind, there is a static syscall_table=20
containing all  syscalls numbers.

In order solving this problem, I may setup  a static range of syscalls=20
for xenomai  and route to concerned valgrind syscall  at execution ?
What are the xenomai syscall ranges ?

Best Regards
S.Ancelot




