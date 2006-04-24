From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17484.54103.464630.986240@domain.hid>
Date: Mon, 24 Apr 2006 15:32:07 +0200
Subject: Re: [Xenomai-core] xenomai thread interuption
In-Reply-To: <20060424080113.84106.qmail@domain.hid>
References: <20060424080113.84106.qmail@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles mendes <mendesgilles@domain.hid>
Cc: xenomai@xenomai.org

gilles mendes wrote:
 > i have a linux kernel 2.6.15 patch with  xenomai, i wanted to compile
 > vxWorks's aplications on my real time kernel, but when a system task
 > is running the real time threads are blocked during the system task.

What is a "system task"?

 > what can i do for solve this fonctionement of my kernel ? 

Please send the code, as short as possible, of an example illustrating
the issue you are facing. And tell us a bit more about your setup, are
you using vxworks skin in simulator, in kernel-space, in user-space, or
vxworks UVM?

-- 


					    Gilles Chanteperdrix.

