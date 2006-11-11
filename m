Subject: Re: [Xenomai-core] x86 FPU switches routines.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <453C7C48.30602@domain.hid>
References: <453C7C48.30602@domain.hid>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 23:40:07 +0100
Message-Id: <1163284808.5765.324.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Mon, 2006-10-23 at 10:24 +0200, Gilles Chanteperdrix wrote:
> Hi,
> 
> As once discussed with Heikki, and after a first missed attempt, here
> is a patch for x86 which attempts to cope correctly with Linux (non
> real-time) drivers using FPU in kernel-space.
> 
> I tested it on my laptop without drivers using FPU, and it appears to
> work correctly, but it would be nice if people that had problems with
> the previous attempt (if I remember correctly, on old pentiums and on
> AMD processors) could test this patch.
> 

Ok, nobody has complained so far, it works for me too on a few test
boxen, so I'm going to merge this patch for 2.3-rc2.

So please everybody, let's give this hell _now_ on as many x86 boxen as
we can, checking out the trunk, so that we won't reiterate the 2.2.3
mess.

-- 
Philippe.



