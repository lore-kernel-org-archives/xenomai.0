Subject: Re: Static build of rtnet
References: <VI1PR05MB59174B9E7E2B5EC8BED7DDA5F68C0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d86f04ac-dee5-b940-7569-cfff1e404589@siemens.com>
Date: Tue, 17 Sep 2019 09:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59174B9E7E2B5EC8BED7DDA5F68C0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 16.09.19 11:13, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I havent tested this in a while, but building rtnet static will crash the kernel when this module initializes.
> With the various fixes and cleanups in master/next (like rtdm_available) that might be worth a look?
> 
> I would hope to build a static kernel one day, and so far there are 2 roadblocks:
> 
> -       rtnet (+ rtpacket) crashing when built statically
> 
> -       symbol nameclashes with linux + rt drivers enabled (I could work on fixing that for rt_igb atleast)
> 

Do you mean removing the "depends on m"? Possibly, that moves the initialization 
order in a way that causes troubles. I also just added another case that 
exploits the module [1], but that would be solvable. More critical is 
understanding the crashes.

Jan

[1] https://xenomai.org/pipermail/xenomai/2019-September/041583.html

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

