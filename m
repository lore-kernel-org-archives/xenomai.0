Message-ID: <2ff1a98a0711300304g2b206422vc3e949109d273bed@domain.hid>
Date: Fri, 30 Nov 2007 12:04:58 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1829866571@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1829866571@domain.hid>
Subject: Re: [Xenomai-help] error while rt_task_wait_period, code -110
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

On Nov 30, 2007 11:52 AM, Andreas Vogt <A_C_V@web.de> wrote:
> Hallo,
>
> I get an error in a simple program with a period time of 1 ms.My latency test program works with a period of 100us.The worst latenz time is about 23us
> Any suggestions?

Do not call rt_task_set_mode(0, T_PRIMARY), it is only adding
unnecessary overhead, Xenomai will automatically switch a task to
primary mode when calling rt_task_wait_period.

Do not call non real-time functions such as printf in your real-time loop.

-- 
                                               Gilles Chanteperdrix

