Message-ID: <4BF18A00.706@domain.hid>
Date: Mon, 17 May 2010 20:25:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
In-Reply-To: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error building userspace: "selected processor
 does	not support `rsc r7, r7, #0'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Brown <jhbrown@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jeremy Brown wrote:
> {standard input}: Assembler messages:
> {standard input}:140: Error: selected processor does not support `rsc
> r7,r7,#0'
> {standard input}:159: Error: selected processor does not support `rsc
> r1,r1,#0'
> make: *** [libxenomai_la-timeconv.lo] Error 1

Ok. Could you try and compile the following piece of code with your
toolchain and show me the disassembly ?

long long foo(long long x)
{
        return -x;
}

-- 
					    Gilles.

