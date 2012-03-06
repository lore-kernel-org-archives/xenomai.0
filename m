Message-ID: <4F55D765.7040705@domain.hid>
Date: Tue, 06 Mar 2012 10:22:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
In-Reply-To: <4F55C306.8020307@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 03/06/2012 08:55 AM, Roberto Bielli wrote:
> Hi,
> 
> it seems that i have a big problem with preemption.  (kernel 2.6.31, arm 
> freescale imx25, xenomai 2.5.6 )
> I send a simple application that doesn't work.
> 
> The task with name 'task2ms' has higher priority than 'taskPrintf', but 
> 'taskPrintf' stop the task 'task2ms' until sleeps.
> 
> I think i have a problem with ipipe porting.
> 
> Any idea ?

Please try getting a trace with the I-pipe tracer.

-- 
                                                                Gilles.

