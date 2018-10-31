Subject: Re: [PATCH 8/9] net/igb: down interface upon PCI unregister
References: <20181026140825.5251-1-rpm@xenomai.org>
 <20181026140825.5251-8-rpm@xenomai.org>
 <bafeb896-bfcb-78a1-2558-8c389c73a065@siemens.com>
 <45d95e25-aa65-e537-4221-7a43d397159d@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <62c5765a-3491-313f-5cef-1140850c9b37@siemens.com>
Date: Wed, 31 Oct 2018 16:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <45d95e25-aa65-e537-4221-7a43d397159d@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 31.10.18 15:18, Philippe Gerum wrote:
> On 10/31/18 1:32 PM, Jan Kiszka wrote:
>> On 26.10.18 16:08, Philippe Gerum wrote:
>>> Allow to safely unload the IGB driver module still hosting an active
>>> rtnet interface, by forcing this interface down on behalf on the PCI
>>> device removal handler.
>>> ---
>>>    kernel/drivers/net/drivers/igb/igb_main.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/drivers/net/drivers/igb/igb_main.c
>>> b/kernel/drivers/net/drivers/igb/igb_main.c
>>> index 67a34b539..0a6cd4bd6 100644
>>> --- a/kernel/drivers/net/drivers/igb/igb_main.c
>>> +++ b/kernel/drivers/net/drivers/igb/igb_main.c
>>> @@ -2432,6 +2432,7 @@ static void igb_remove(struct pci_dev *pdev)
>>>        struct igb_adapter *adapter = rtnetdev_priv(netdev);
>>>        struct e1000_hw *hw = &adapter->hw;
>>>    +    rtdev_down(netdev);
>>>        igb_down(adapter);
>>>          pm_runtime_get_noresume(&pdev->dev);
>>>
>>
>> Is that igb-only? Or should be add such call to all driver removals?
>>
> 
> This is a use case for the new rtnet_down() call applied to IGB which
> I'm interested in ATM. If the new up/down API is merged, all drivers
> should be updated the same way eventually.
> 

Then we should probably think about the best pattern now:

Why not do this implicitly when the driver unregisters itself from the RTnet 
core? If that unregistration comes too late with some of them, that would become 
the driver patches.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

