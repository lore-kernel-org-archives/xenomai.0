From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D46D139.9090209@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
	<4D46CB77.5000004@domain.hid> <1296486423.2214.58.camel@domain.hid>
	<4D46D139.9090209@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 16:17:55 +0100
Message-ID: <1296487075.2214.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CONFIG_XENO_OPT_SELECT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2011-01-31 at 16:11 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > The caller should lose its RPI boost as soon as the regular select()
> > syscall blocks it though - and I assume it does, so we do have a bug in
> > 2.4.9 here (although I'm pretty sure it has been fixed in later
> > releases). Having a shadow stuck in 'R'unnable mode
> > in /proc/xenomai/sched is a good sign that something is broken deep
> > inside.
> 
> The issue may be that the syscall caused the switch to primary mode,
> then the libc select is looping without syscall for whatever reason?
> Also, maybe testing 2.4.10 is worth a shot.
> 

What bothers me, is that we should not even be able to
read /proc/xenomai/sched from an unrelated shell, in case we had a
runaway primary or even secondary SCHED_FIFO task. (IIRC, Roderik is
running Xenomai over a single core ppc board, mpc52xx/icecube).

-- 
Philippe.



