MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18342.45897.264004.820537@domain.hid>
Date: Mon, 4 Feb 2008 07:40:09 +0100
In-Reply-To: <47A63DA8.4020609@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
	<18340.31323.677695.655702@domain.hid>
	<18340.31655.777349.789045@domain.hid>
	<47A63DA8.4020609@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 5/5] RTDM: check file descriptor owner.
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > This patch makes RTDM service rtdm_context_get check the owner of a file
 > > descriptor. This will prevent a process to close an RTDM file descriptor
 > > belonging to another process.
 > 
 > I assume this is a safety belt against crazy applications, right?

Not that much crazy: there is no way for an application to know if some
file descriptors were passed to it accross exec, so the only way to be
sure to avoid leaks is to forcibly close all file descriptors. When such
an application was compiled for Xenomai, it suddenly closed all file
descriptors in the system.

 > Hope one day we can solve this via process-local FD name spaces.

I am thinking about this FD rework, we should start writing our
requirements in the wiki.

 > 
 > I'm OK with this if you keep the API of rtdm_context_get as is and add
 > an internal checked service __rtdm_context_get(user_info, fd) instead.
 > rtdm_context_get would then call __rtdm_context_get(NULL, fd) because it
 > is supposed to operate on kernel file descriptors only.

Ok, will do that.

-- 


					    Gilles Chanteperdrix.

