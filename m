Subject: Re: What is the purpose of corectl
References: <VI1PR05MB59172C8A7C452EBC0D1A81AAF6650@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a15593e7-0cb2-ae7d-fc56-71048fba537d@siemens.com>
Date: Mon, 13 Jul 2020 19:17:51 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59172C8A7C452EBC0D1A81AAF6650@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

On 10.07.20 13:56, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I just found the corectl tool (and the related syscall). After a stop, all threads previously using cobalt services end up zombified,
> apparently never getting reaped. (Only useful thing is to reboot then IMHO).
> 

I personally haven't used corectl for ages, it's not part of regular 
testing, it's not unlikely that it silently broke.

> Maybe if this tool could shutdown everything cleanly, I would run this before unloading modules like rtnet as safety measure (unloading rtnet will just block if its used).
> 

RTnet should trigger terminations for resource-holding tasks and also 
drivers by now. That is unrelated to corectl and was addressed by 
Philippe a while back. Maybe not completely, though.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

