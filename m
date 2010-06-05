Message-ID: <4C0AA548.6070409@domain.hid>
Date: Sat, 05 Jun 2010 21:28:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
	<4C099329.6000303@domain.hid> <4C0A49C4.8000509@domain.hid>
	<4C0A9AB9.7030602@domain.hid> <4C0A9C2A.1030002@domain.hid>
	<4C0AA224.6060409@domain.hid> <4C0AA2F0.6050201@domain.hid>
	<4C0AA3EC.7040106@domain.hid>
In-Reply-To: <4C0AA3EC.7040106@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> Gilles Chanteperdrix wrote:
>> Not being able to join a deleted task undermines seriously the utility
>> of rt_task_join... What is it useful for, then?
> 
> See the doc: You join or delete, but not both.

Looks to me like a workaround: you are not able to handle properly the
life-cycle of an RT_TASK, so you changed the rules... is there really no
other way?

-- 
					    Gilles.

