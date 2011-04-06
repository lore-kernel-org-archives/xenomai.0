Message-ID: <4D9CA930.3000204@domain.hid>
Date: Wed, 06 Apr 2011 19:56:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
In-Reply-To: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Backfire: User <-> Kernel latancy mesurement
 tool on	Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: krishna m <krishnamurthyjs@domain.hid>
Cc: xenomai@xenomai.org

krishna m wrote:
> I ported the backfire tool in the OSADL site [https://www.osadl.org/backfire-4.backfire.0.html] to measure the user to/from kernel latency.I wanted to measure the difference between the RT_PREEMPT kernel and Xenomai Kernel. Surprisingly i see RT_PREEMPT performance better than Xenomai. 
>  
> Here are few points to note:
> 1. The thread priority of the "sendme" tool of backfire in RT_PREEMPT is 99 [highest]
> 2. I have made the thread priority 99 for the rt_task that i spawn [par of ported sendme]
> ret = rt_task_shadow(&rt_task_desc, NULL, 99, 0);
>  
> My Questions:
> * I wanted to know if any one has done such measurements using backfire and how dose Xenomai fair agnist RT_PREEMPT?
> * is there any similar tool like backfire in the Xenomai tool set that dose the similar measurements?
> * Do I need to do more Xenomai specific optimization in the "sendme" and "backfire" code to get better performance?

Useless notes, useless questions. Show us the "ported" code.


-- 
					    Gilles.

