From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17888.41453.933445.213344@domain.hid>
References: <1170205077.21219.67.camel@domain.hid>
	<1172247508.26738.67.camel@domain.hid>
	<17887.18450.939044.430454@domain.hid>
	<1172312265.2161.7.camel@domain.hid>
	<17888.41453.933445.213344@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 23:46:44 +0100
Message-Id: <1172357204.2161.67.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] Re: Heads up: Xenomai port over
	x86_64 has started
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, 2007-02-24 at 21:37 +0100, Gilles Chanteperdrix wrote:
>  > > 
>  > > Ok, I will do it. Do you have an URL of a datasheet at hand (since the
>  > > x86 code does not work, there must be some difference) ?
>  > 
>  > AFAICS, you still have an i387 to deal with. I would rather suspect an
>  > issue with some revised logic in the regular task switching code.
>  > Sidenote: the Xenomai/x86_64 switch code eliminates the "switch-to-self"
>  > issue we discussed recently for x86, and I noticed this would break our
>  > x86 FPU logic doing so, so maybe there is something to dig here. I'll
>  > check this asap.
> 
> I got switchtest to work on x86 without the "switch-to-self" switch,
> both with and without fxsr, could you try the following patch on 
> x86_64 ?

Eh, that's a strike, thanks. The switchtest now works smoothly with this
patch applied. Added to the fact that I've just fixed the CONFIG_SMP
+CONFIG_PREEMPT issue [1], what remains to get a fully functional
preliminary x86_64 port is to solve the CONFIG_SMP+CONFIG_IPIPE_TRACE,
and we should be done.

>From that point, the rest is about chasing latency spots if any, and
solve still-to-be-raised issues.

[1]
http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.19-x86_64-1.0-03.patch

-- 
Philippe.



