Message-ID: <434C12AA.7010303@domain.hid>
Date: Tue, 11 Oct 2005 21:29:46 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PATCH: fix ppc64 calibration
References: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>
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

On 10/11/2005 05:11 PM Fillod Stephane wrote:
> Heikki Lindholm wrote:
> [..]
>> Probably, but there are less than awesome 4xx boards around and I'd 
>> guess they might even be more likely targets than G4 based machines,
> for 
>> example. Some tuning might be needed.
> 
> How many people are using Xenomai (or Fusion) on 4xx ?
> What are their typical sched latency ?

RTAI is used on 4xx and other embedded PowerPC processors, like 8xx,
8xxx and 52xx and Xenomai/Fusion might be an option in the future.
Today, there are only a few people running and testing Xenomai/Fusion on
these PowerPC processors, I guess. The problem is the availability of
the Linux 2.6 together with the ADEOS/iPipe-Patch. A lot of embedded
PowerPC boards do still not run or even compile Linux 2.6.

Depending on the CPU power and cache size, latencies can go up to 200 us
(or more), e.g. on a MPC 850 with 50 MHz and 1K cache. I'm going to
measure the latency on a Ocotea (440GP) and Ebony (405) board this week
(with adeos-linux-2.6.10-ppc-r8c4.patch and Fusion 0.9.1).

Wolfgang.





