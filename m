Subject: Re: Handling MSI-X interrupts in the head stage for x86 platform
References: <2fa58638-4b6f-330f-98d7-194bdfa47780@nicevt.ru>
 <BN6PR11MB16208D6D883154537467F163EE8A0@BN6PR11MB1620.namprd11.prod.outlook.com>
From: Alexander Frolov <frolov@nicevt.ru>
Message-ID: <8a764653-73e2-4e9f-b90b-3f67f0696712@nicevt.ru>
Date: Tue, 2 Jun 2020 09:40:12 +0300
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB16208D6D883154537467F163EE8A0@BN6PR11MB1620.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



On 6/1/20 12:23 PM, Meng, Fino via Xenomai wrote:
>
>> Sent: Monday, June 1, 2020 4:09 PM
>>
>> Hi all!
>>
>> I have a PCIe device in x86 motherboard that generate periodic MSI-X i=
nterrupts and I would like to handle them in the head
>> stage, how it can be done?
>> Thank you! Appreciate any help!
>>
>> Best,
>>  =C2=A0=C2=A0 Alex
> Hi Alex,
>
> Kernel/driver/serial/16550A.c is a pci device, and have less code than =
net/igb driver,
> Which specific device u want to enable? Does it have a vanilla kernel d=
river already?

Not sure that 16550A uses MSI-X interrupts. However, net/igb does. Is it=20
only driver in Xenomai that supports MSI-X?


I am using FPGA based device for periodic interrupts which is totally=20
custom. We have are own driver.

Nevertheless, I have tested its latency from root stage driver and it is=20
appropriately good (not over than 60us). It seems that
msix irqs are not stalled anywhere. Is it possible?

Can I guarantee that there will be no condition when MSIX interrupt will=20
be deferred by head stage on more than that? What latency
improvement I can expect from moving to RTDM based driver?

Thank you!


