Subject: Re: [xenomai-images] smokey with qemu-arm and qemu-arm64 stalls gdb
 test
References: <10555689-1a2e-ad9b-d502-1d6696ea358e@siemens.com>
 <9aa0462d-b75b-a909-335f-406453140abd@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <1274d6ea-f43d-e7e7-5ad8-07e6af07a4a5@siemens.com>
Date: Wed, 14 Aug 2019 12:21:06 +0200
MIME-Version: 1.0
In-Reply-To: <9aa0462d-b75b-a909-335f-406453140abd@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 8/14/19 11:46 AM, Jan Kiszka wrote:
> On 14.08.19 10:02, Quirin Gylstorff wrote:
>> Hi,
>>
>> I tested smokey with qemu-amd64, qemu-arm and qemu-arm64 from 
>> xenomai-images with the dh_strip patch active against master and had 
>> following results:
>> qemu-amd64 - smokey run
>> qemu-arm and qemu-arm64 stall with the attached output.
>>
>> Kind regards,
>> Quirin
> 
> Which kernel version(s) are showing this issue on arm[64]?
> 

On arm:
Linux demo 4.14.85+ #1 SMP Tue Aug 13 16:57:48 UTC 2019 armv7l GNU/Linux
On arm64:
Linux demo 4.14.78+ #1 SMP PREEMPT Wed Aug 14 07:11:31 UTC 2019 aarch64 
GNU/Linux

Quirin

