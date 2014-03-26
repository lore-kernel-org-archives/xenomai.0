Message-ID: <5332A119.3010009@xenomai.org>
Date: Wed, 26 Mar 2014 10:42:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAK4EZFTBCxVWrbMS9DTnR72bcVnSkrkEDCfCZye4u-BREFGoBg@mail.gmail.com>
In-Reply-To: <CAK4EZFTBCxVWrbMS9DTnR72bcVnSkrkEDCfCZye4u-BREFGoBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry Pi Xenomai Linux + Minimal Raspian Net
 Install Guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adam Vaughan <vaughana@umich.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/26/2014 02:25 AM, Adam Vaughan wrote:
> patch -Np1 < ../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-post-2.patch
> 
> 
> ===============================================================
> // Patches to allow disabled USB FIQ and to correct for USB driver issues
> // discussed on the Xenomai mailing list...
> //
> // NOTE:  If you don't apply the last 3 patches a custom FIQ will occasionally
> //        not fire.  I haven't fully validated that it indeed fixes the issue
> //        with a logic analyzer, but I have yet to see a missed FIQ on my
> //        ordinary (not mixed signal) scope.
> //
> cd ~/Xenomai-RPi/linux

The -post patch should be updated to contain these patches. That is what
the -post patch is made for.


-- 
                                                                Gilles.

