Message-ID: <4F55D7F3.8020503@domain.hid>
Date: Tue, 06 Mar 2012 10:25:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADAaWNVt-wbM0oNCxOK_Gm7R4A53UVECaYYiWPvUDGQFzSdffg@domain.hid>
In-Reply-To: <CADAaWNVt-wbM0oNCxOK_Gm7R4A53UVECaYYiWPvUDGQFzSdffg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Specifying/changing the number of CPU core's in
 xenomai: - reg
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: SUBRAMANIAN NATESAN <yenyes88@domain.hid>
Cc: xenomai@xenomai.org

On 03/06/2012 07:46 AM, SUBRAMANIAN NATESAN wrote:
> Hi,
> 
> In a multi-core environment, is it possible in xenomai, to specify the cpu
> cores which should or should not be used? Like if there are 4 cores, can we
> specify, that core 2 need not be used at all, dynamically, during the
> execution of a real time task?

You can use sched_setaffinity to set the CPU on which a task should run.
-- 
                                                                Gilles.

