Message-ID: <438C63F3.7040502@domain.hid>
Date: Tue, 29 Nov 2005 15:21:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Latest snapshot (182) not compiling (kernel)
References: <438743FC.6070007@domain.hid>	<ae7121c60511280857l26c080b7g299c6cae93a8afed@domain.hid>	<ae7121c60511280858g7d25f4d9y28de0688053ad51d@domain.hid>	<438B3990.4020809@domain.hid>
	<ae7121c60511280922l2c885116m419ffc17d2b61b04@domain.hid>
In-Reply-To: <ae7121c60511280922l2c885116m419ffc17d2b61b04@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Panagiotis Issaris <panagiotis@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Panagiotis Issaris wrote:
> Hi Jan,
> 
> On 11/28/05, *Jan Kiszka* <kiszka@domain.hid 
> <mailto:kiszka@domain.hid>> wrote:
> 
>     ...
>      > reference to `__raw_read_unlock'
>      > kernel/built-in.o: In function `schedule_event':
>      > /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152:
>     undefined
>      > reference to `__raw_read_lock'
>      > /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158:
>     undefined
>      > reference to `__raw_read_unlock'
>      > make[1]: *** [.tmp_vmlinux1] Error 1
>      > make: *** [_all] Error 2
>      >
> 

ipipe-2.6.14-1.0-11 for x86 and ipipe-2.6.14-1.0-07 for ppc fix this.
Those patches are available from the Xenomai trunk, or from the Adeos dl 
area as usual.

-- 

Philippe.

