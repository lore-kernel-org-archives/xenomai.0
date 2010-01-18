Message-ID: <4B54CD88.20201@domain.hid>
Date: Mon, 18 Jan 2010 22:07:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B546AD0.3060106@domain.hid> <4B546BEC.8030703@domain.hid>
	<4B54ACC8.9030006@domain.hid>
In-Reply-To: <4B54ACC8.9030006@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] rtcan_rtt: Various fixes and improvement
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> This patch fixes type long overflows, invalid command line argument
>>> types and gives the receiver and transmitter thread dedicated names.
>>>
>>> Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
>>>
>>> diff --git a/examples/rtdm/profiles/can/rtcan_rtt.c
>>> b/examples/rtdm/profiles/can/rtcan_rtt.c
>>> index 93c84a6..2280562 100644
>>> --- a/examples/rtdm/profiles/can/rtcan_rtt.c
>>> +++ b/examples/rtdm/profiles/can/rtcan_rtt.c
>>> @@ -94,6 +94,7 @@ void *transmitter(void *arg)
>>>      frame.can_id = can_id;
>>>      frame.can_dlc = sizeof(*rtt_time);
>>>
>>> +    pthread_set_name_np(pthread_self(), "rtcan_rtt_transmitter");
>> Maybe we should put this between #ifdef __XENO__, so that the code
>> compiles under plain posix too?
> 
> Good idea but it requires a few more changes. See below:

Fine. Merged, thanks.

-- 
					    Gilles.

