content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] PATCH: fix ppc64 calibration
Date: Wed, 12 Oct 2005 15:16:32 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E1D@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
>On 10/11/2005 05:11 PM Fillod Stephane wrote:
>> Heikki Lindholm wrote:
>> [..]
>>> Probably, but there are less than awesome 4xx boards around and I'd=20
>>> guess they might even be more likely targets than G4 based machines,
>> for=20
>>> example. Some tuning might be needed.
>>=20
>> How many people are using Xenomai (or Fusion) on 4xx ?
>> What are their typical sched latency ?
>
>Attached is the result of some latency measurements on the Ocotea eval
>board. The AMCC 440 GX is already a fast 4xx processor. Unfortunately,
>the linuxppc-2.6.10rc3 does not run on our Ebony board. Nevertheless,
>it's difficult to provide a resonable default value. Why not simply
>using 0 and it's then up to the user to provide an appropriate value
>at configuration time?

If it helps, know there's 2.6.10 and 2.6.11 (CONFIG_PREEMPT disabled=20
though) ADEOS patches available for ppc.

My latency measurements for Freescale e500 are here:
 https://mail.gna.org/public/rtai-dev/2005-02/msg00045.html

It looks like an ADEOS/I-Pipe patch for current Linux kernels is much=20
expected.

The default calibration value may be set according to L1_CACHE_BYTES.
Of course I'm fine with a default value set to 0, which is closer to my=20
end of the spectrum :-)

--=20
Stephane


