Message-ID: <45CAE2DD.5050304@domain.hid>
Date: Thu, 08 Feb 2007 09:44:13 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Linux lock-up with rtcanrecv
References: <45CA5AFD.9020805@domain.hid> <45CA5C43.4030403@domain.hid>
In-Reply-To: <45CA5C43.4030403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Hi all,
>>
>> fiddling with latest Xenomai trunk and 2.3.x on one of our robots (there
>> is still a bug in trunk /wrt broken timeouts of rt_dev_read on
>> xeno_16550A - different issue...), I ran into a weird behaviour of
>> rtcanrecv:
>>
>> I have a continuous stream of a few thousand packets/s towards the
>> robot. When I start up two "rtcanrecv rtcan0 -p1000" instances (or one +
>> our own receiver application), the second one causes a Linux lock-up.
>> Sometimes this happens during startup of the second rtcanrecv, but at
>> latest on its termination. Other RT tasks are still running. I can
>> resolve the lock-up by pulling the CAN cable, everyone is fine
>> afterwards and can be cleaned up. I played with quite a few combinations
>> of recent ipipe patches and Xenomai revisions (even back to #1084 in
>> v2.3.x), no noticeable difference.
>>
> 
> Forgot to mention one further observation: removing the usleep form
> rtcanrecv's cleanup() works around the shutdown lock-up. I can't
> interpret this yet. [BTW, Wolfgang, what is it good for?]

Hm, I think the usleep() only make sense for rtcansend to allow messages 
to got out before the close. You can remove it.

Wolfgang.


