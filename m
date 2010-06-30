From: "Sydir, Jerry" <jerry.sydir@domain.hid>
Date: Tue, 29 Jun 2010 17:02:01 -0700
Message-ID: <8EA2C2C4116BF44AB370468FBF85A777016581609F@orsmsx504.amr.corp.intel.com>
References: <8EA2C2C4116BF44AB370468FBF85A777016574B413@domain.hid>
	<4C2A078E.80009@domain.hid>
	<8EA2C2C4116BF44AB370468FBF85A7770165815E06@domain.hid>
	<4C2A74C0.2000909@domain.hid>
In-Reply-To: <4C2A74C0.2000909@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] machine hangs running oprofile on xenomai kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "jan.kiszka@domain.hid" <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



Jan Kiszka wrote:

>[please do not top-post]
>
>Sydir, Jerry wrote:
>> Hi Jan,
>>
>> Thanks for your reply. I tried loading the oprofile module with timer=3D=
1
>and oprofile seems to work (doesn't hang the system and spits out some
>results). So it appears that the use of NMIs are the problem. Do you have
>any suggestions on what to try next?
>
>
>Now someone would have to dig into the code path taken by oprofile
>during NMI handling to find the reason for the lock-up. Did you have any
>real-time jobs running when starting the profiling, or was Xenomai idle?
>
>On the other hand, oprofile is a legacy interface. It probably makes
>more sense to try and, if required, fix perf instead.
>
>Jan

I was not running any real-time jobs, so Xenomai was idle.=20

I just tried running perf on a non-real time command and the system hung in=
 the same way as with oprofile. Here is command that I tried:
perf -e cycles -c 400000 find / jerry*


Jerry Sydir

