References: <d3f6995a-1d45-d262-21a0-97a51253da91@alaxarxa.net>
 <e665e5ab-796f-8aac-997c-33b88079d27c@xenomai.org>
 <a30fcf3f-ad18-0210-ad51-6a0ab0b73872@alaxarxa.net>
 <bd2c4a53-33cf-b4aa-79c5-243fe1d5b660@xenomai.org>
 <275c60a3-db60-fdb7-7ffc-96988ca50913@alaxarxa.net>
 <a58f4cc0-0e42-c1d6-71e6-c18b00d1076d@xenomai.org>
 <52b92049-fcaa-8d48-8e89-516fc6f0ab21@alaxarxa.net>
 <6d2aee3e-2ddc-3008-f00e-a350030efcf3@xenomai.org>
 <bc03b087-9547-64f3-ab80-f79845a997d1@alaxarxa.net>
 <607eb8e7-c311-bd26-0bf3-7a92ed97e48e@xenomai.org>
 <9555c324-187c-63aa-ff8c-56ce8214265d@alaxarxa.net>
 <469a8021-9bc8-8c97-db67-6b8d7578686c@xenomai.org>
 <7a8fe24f-3db5-3b30-a080-d4207b61052d@alaxarxa.net>
 <c935cb9d-c25d-a23c-2e3b-f4f38599d247@xenomai.org>
 <443cc691-bfa2-8916-d70f-30c411c44922@alaxarxa.net>
 <088f4b3f-f1a9-f10f-7a6e-a7472be2e53d@xenomai.org>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <aaf54c30-5461-2833-c766-27a992b8ead1@alaxarxa.net>
Date: Fri, 24 Nov 2017 15:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <088f4b3f-f1a9-f10f-7a6e-a7472be2e53d@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Testing 3.0.6 (Was Re: Cannot initialize TLSF memory
 manager)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 24/11/17 15:21, Philippe Gerum wrote:
> On 11/24/2017 01:24 PM, Leopold Palomo-Avellaneda wrote:
>> On 24/11/17 13:22, Philippe Gerum wrote:
>>> On 11/24/2017 01:10 PM, Leopold Palomo-Avellaneda wrote:
>>>> On 24/11/17 13:04, Philippe Gerum wrote:
>>>>> On 11/24/2017 01:01 PM, Leopold Palomo-Avellaneda wrote:
>>>>>> On 24/11/17 11:55, Philippe Gerum wrote:
>>>>>>> On 11/24/2017 11:34 AM, Leopold Palomo-Avellaneda wrote:
>>>>>>>> Hi (again)
>>>>>>>>
>>>>>>>> running cross-link I got that:
>>>>>>>>
>>>>>>>>>> with my user
>>>>>>>>>>
>>>>>>>>>> ./cross-link
>>>>>>>>>> mem=0x7f0d630488e0, alloc_size=8192
>>>>>>>>>> Init memory pool returns 1808 bytes
>>>>>>>>>> Running after ...
>>>>>>>>>> sysregd:
>>>>>>>>>> create_directory_recursive("/var/run/xenomai/leopold.palomo/anon@19479"):
>>>>>>>>>> Permission denied
>>>>>>>>
>>>>>>>> ....
>>>>>>>>
>>>>>>>>
>>>>>>>> the permissions are:
>>>>>>>> $ ls -la /var/run/xenomai/
>>>>>>>> total 0
>>>>>>>> drwxr-xr-x  3 root root  60 nov 23 16:03 .
>>>>>>>> drwxr-xr-x 24 root root 860 nov 24 11:12 ..
>>>>>>>> drwxr-xr-x  2 root root  40 nov 24 11:12 root
>>>>>>>>
>>>>>>>> so, IMHO this folder should belongs to xenomai group and permisions g+rw. Right?
>>>>>>>
>>>>>>> There is no such official "Xenomai" group, I mean this is only a
>>>>>>> template in some rule file to illustrate the fact that one could
>>>>>>> actually assign rt privileges to a user group, instead of running apps
>>>>>>> as a sudoer. That could be any group you are willing to mention in the
>>>>>>> xenomai.allowed_group kernel parameter on the kernel command line, or no
>>>>>>> group at all. This is a matter of local installation.
>>>>>>
>>>>>> Ok, the debian package creates it. I have xenomai.allowed_group=113 in the grub.
>>>>>> So, the packaging (installation should solve it).
>>>>>>
>>>>>>>>
>>>>>>>> Changing the permissions manually solved it. It's something about the packaging
>>>>>>>> or the library?
>>>>>>>>
>>>>>>>
>>>>>>> This is not a library issue.
>>>>>>
>>>>>> Ok, mine. Packaging problem.
>>>>>>
>>>>>>>>
>>>>>>>>>> leopold.palomo@bmm3 ~/xenomai/xenomai-3.0.6/system/demo$ sudo ./cross-link
>>>>>>>>>> mem=0x7fc9e73f88e0, alloc_size=8192
>>>>>>>>>> Init memory pool returns 1808 bytes
>>>>>>>>>> Running after ...
>>>>>>>>>> mem=0x7f2e146318e0, alloc_size=8192
>>>>>>>>>> Init memory pool returns 1808 bytes
>>>>>>>>>> Running after ...
>>>>>>>>>> main : can't open /dev/rtdm/rtser0 (write), No such file or directory
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Not being able to open rtser0 is yet another kind of problem: the uart
>>>>>>>>> driver is not up and running, so the devices were not created. crosslink
>>>>>>>>> definitely needs such driver.
>>>>>>>>
>>>>>>>> Yes, I don't have rtser0 entry in /dev/rtdm/. Who does create it?
>>>>>>>>
>>>>>>>
>>>>>>> Any RTDM driver from kernel/drivers/serial, depending on your platform.
>>>>>>
>>>>>> Well, I have /dev/rtdm/* entries but not that one. Is this normal?
>>>>>>
>>>>>
>>>>> Do you have any RTDM-based serial driver enabled in Kconfig?
>>>>>
>>>>
>>>> xeno_16550A
>>>>
>>>> I have all modules that I can.
>>>>
>>>> <M> 16550A UART driver
>>>>                               Hardware access mode (Any access mode)  ---> (X)
>>>> Any access mode
>>>>
>>>> [*] PCI board support
>>>>                            [*]   Moxa PCI boards
>>>>
>>>> CONFIG_XENO_OPT_RTDM_COMPAT_DEVNODE=y
>>>> CONFIG_XENO_DRIVERS_AUTOTUNE=m
>>>>
>>>> #
>>>> # Serial drivers
>>>> #
>>>> CONFIG_XENO_DRIVERS_16550A=m
>>>
>>> missing modprobe?
>>>
>>
>> $ lsmod | grep xeno
>> xeno_16550A            28672  0
>> xeno_autotune          24576  0
>> xeno_analogy           57344  0
>> xeno_rtdmtest          16384  0
>> xeno_udd               16384  0
>> xeno_switchtest        20480  0
>> xeno_rtipc             49152  0
>> xeno_can_peak_pci      16384  0
>> xeno_can_sja1000       20480  1 xeno_can_peak_pci
>> xeno_can               32768  2 xeno_can_peak_pci,xeno_can_sja1000
>>
>>
>>
> 
> It looks like the driver was not given the proper parameters at load up,
> specifically the io= or mem= information.
> 
> http://xenomai.org/serial-16550a-driver/ may help.
> 

ok,

I have followed this page and got:

DMAR: DRHD: handling fault status reg 2
[   90.453076] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault index 0 [fault
reason 37] Blocked a compatibility format interrupt request
root@bmm3:~# modprobe xeno_16550A io=0xf0a0 irq=19


Anyway, next week I hope to be more lucky. Thanks for all,

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

