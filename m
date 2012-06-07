Message-ID: <4FD0646C.208@xenomai.org>
Date: Thu, 07 Jun 2012 10:21:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com>	<4FBB4951.5070803@xenomai.org>	<4FBC0383.3020608@bbn.com>	<4FBC0582.2060707@xenomai.org>	<4FBF4E69.1010200@bbn.com>	<4FBF78FE.3020300@xenomai.org>
	<CAMak2D8rWO6zbJhawMr43vg4=qhJ0fUBT3z-1bUYn=shcUFfAA@mail.gmail.com>
In-Reply-To: <CAMak2D8rWO6zbJhawMr43vg4=qhJ0fUBT3z-1bUYn=shcUFfAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Eric Eric <ericrebates@gmail.com>
Cc: xenomai@xenomai.org

On 06/07/2012 09:44 AM, Eric Eric wrote:
> Hi Gilles, I believe the problems I was having several months ago with
> erratic timing on the Beagleboard when running dohell may be related
> to this.  I'm wondering if there are still plans to formally wrap the
> patch into the official Xenomai tree?

Yes, the patches are not yet available in the xenomai tree, but are 
available on the gna download area:
http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.38.8-arm-1.18-08.patch
http://download.gna.org/adeos/patches/v3.x/arm/adeos-ipipe-3.0.13-arm-1.18-09.patch

-- 
					    Gilles.

