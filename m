Subject: Re: [xenomai-images 0/7] control applying of no-debug config
References: <20210723031811.19290-1-hongzhan.chen@intel.com>
 <cc0b9573-c11b-6957-14a5-de51e6d447d2@siemens.com>
 <BN9PR11MB52275788D64DA0883795DB1AF2E89@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ef774f04-0ac3-dd9d-9379-e26cff4be36a@siemens.com>
Date: Mon, 26 Jul 2021 07:30:53 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB52275788D64DA0883795DB1AF2E89@BN9PR11MB5227.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Gylstorff Quirin <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 26.07.21 02:31, Chen, Hongzhan via Xenomai wrote:
> 
> 
>> -----Original Message-----
>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com> 
>> Sent: Friday, July 23, 2021 8:27 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [xenomai-images 0/7] control applying of no-debug config
>>
>>
>>
>> On 7/23/21 5:18 AM, Hongzhan Chen via Xenomai wrote:
>>> 1. enable IPIPE_DEBUG uniformly for all arch by default in order to use
>>> uniform method to control it via applying config fragment or not.
>>> 2. create config fragment for earch arch to switch debug off.
>>> 3. add control to apply config fragment or not.
>>> 4. add kas option to control applying config fragment.
>>>
>>> *** BLURB HERE ***
>>>
>>> Hongzhan Chen (7):
>>>    recipes-kernel: arm64_config: enable IPIPE_DEBUG for arm64 by default
>>>    recipes-kernel: armhf_config: enable IPIPE_DEBUG for armhf by default
>>>    recipes-kernel: add config fragment file to disable debug for amd64
>>>    recipes-kernel: add config fragment file to disable debug for arm64
>>>    recipes-kernel: add config fragment file to disable debug for arm
>>>    recipes-kernel/linux: control appyling of no debug config fragment
>>>    Add kas option for swithing off debug
>>>
>>>   opt-set-nodbg.yml                          | 20 ++++++++++++++++++++
>>>   recipes-kernel/linux/files/amd64_nodbg.cfg |  1 +
>>>   recipes-kernel/linux/files/arm64_defconfig |  9 +++++----
>>>   recipes-kernel/linux/files/arm64_nodbg.cfg |  1 +
>>>   recipes-kernel/linux/files/armhf_defconfig | 15 +++++++++++++--
>>>   recipes-kernel/linux/files/armhf_nodbg.cfg |  1 +
>>>   recipes-kernel/linux/linux-xenomai.inc     | 10 +++++++++-
>>>   7 files changed, 50 insertions(+), 7 deletions(-)
>>>   create mode 100644 opt-set-nodbg.yml
>>>   create mode 100644 recipes-kernel/linux/files/amd64_nodbg.cfg
>>>   create mode 100644 recipes-kernel/linux/files/arm64_nodbg.cfg
>>>   create mode 100644 recipes-kernel/linux/files/armhf_nodbg.cfg
>>>
>>
>> Why is there a *_nodbg,cfg for each Arch? The content for all is the 
>> same, so IHMO one file should be enough.
> 
> Current content is same because we just try to switch off IPIPE_DEBUG for all arches.
> But its final purposes is to improve performance for target image to differentiate it from 
> debug image, which may include other linux options or arch related options. That is why 
> I create *_nodgb.cfg for each arch. 

Duplicating is never a good things. So let's keep the common switches in
a common_nodbg.cfg and add the <arch>_nodbg.cfg files once they are needed.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

