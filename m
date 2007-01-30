Message-ID: <45BF1D8A.2030909@domain.hid>
Date: Tue, 30 Jan 2007 11:27:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_task_create() hangs ?
References: <45B75FFB.6030205@domain.hid>
In-Reply-To: <45B75FFB.6030205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> We noticed that on the AT91RM9200 we don't see the
> 
> Xenomai: POSIX: destroyed thread c14a0320
> 
> message. Not even when running (and stopping) cyclictest. I suspect that
> this is leading to our problems.

This message only appears if CONFIG_XENO_OPT_DEBUG_POSIX is enabled, are
you sure it is enabled in the AT91 kernel configuration ?

-- 
                                                 Gilles Chanteperdrix

