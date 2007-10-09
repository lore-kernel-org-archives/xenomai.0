Message-ID: <470B478A.6010205@domain.hid>
Date: Tue, 09 Oct 2007 11:19:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470B32F0.6030601@domain.hid>
In-Reply-To: <470B32F0.6030601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] documentation: rtdm functions available
 in	user space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Johan Borkhuis wrote:
> When checking the documentation I found that a lot of rtdm functions are
> indicated as available in user space, but AFAIK these functions are 
> only available in kernel space or interrupt contect.
> The documentation is generated using ksrc/skin/rtdm/drvlib.c. Below is a
> patch file that corrects this.
> 
> (I did not check other documentation to see if there are more functions
> defined for use in user space)

The problem is not "User-space task", but rather the headline
"Environments". The latter term is obviously not that clear. It is meant
to express the "Execution context" of the service caller. Would that
term make it clearer?

Thanks for picking this up,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

