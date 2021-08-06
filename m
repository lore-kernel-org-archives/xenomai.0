Subject: Re: [PATCH] testsuite/smokey: net: Load rtnet module if missing
References: <166cb503-258c-ddde-1143-4fd43c954c4f@siemens.com>
 <BN9PR11MB5227FDD6E5FD7AEB0008D67EF2F39@BN9PR11MB5227.namprd11.prod.outlook.com>
 <36412ade-35dc-25f7-4b13-4ba77e2ec54d@siemens.com>
 <BN9PR11MB522789B5175C05B67B487EE2F2F39@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5e3bddfe-233f-bc81-6968-7e48026e5649@siemens.com>
Date: Fri, 6 Aug 2021 10:30:01 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB522789B5175C05B67B487EE2F2F39@BN9PR11MB5227.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Xenomai <xenomai@xenomai.org>

On 06.08.21 10:23, Chen, Hongzhan wrote:
> 
> 
>  -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Friday, August 6, 2021 4:12 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Xenomai <xenomai@xenomai.org>
>> Subject: Re: [PATCH] testsuite/smokey: net: Load rtnet module if missing
>>
>> On 06.08.21 09:48, Chen, Hongzhan wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>> Sent: Friday, August 6, 2021 3:38 PM
>>>> To: Xenomai <xenomai@xenomai.org>
>>>> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>> Subject: [PATCH] testsuite/smokey: net: Load rtnet module if missing
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> This allows to run RTnet tests if the core is built as module but not
>>>> yet loaded at the start of the test.
>>>>
>>>> For that, silence error reports of 'modprobe rtnet'.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> This should do the trick as well, just a bit simpler.
>>>>
>>>> testsuite/smokey/net_common/setup.c | 22 +++++++++++++++-------
>>>> 1 file changed, 15 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
>>>> index 1badabdfb4..44a0cb24b9 100644
>>>> --- a/testsuite/smokey/net_common/setup.c
>>>> +++ b/testsuite/smokey/net_common/setup.c
>>>> @@ -138,7 +138,7 @@ static int do_down(const char *intf)
>>>> 	return 0;
>>>> }
>>>>
>>>> -static int smokey_net_modprobe(int modid)
>>>> +static int smokey_net_modprobe(int modid, bool silent)
>>>> {
>>>> 	struct module *m = modules + modid;
>>>> 	char buffer[128];
>>>> @@ -168,7 +168,8 @@ static int smokey_net_modprobe(int modid)
>>>> 	smokey_trace("%s module not there: modprobing", m->name);
>>>>
>>>> 	err = smokey_check_errno(
>>>> -		snprintf(buffer, sizeof(buffer), "modprobe %s", m->name));
>>>> +		snprintf(buffer, sizeof(buffer), "modprobe %s %s", m->name,
>>>> +			 silent ? "2>/dev/null" : ""));
>>>> 	if (err < 0)
>>>> 		return err;
>>>>
>>>> @@ -177,7 +178,8 @@ static int smokey_net_modprobe(int modid)
>>>> 		return err;
>>>>
>>>> 	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
>>>> -		smokey_warning("%s: abnormal exit", buffer);
>>>> +		if (!silent)
>>>> +			smokey_warning("%s: abnormal exit", buffer);
>>>> 		return -EINVAL;
>>>> 	}
>>>>
>>>> @@ -224,7 +226,7 @@ static int smokey_net_setup_rtcfg_client(const char *intf, int net_config)
>>>> 	if ((net_config & _CC_COBALT_NET_CFG) == 0)
>>>> 		return -ENOSYS;
>>>>
>>>> -	err = smokey_net_modprobe(MODID_CFG);
>>>> +	err = smokey_net_modprobe(MODID_CFG, false);
>>>> 	if (err < 0)
>>>> 		return err;
>>>>
>>>> @@ -408,6 +410,12 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
>>>> 	struct sockaddr_in *in_peer = vpeer;
>>>> 	struct sockaddr *peer = vpeer;
>>>>
>>>> +	/*
>>>> +	 * Main module needs to be loaded in order to use
>>>> +	 * _CC_COBALT_GET_NET_CONFIG.
>>>> +	 */
>>>> +	smokey_net_modprobe(MODID_RTNET, true);
>>>
>>>      no need to check return value?
>>>
>>
>> Theoretically, we could miss the case that RTnet was configured but the
> 
> What about RTnet is not configured? New modinfo checking patch as we discussed to protect this?

If RTnet is not configured, the test will fail silently ("no kernel
support"). If we don't want that case for our CI/CT setup, we need to
check the output for such messages and fail the test run at lava level.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

