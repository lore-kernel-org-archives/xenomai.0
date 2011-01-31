Message-ID: <4D46D139.9090209@domain.hid>
Date: Mon, 31 Jan 2011 16:11:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>	
	<4D46CB77.5000004@domain.hid> <1296486423.2214.58.camel@domain.hid>
In-Reply-To: <1296486423.2214.58.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> The caller should lose its RPI boost as soon as the regular select()
> syscall blocks it though - and I assume it does, so we do have a bug in
> 2.4.9 here (although I'm pretty sure it has been fixed in later
> releases). Having a shadow stuck in 'R'unnable mode
> in /proc/xenomai/sched is a good sign that something is broken deep
> inside.

The issue may be that the syscall caused the switch to primary mode,
then the libc select is looping without syscall for whatever reason?
Also, maybe testing 2.4.10 is worth a shot.

-- 
					    Gilles.

