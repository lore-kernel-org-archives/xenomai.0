Message-ID: <4F2026B6.8080008@domain.hid>
Date: Wed, 25 Jan 2012 16:58:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL0cVRD26O9Z+afvp0NGQp3qHaAKk-2Cz+dwygZXcD_30HVyDQ@mail.gmail.com>
In-Reply-To: <CAL0cVRD26O9Z+afvp0NGQp3qHaAKk-2Cz+dwygZXcD_30HVyDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christopher Roberts <adrath@domain.hid>
Cc: xenomai@xenomai.org

On 01/25/2012 04:42 PM, Christopher Roberts wrote:
> I've been trying to build a working kernel with Xenomai librarys for the
> last couple of days, and keep running into snags. Its the first time I've
> ever tried to build a kernel before, though I do have some experience with
> Linux and embedded systems.
> 
> So far, I've tried using a cross toolchchain built using Buildroot 2011.8,
> which I used to make x-loader and u-loader, both of which appear to work,
> then the 2.6.38.8 kernel with xenomai 2.6.0, which seems to compile
> correctly, but on boot up the board halts after unpacking the kernel (both
> front lights stay on and it never tries to actually start up the hardware).
> So next I tried building it on a working Ubunutu 11.10 image running on the
> pandaboard, but I was never able to successfully build the kernel that way.
> 
> Any advice I could get on what I'm doing wrong would be
> greatly appreciated.

I routinely run xenomai on pandaboard with the following kernel
configuration:

http://sisyphus.hd.free.fr/~gilles/config-panda

If it does not work for you, please try disabling CONFIG_XENOMAI and
CONFIG_IPIPE to see if the result boots.

-- 
					    Gilles.

