Message-ID: <45ADE724.3010800@domain.hid>
Date: Wed, 17 Jan 2007 10:06:44 +0100
From: Matthias Fechner <idefix@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel on FC6
	x86_64?
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
In-Reply-To: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi Eric,

Eric Noulard schrieb:
> So here is my question:
> 
> Is it possible to run/boot a 32bit xenomai on a 64 bit system
> or should I really need to install a 32bit only system on my 64 bit
> machine?
> If yes how to do this properly?
> If no
>   - is there a planned support for 64bit in xenomai/adeos?
>   - what should I do to use Xenomai on my 64 bit machine?

I had exactly the same problem and I installed a second 32-bit Linux on
my harddisk and easily linked some dirs from my old 64-bit installation
to save space (e.g. /usr/src, /usr/local).

That worked great.

But the best is a Xenomai which supports 64-bit AMD processors :)

Bye
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook

