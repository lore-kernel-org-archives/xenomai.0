From: Peter Soetens <peter.soetens@domain.hid>
Subject: Re: [Xenomai-help] [ANNOUNCE] Orocos Real-Time Toolkit 1.0
Date: Mon, 13 Nov 2006 14:19:36 +0100
References: <200611131055.00633.peter.soetens@domain.hid>
	<45586AF7.9030504@domain.hid>
In-Reply-To: <45586AF7.9030504@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131419.37071.peter.soetens@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

On Monday 13 November 2006 13:54, Jan Kiszka wrote:
> Peter Soetens wrote:
> >  The "Open Robot Control Software" (Orocos) project uses Xenomai
> >  for realising its real-time behaviour.
> >
> >                The Orocos Real-Time Toolkit v1.0.0.
> >                        http://www.orocos.org
> >                ====================================
> >
> >  The Orocos development team is proud to announce the first stable
> >  release of the Real-Time Toolkit (RTT), a C++ toolkit for building
> >  component based, real-time robotics and machine control applications.
>
> Congratulations to this milestone! Really nice, professional work.
>
> Could you elaborate a bit on the degree of Xenomai integration? What is
> working, what might be missing (compared to other RTOS ports)? 

Well, I'd like to share our very positive experiences with Xenomai. The 
Real-Time Toolkit only uses a handful of RTOS primitives, so Xenomai is fully 
supported, as well since the RTT does not have any device drivers (that's now 
in the Component's Library). Especially debugging Xenomai programs starts 
working really well. Some of our new projects use Xenomai exclusively.

> What is
> the status of driver support? And were you able to collect any practical
> experience on larger setups over Xenomai already?

The components which address hardware were written for RTAI/LXRT some years 
ago. We're building up experience with the RTDM and a port is a matter of 
time, although that is in the hands of our friends at the university (which 
have said hardware).

Especially the clean API, solid separation kernel/userspace in headers and 
robustness make a Xenomai build really reliable, even across Linux/Xenomai 
versions. Shame it didn't exist 5 years ago.... :-)

Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

