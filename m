From: Paul <paul_c@tuxcnc.org>
Date: Fri, 15 Feb 2013 11:50:44 +0000
References: <201302141227.05428.paul_c@tuxcnc.org>
	<511D3F8F.8090501@xenomai.org>
In-Reply-To: <511D3F8F.8090501@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201302151150.44164.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thursday 14 February 2013, Gilles Chanteperdrix wrote:
> On 02/14/2013 01:27 PM, Paul wrote:
> > Attached, a patch set aimed at providing support for the Broadcom
> > BCM2835 SoC as used in the Raspberry Pi[1].

> In the meantime, we can put it in a raspberry subdirectory in Xenomai
> sources. Would you mind making a single patch? Or do you prefer the
> patches to be kept separated?

A single patch would be preferable for most people - The multi-patch set 
was mainly for the benefit of the guys who had a working kernel but 
were sturggling with the GPIO problem (patch No.4 should apply on a 
3.2.2x kernel).

I'll rename the defconfig and add some recent changes made to 
the "official" Raspberry kernel. Expect a single patch in a day or two.


Regards, Paul.

