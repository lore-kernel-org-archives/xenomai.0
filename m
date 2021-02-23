Subject: Re: [PATCH 1/2] drm/i915/pm: support disable SAGV via debugfs
 interface
References: <20210221145947.22408-1-fino.meng@linux.intel.com>
 <9111e094-2ee1-1363-54c5-8389bd135235@siemens.com>
 <20210223081350.GA18960@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <db4cfef5-9451-ada0-cca8-823d2611e364@siemens.com>
Date: Tue, 23 Feb 2021 09:49:52 +0100
MIME-Version: 1.0
In-Reply-To: <20210223081350.GA18960@linux.intel.com>
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
To: Fino Meng <fino.meng@linux.intel.com>
Cc: xenomai@xenomai.org

On 23.02.21 09:13, Fino Meng wrote:
> Tue, Feb 23, 2021 at 08:28:32AM +0100, Jan Kiszka wrote:
>> On 21.02.21 15:59, Fino Meng via Xenomai wrote:
>>> SAGV (System Agent Geyserville) is part of the Enhanced Intel Speedstep
>>> Technology. SAGV dynamically adjust the system agent's voltage and frequency
>>> for power saving. SAGV's point change will cause DRAM's frequency change
>>> accordingly, and DRAM is not accessible during the change. Disable SAGV will
>>> tune the system more deterministic.
>>>
>>> CAUTION: this debugfs interface is a work around operation, it doesn't
>>> cope with any context state integrity of i915 driver.
>>>
>>> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
>>> ---
>>>  drivers/gpu/drm/i915/i915_debugfs.c | 57 +++++++++++++++++++++++++++++
>>>  1 file changed, 57 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
>>> index b0f51591f2e4..eefeb3994d1d 100644
>>> --- a/drivers/gpu/drm/i915/i915_debugfs.c
>>> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
>>> @@ -3725,6 +3725,62 @@ DEFINE_SIMPLE_ATTRIBUTE(i915_cache_sharing_fops,
>>>  			i915_cache_sharing_get, i915_cache_sharing_set,
>>>  			"%llu\n");
>>>  
>>> +static int
>>> +i915_sagv_disable_set(void *data, u64 val)
>>> +{
>>> +	/* SAGV (System Agent Geyserville)'s offical name is System Agent
>>> +	 * Speedstep, it dynamically adjust the system agent's voltage
>>> +	 * and frequency for power saving. SAGV's point change will cause
>>> +	 * DRAM's frequency change accordingly, and DRAM is not accessible
>>> +	 * during the change. Disable SAGV will tune the system more
>>> +	 * deterministic. If SAGV already disabled by BIOS, then it's not
>>> +	 * possible to disable SAGV via send request to P-Unit mailbox.
>>> +	 *
>>> +	 * CAUTION: this debugfs interface is a work around operation,
>>> +	 * it doesn't cope with of the state integrity of i915.
>>> +	 *
>>> +	 * Ref:
>>> +	 * https://01.org/sites/default/files/documentation/
>>> +	 * intel-gfx-prm-osrc-kbl-vol12-display.pdf
>>> +	 */
>>> +	struct drm_i915_private *dev_priv = data;
>>> +
>>> +	if (!(IS_GEN_RANGE(dev_priv, 6, 12)))
>>> +		return -ENODEV;
>>> +
>>> +	if (val > 1)
>>> +		return -EINVAL;
>>> +
>>> +	DRM_DEBUG_DRIVER("Manually request sagv disable: %llu\n", val);
>>> +
>>> +	if (val)
>>> +		intel_disable_sagv(dev_priv);
>>> +	else
>>> +		intel_enable_sagv(dev_priv);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int
>>> +i915_sagv_disable_get(void *data, u64 *val)
>>> +{
>>> +	struct drm_i915_private *dev_priv = data;
>>> +
>>> +	if (!(IS_GEN_RANGE(dev_priv, 6, 12)))
>>> +		return -ENODEV;
>>> +
>>> +	if (dev_priv->sagv_status == I915_SAGV_DISABLED)
>>> +		*val = 1;
>>> +	else
>>> +		*val = 0;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +DEFINE_SIMPLE_ATTRIBUTE(i915_sagv_disable_fops,
>>> +			i915_sagv_disable_get, i915_sagv_disable_set,
>>> +			"%llu\n");
>>> +
>>>  static void cherryview_sseu_device_status(struct drm_i915_private *dev_priv,
>>>  					  struct sseu_dev_info *sseu)
>>>  {
>>> @@ -4341,6 +4397,7 @@ static const struct i915_debugfs_files {
>>>  } i915_debugfs_files[] = {
>>>  	{"i915_wedged", &i915_wedged_fops},
>>>  	{"i915_cache_sharing", &i915_cache_sharing_fops},
>>> +	{"i915_sagv_disable", &i915_sagv_disable_fops},
>>>  	{"i915_gem_drop_caches", &i915_drop_caches_fops},
>>>  #if IS_ENABLED(CONFIG_DRM_I915_CAPTURE_ERROR)
>>>  	{"i915_error_state", &i915_error_state_fops},
>>>
>>
>> Isn't such control of general interest to real-time community? How do we
>> deal with this side effect under PREEMPT-RT? Could we create something
>> that permits upstream integration?
>>
>> Jan
>>
>> -- 
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linuxi
> 
> understand, I wrote to i915 developers but didn't get reply yet.
> SAGV is missing on a lot of boards' BIOS, so I want to bring this WA to
> community.
> I would like to present a simple slice on tomorrow's Xenomai community
> call, on our recent work of RT performance turing, use intel_idle,
> intel_pstate, i915 drivers and kernel boot parameters,
> 

OK, that would be helpful.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

