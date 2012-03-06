Message-ID: <4F55FE81.6000904@domain.hid>
Date: Tue, 06 Mar 2012 13:09:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
In-Reply-To: <4F55E390.8090706@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai-core] preemptive doesn't work
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 03/06/2012 11:14 AM, Roberto Bielli wrote:
> Hi,
> 
> here is the trace.

Please try to capture the xntimer_next_local_shot which happens before
the bug to see if the timer ticks when expected.

Also note that if we are going through __ipipe_preempt_schedule_irq, it
means that the task eating the cpu is running in secondary mode. So, you
should use T_WARNSW to see.

Please keep the discussion on the mailing list.	

-- 
                                                                Gilles.

