Message-ID: <4BFD4AD4.7020804@domain.hid>
Date: Wed, 26 May 2010 18:22:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilzHg1IAyyLDpri8k8jI1hRooOwdehF8259xoAL@mail.gmail.com>	<4BFD3F44.5000708@domain.hid>	<AANLkTik4hSCdh03zRoiqLGfaF3RftwzhuWz-Qbfo7BDv@domain.hid>	<4BFD400F.1080307@domain.hid>
	<AANLkTinCDHMi5TrYiyzCAkElG1N57f2tOTtcY8yEX6Y5@domain.hid>
In-Reply-To: <AANLkTinCDHMi5TrYiyzCAkElG1N57f2tOTtcY8yEX6Y5@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam() segfault using Xenomai
 2.5.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Stephen Bryant wrote:
> On 26 May 2010 16:36, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     Stephen Bryant wrote:
>     > Already compiling the kernel, but the results may have to wait until
>     > tomorrow,
> 
>     If it is the bug I am thinking it is, then you do not need to recompile
>     the kernel, recompiling user-space support should be enough.
> 
> 
>     --
>                                                Gilles.
> 
> 
> Using Xenomai 2.5.3 has resolved the problem - and you were right that I
> did not need to recompile the kernel, just the user-space support.  I'm
> guessing this is the 'posix wrappers: avoid undefined reference with
> uclibc' mentioned in the announcement?

It should be:
http://git.xenomai.org/?p=xenomai-2.5.git;a=blobdiff;f=src/skins/common/bind.c;h=d511072c9a0d5b9ccac30b030e0e0266114174a4;hp=352c4e80de5b66442f86820a183d599234951b4e;hb=428aa42410efe575f7bb9729447e6dc49159ef5e;hpb=4dc4361cef9025d125a7a28e5ca02d82c6854345

-- 
					    Gilles.

