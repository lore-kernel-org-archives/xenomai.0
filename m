Message-ID: <4EBA5DE2.3060307@domain.hid>
Date: Wed, 09 Nov 2011 12:02:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51962.81.220.196.189.1320786408.squirrel@domain.hid>
	<4EB9C562.9040107@domain.hid> <4EBA5585.8050807@domain.hid>
In-Reply-To: <4EBA5585.8050807@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and Round Robin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Olivier Reynet <olivier.reynet@domain.hid>
Cc: xenomai@xenomai.org

On 11/09/2011 11:27 AM, Olivier Reynet wrote:
>      RTIME quantum=rt_timer_ns2tsc(3*SPINTIME);
>      int err=rt_task_slice(&demo_task[i],quantum);

You are misunderstanding the time unit of rt_task_slice. Refer to
documentation.

-- 
					    Gilles.

