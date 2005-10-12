Message-ID: <434D1AFC.2070500@domain.hid>
Date: Wed, 12 Oct 2005 17:17:32 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PATCH: fix ppc64 calibration
References: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>
	<434CFDFF.2090201@domain.hid> <434D06C9.3030802@domain.hid>
	<434D0D2D.4010606@domain.hid>
In-Reply-To: <434D0D2D.4010606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger kirjoitti:
> 
>>What's the problem with Ebonys? I remember running at least 2.6.9 on 
>>Ebonys (440GP) and Walnuts (405).
> 
> 
> We have linux-2.4.14-rc3 running on all AMCC eval boards (see
> http://www.denx.de). But the kernel supported by RTAI/Fusion,
> linuxppc-2.6.10rc3, does not boot on Ebony. The main problem is the
> missing support for U-Boot but there might be others. And it's simply
> not worth the effort to port it, I think.

Now that you mention it, I remember I had to hack u-boot support in 
there back when I used the Ebonys. Maybe I'll see if I can get some 
numbers out of them later this week.

-- Heikki Lindholm

