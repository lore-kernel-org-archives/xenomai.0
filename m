Message-ID: <43FF166A.1060508@domain.hid>
Date: Fri, 24 Feb 2006 15:21:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43FF13BE.7080505@domain.hid>
In-Reply-To: <43FF13BE.7080505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: skin libs, libtool warnings, and -module
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

Jan Kiszka wrote:
> Hi Philippe,
> 
> I noticed you fixed the libtool warning during xenomai build - by
> linking the testsuite statically... :-/ This is just a workaround and
> doesn't help external users.

Yes, it's clearly hacky-patchy, however, I don't see how this would impact 
external users (yet)?

> 
> Isn't the reason for this warnings that "-module" in every skin
> Makefile.am? At least, removing it also fixes external apps. Do we need
> it? I don't think so: -module is for preparing dlopen usage, but who
> will use it with skin libs?


E.g. People who need to do late binding from some interpreter engine to the 
routines defined by those APIs.

-- 

Philippe.

