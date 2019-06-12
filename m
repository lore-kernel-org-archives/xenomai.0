Subject: Re: IPIPE patch causes hang during initrd boot; Ubuntu 18 desktop
 system
References: <SN6PR09MB3069382F832609A66E69622A80100@SN6PR09MB3069.namprd09.prod.outlook.com>
 <4b6996dc-e425-cdfd-b95e-48c2aaa100d6@web.de>
 <SN6PR09MB3069402961C0EE909D4D891480EC0@SN6PR09MB3069.namprd09.prod.outlook.com>
 <3157ee8b-bf42-1e60-c5be-1e0dcc79ac7d@xenomai.org>
 <SN6PR09MB3069F2FFD8F0CD778404F4FF80EC0@SN6PR09MB3069.namprd09.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ce770a80-7bc8-fe10-2457-329a054ebdad@xenomai.org>
Date: Wed, 12 Jun 2019 16:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <SN6PR09MB3069F2FFD8F0CD778404F4FF80EC0@SN6PR09MB3069.namprd09.prod.outlook.com>
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
To: "Proctor, Frederick M. (Fed)" <frederick.proctor@nist.gov>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "jan.kiszka@web.de" <jan.kiszka@web.de>

On 6/12/19 3:55 PM, Proctor, Frederick M. (Fed) wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> Sent: Wednesday, June 12, 2019 9:19 AM
>> To: Proctor, Frederick M. (Fed) <frederick.proctor@nist.gov>; Jan Kiszka
>> <jan.kiszka@web.de>; xenomai@xenomai.org
>> Subject: Re: IPIPE patch causes hang during initrd boot; Ubuntu 18 desktop
>> system
>>
>>
>> This may be a timer issue. You could try booting with xenomai.state=stopped
>> on the kernel command line. If that boots as I suspect, then you can try
>> issuing the following command:
>>
>> $ corectl --start
>>
> 
> I gave the kernel command line option "xenomai.state=stopped" but had the same symptom, a hang immediately on the loading of the initrd. 
> 

Ok. The output of /proc/timer_list and /proc/interrupts in the bootable
case (CONFIG_IPIPE alone) may help in debugging this.

-- 
Philippe.

