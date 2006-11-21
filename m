Message-ID: <456328F8.3050803@domain.hid>
Date: Tue, 21 Nov 2006 08:27:36 -0800
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 3/3] control POSIX
	skin	debugging	independently
References: <456236E5.5060203@domain.hid> <4562CE05.70900@domain.hid>
	<4562E24E.4000209@domain.hid>
In-Reply-To: <4562E24E.4000209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

> About the "if (XENO_DEBUG(POSIX))": I'm OK with converting them back to
> "#if XENO_DEBUG(POSIX)" if this is preferred.

If the construct is *only* used at compile time, then the second form is 
certainly more explicit in that regard. However, it precludes alternate 
implementations which allow conditional debugging at run time. Would 
that not be the point of the first form? So in that sense they are not 
equivalent source code constructs.

                         - Tom

-- 
Thomas Lockhart
Supervisor, Realtime Software Group
Interferometry and Large Optical Systems
Caltech/JPL

