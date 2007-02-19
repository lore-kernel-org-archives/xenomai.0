Message-ID: <45D9AE79.2090208@domain.hid>
Date: Mon, 19 Feb 2007 15:04:41 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-CAN tx_sem
References: <45D35545.20100@domain.hid>
	<45D45F63.5050009@domain.hid>	<45D461DC.20303@domain.hid>
	<45D4661D.7010506@domain.hid>	<45D46E55.7020907@domain.hid>
	<45D48E27.1090200@domain.hid> <45D6D6CB.4030602@domain.hid>
	<45D89B66.6050907@domain.hid> <45D8AEB3.4020909@domain.hid>
	<45D8B8EF.3020204@domain.hid>
In-Reply-To: <45D8B8EF.3020204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> I thought about this issue again and found the reason for my vague bad
>>>> feeling: re-init is not atomic, thus racy. But also the test+sem_init
>>>> pattern I suggested is not save.
>>>>
>>>> I guess we need to enhance rtdm_XXX_init in this regard to make the
>>>> RT-CAN use case an officially allowed one. /me is planning to spend more
>>>> thoughts on this the next days.
>>> OK, done, rtdm_{event,sem,mutex}_init are now protected by the nklock in
>>> trunk. This should make the in-place re-initialisation of RTDM IPC
>>> objects race-free and allow to use them in RT-CAN as originally
>>> intended. I think I will back-port that pieces also to v2.3.x later.

Well, I looked to your changes and do not yet understand what they are 
good for. From my point of view, it does _only_ make sense to use "init" 
and "destroy" in a serialized way, like RT-Socket-CAN does. If you do 
"re-init" without destroy, you might be in trouble if the object is in a 
wait state. Have I missed something?

>>> What patch should now go in to avoid double init/destroy and fix
>>> rtcan_virt?
>> Attached. Thanks.
>>
> 
> Just applied to trunk.

Thanks.

> To avoid lock nesting where possible, I reordered some code in
> rtcan_raw_sendmsg. Please re-check if I messed anything up. Then I could
> commit to stable, too.

Hm, I do not see critical changes in rtcan_raw.c. I have tested the CAN 
drivers today and did'nt realize any new problem, apart from an old bug 
:-(fix coming soon).

Wolfgang.





> Jan
> 


