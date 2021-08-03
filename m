Subject: Re: about RTnet* smokey test skipped issue on Qemu
References: <BN9PR11MB5227AA25E0CD6ACB67B8CE8EF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
 <769057a8-3bfe-efcd-0975-a94734846dc3@siemens.com>
 <BN9PR11MB5227EDF8B90BDC8D4B49004DF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f200cbdd-2fce-6880-6af5-ffe538757377@siemens.com>
Date: Tue, 3 Aug 2021 09:40:11 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227EDF8B90BDC8D4B49004DF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
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

On 03.08.21 08:46, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Tuesday, August 3, 2021 12:59 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: about RTnet* smokey test skipped issue on Qemu
>>
>> On 03.08.21 06:31, Chen, Hongzhan wrote:
>>> Firstly, I found that all smokey tests including RTnet* pass on bare
>>> metal x86 platform
>>> but three RTnet* related test items  are skipped on Qemu.  After further
>>> debug, actually there is
>>> no supported rtnet device found on Qemu with current network setting
>>> when xenomai image
>>> is running over even we already enable all supported rtnet devices on
>>> xenomai so that
>>> the test is skipped on qemu.
>>>
>>> After I replace virtio-net-pci with e1000 device like [1] patch ,
>>> rt_e1000 and rtnet modules
>>> would be automatically loaded by udevd so that rtnet* test item can go
>>> on without test skipped issue.
>>
>> By default, we are only doing loopback tests in smokey, nothing that
>> requires a real NIC driver to be loaded. These are the modules loaded
>> during a test with udp:
>>
>> Module                  Size  Used by
>> rtudp                  24576  0
>> rtipv4                 49152  1 rtudp
>> rt_loopback            16384  1
>> rtnet                  81920  3 rtipv4,rtudp,rt_loopback
>>
>> You can set the rtnet_driver and rtnet_interface parameters to switch to
>> real NICs, but that is not happening during a default xeno-test run.
> 
> The problem is that rtnet module is not loaded individually by current system but because
> RT NIC device driver module depend on it and then rtnet module will be loaded when specific
> RT NIC device driver module is modprobed after triggered by udev service. That means
> We have to add and modify something to explicitly load rtnet module by default when system bootup 
> if we do not want to depends on real NIC in our case. For example we may add corresponding *.conf  
> like [3] to make  rtnet load automatically when system bootup in our case?
> 

RTnet and udp/rtpacket/loopback etc. modules are loaded by the test
cases. See testsuite/smokey/net_common/setup.c.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

