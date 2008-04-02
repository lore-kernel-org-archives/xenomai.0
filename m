Message-ID: <47F3E199.8030906@domain.hid>
Date: Wed, 02 Apr 2008 14:42:17 -0500
From: Bill Gatliff <bgat@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>
	<47F17B32.7070505@domain.hid>		<18417.52630.8850.939898@domain.hid>		<47F23E9E.7060801@domain.hid>		<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>		<47F258AD.3000103@domain.hid>		<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>		<47F2A7CC.4050301@domain.hid>		<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>		<47F3A00E.1020700@domain.hid>	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>
	<47F3E0B3.2030805@domain.hid>
In-Reply-To: <47F3E0B3.2030805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Tomas Kalibera wrote:
> Hi Gilles,
> 
> I've recompiled the kernel again from scratch and got the same lock up. 
> Fix 5 does not help... If you want to inspect the exact kernel I used, 
> it's again at http://www.cs.purdue.edu/~tkaliber/crash, the one with 
> "p5" in its name.

You aren't using gcc-4.2 or later, are you?  I've had problems with 
those for building and/or running kernels.  On non-x86 targets, mind 
you, but maybe there's a connection...


b.g.
-- 
Bill Gatliff
bgat@domain.hid

