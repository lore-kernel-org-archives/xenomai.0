Resent-Message-ID: <17232.58645.769350.642883@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17232.57953.551450.669843@domain.hid>
In-Reply-To: <34086.193.52.24.125.1129373726.squirrel@domain.hid>
References: <34086.193.52.24.125.1129373726.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] XenoPPC :-> 2.6.13.4-ipipe :)
Date: Sat, 15 Oct 2005 13:05:05 +0200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid

smannori@domain.hid wrote:
 > Max latency = 44 us
 > Overrun = zero nil nada zip.

You should not conclude to rapidly. Running the dohell script for ten
hours would make me a bit more confident about your results.


 > I think that the save/restore functions of xenomai must be aware of the
 > presence of Altivec. If I disable Altivec the X11 server (x.org) shipped
 > with mandriva ppc does not start.

It is true that the save/restore functions of xenomai should be
altivec-aware, but you likely have another problem: if it was the only
one, Xenomai would work flawlessly when CONFIG_ALTIVEC (and CONFIG_SPE,
for that matter) are disabled in kernel configuration.


 > This is a very good impruvement. If you use thread in the user space, the
 > FPU support is not a must.

Well, disabling FPU support in Xenomai configuration means that you can
use FPU neither in kernel space, nor for user-space threads in primary
mode without causing a transition to secondary mode. This is too
restrictive.


-- 


					    Gilles Chanteperdrix.

