Subject: Re: [PATCH V2] testsuite/smokey: net: load rtnet module if it has not
 been loaded
References: <20210805031327.10873-1-hongzhan.chen@intel.com>
 <06d98602-f257-518c-aac2-8f4378ac14bc@siemens.com>
 <BN9PR11MB52272A299B7F24DF94834D48F2F29@BN9PR11MB5227.namprd11.prod.outlook.com>
 <97312076-7eb1-3e71-8f82-30ee716407b1@siemens.com>
 <BN9PR11MB5227CFF815BBC2B2AF0960C2F2F29@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0709204c-66d0-e232-b4f4-19c7a332e4b4@siemens.com>
Date: Thu, 5 Aug 2021 07:50:15 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227CFF815BBC2B2AF0960C2F2F29@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.08.21 07:32, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Thursday, August 5, 2021 1:26 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH V2] testsuite/smokey: net: load rtnet module if it has not been loaded
>>
>> On 05.08.21 07:21, Chen, Hongzhan wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>> Sent: Thursday, August 5, 2021 1:01 PM
>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>> Subject: Re: [PATCH V2] testsuite/smokey: net: load rtnet module if it has not been loaded
>>>>
>>>> On 05.08.21 05:13, Hongzhan Chen via Xenomai wrote:
>>>>> Before checking net config, rtnet should be ready.
>>>>>
>>>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>>>>
>>>>> diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
>>>>> index 1badabdfb..a0512b00d 100644
>>>>> --- a/testsuite/smokey/net_common/setup.c
>>>>> +++ b/testsuite/smokey/net_common/setup.c
>>>>> @@ -408,6 +408,10 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
>>>>>  	struct sockaddr_in *in_peer = vpeer;
>>>>>  	struct sockaddr *peer = vpeer;
>>>>>  
>>>>> +	err = smokey_net_modprobe(MODID_RTNET);
>>>>> +	if (err < 0)
>>>>> +		return err;
>>>>> +
>>>>>  	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
>>>>>  			&net_config, sizeof(net_config));
>>>>>  	if (err == -EINVAL)
>>>>>
>>>>
>>>> Sorry, only realized now: The checks that come right after this should
>>>> not be affected by rtnet being loaded or not yet. I think they check
>>>
>>> No. Actually, it would be affected. If rtnet is not loaded and inited before cobalt_corectl is called, it would 
>>> not call rtnet_corectl_register to cobalt_add_config_chain and config_notifier_list would
>>> be empty.  And then cobalt_corectl ->do_conf_option would return -EINVAL because blocking_notifier_call_chain return NOTIFY_DONE.
>>> In smokey_net_setup, it would return -ENOSYS because  cobalt_corectl return -EINVAL. 
>>>
>>
>> OK, catch22. But we must not fail the test if RTnet is not configured
> 
> I do not know what RTnet config you are talking about. Actually  cobalt_corectl(_CC_COBALT_GET_NET_CONFIG is just checking xenomai kernel config.
> 
> static int rtnet_corectl_call(struct notifier_block *self, unsigned long arg,
> 			      void *cookie)
> 			
> {
> 	struct cobalt_config_vector *vec = cookie;
> 	int ret = 0;
> 
> 	if (arg != _CC_COBALT_GET_NET_CONFIG)
> 		return NOTIFY_DONE;
> 
> 	if (vec->u_bufsz < sizeof(ret))
> 		return notifier_from_errno(-EINVAL);
> 
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET))
> 		ret |= _CC_COBALT_NET;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_ETH_P_ALL))
> 		ret |= _CC_COBALT_NET_ETH_P_ALL;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4))
> 		ret |= _CC_COBALT_NET_IPV4;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP))
> 		ret |= _CC_COBALT_NET_ICMP;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING))
> 		ret |= _CC_COBALT_NET_NETROUTING;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_ROUTE))
> 		ret |= _CC_COBALT_NET_ROUTER;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP))
> 		ret |= _CC_COBALT_NET_UDP;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTPACKET))
> 		ret |= _CC_COBALT_NET_AF_PACKET;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_TDMA))
> 		ret |= _CC_COBALT_NET_TDMA;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_NOMAC))
> 		ret |= _CC_COBALT_NET_NOMAC;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTCFG))
> 		ret |= _CC_COBALT_NET_CFG;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_ADDON_RTCAP))
> 		ret |= _CC_COBALT_NET_CAP;
> 	if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_ADDON_PROXY))
> 		ret |= _CC_COBALT_NET_PROXY;
> 
> 	ret = cobalt_copy_to_user(vec->u_buf, &ret, sizeof(ret));
> 
>> and, thus, cannot be loaded.
>>
>> Jan
> 


CONFIG_XENO_DRIVERS_NET=n, smokey --run=<rtnet-test> => skipped (no
kernel support). That would be the expected result. I'm afraid that the
new modprobe will fail with something != ENOSYS, thus will not give us
such a result. Please check.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

