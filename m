Message-ID: <434D0F98.1050400@domain.hid>
Date: Wed, 12 Oct 2005 15:28:56 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PATCH: fix ppc64 calibration
References: <1CFEB358338412458B21FAA0D78FE86D4F0E1D@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E1D@rennsmail02.eu.thmulti.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

On 10/12/2005 03:16 PM Fillod Stephane wrote:
> Wolfgang Grandegger wrote:
>>On 10/11/2005 05:11 PM Fillod Stephane wrote:
>>> Heikki Lindholm wrote:
>>> [..]
>>>> Probably, but there are less than awesome 4xx boards around and I'd 
>>>> guess they might even be more likely targets than G4 based machines,
>>> for 
>>>> example. Some tuning might be needed.
>>> 
>>> How many people are using Xenomai (or Fusion) on 4xx ?
>>> What are their typical sched latency ?
>>
>>Attached is the result of some latency measurements on the Ocotea eval
>>board. The AMCC 440 GX is already a fast 4xx processor. Unfortunately,
>>the linuxppc-2.6.10rc3 does not run on our Ebony board. Nevertheless,
>>it's difficult to provide a resonable default value. Why not simply
>>using 0 and it's then up to the user to provide an appropriate value
>>at configuration time?
> 
> If it helps, know there's 2.6.10 and 2.6.11 (CONFIG_PREEMPT disabled 
> though) ADEOS patches available for ppc.

I'm using adeos-linux-2.6.10-ppc-r8c4.patch with linuxppc-2.6.10rc3,
which works fine, at least on the Ocotea board.

> 
> My latency measurements for Freescale e500 are here:
>  https://mail.gna.org/public/rtai-dev/2005-02/msg00045.html
> 
> It looks like an ADEOS/I-Pipe patch for current Linux kernels is much 
> expected.

Of course. But Phillips is already heavily loaded with the project, I
assume.

> 
> The default calibration value may be set according to L1_CACHE_BYTES.
> Of course I'm fine with a default value set to 0, which is closer to my 
> end of the spectrum :-)

The nice thing with 0 is that you do not get negative latency values.
But for me, any number is OK.

Wolfgang.


