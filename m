From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6BFFB2.8020002@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>
	<4C6BCB51.4010805@domain.hid>
	<1282133876.5255.296.camel@domain.hid>
	<4C6BD403.4030902@domain.hid>
	<1282136147.5255.306.camel@domain.hid>
	<4C6BE297.4060706@domain.hid>
	<1282140262.5255.313.camel@domain.hid>
	<4C6BE9D3.1080907@domain.hid>
	<1282141537.5255.315.camel@domain.hid>
	<4C6BEE9B.1080000@domain.hid>
	<1282144162.5255.325.camel@domain.hid>
	<4C6BF8B1.8080206@domain.hid>
	<1282144563.5255.331.camel@domain.hid>
	<4C6BFFB2.8020002@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 18 Aug 2010 18:30:52 +0200
Message-Id: <1282149052.5255.332.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 17:43 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > On Wed, 2010-08-18 at 17:13 +0200, Gilles Chanteperdrix wrote:
> >> Krzysztof Błaszkowski wrote:
> >>> On Wed, 2010-08-18 at 16:30 +0200, Gilles Chanteperdrix wrote:
> >>>> Krzysztof Błaszkowski wrote:
> >>>>> On Wed, 2010-08-18 at 16:10 +0200, Gilles Chanteperdrix wrote:
> >>>>>> Krzysztof Błaszkowski wrote:
> >>>>>>> yes. i downloaded this config a while ago. need to setup new kernel
> >>>>>>> 2.6.31.1 with xenomai. 
> >>>>>>> is 2.5.4 suitable for this test ? 
> >>>>>>> should i also use adeos-*.31.1-*2.4-09 patch ?
> >>>>>> See the versions I posted in my test report yesterday. They were made
> >>>>>> with this configuration.
> >>>>>>
> >>>>> ok. kernel 2.6.31.8, 2.5.4, ht will be enabled,
> >>>>>
> >>>>> for xenomai's configure i will pass following switches:
> >>>>> --enable-x86-sep --enable-x86-tsc --enable-smp
> >>>>>
> >>>>> is this okay ?
> >>>> Yes.
> >>>>
> >>> bingo !
> >>>
> >>> atest:~/xeno-test-254-2 # ./.try.sh 
> >>> main:79 heap 0x401b1000
> >>> /root/xeno-test-254-2
> >>> main:96 [823] pid 825
> >>> main:89
> >>> main:90 [825] pid 0
> >>> main:99 [823] pid 825, status 00000b00
> >>> main:100 [823] pid 825, WIFSIGNALED 0, WIFEXITED 1, rc 11
> >>> 0
> >>> atest:~/xeno-test-254-2 # uname -a
> >>> Linux atest 2.6.31.8-xeno254-smp-ht #1 SMP Wed Aug 18 17:04:00 CEST 2010
> >>> i686 i686 i386 GNU/Linux
> >>>
> >>>
> >>> my fork() test works now with kernel configured with your config.
> >>>
> >>> so this try proves no doubt that userland (libc, pthreads and so on)
> >>> work.
> >>>
> >>> and i guess that this memory corruption which caused fork to die inside
> >>> libc can be something specific to UP configuration. (i was thinking
> >>> about using my config with smp this time)
> >>>
> >>> Thank you for sending me kernel configuration which pointed out an area
> >>> which should be searched further.
> >> Yes, now if you find the culprit option, it would be nice to report here
> >> so that we can fix the I-pipe patch.
> >>
> > 
> > okay. will try to dig up.
> 
> As a first quick test, could you try and disable CONFIG_AUDITSYSCALL ?

okay. i have tried so far smp + ht but it didn't change anything.


> 


-- 
Krzysztof Blaszkowski


