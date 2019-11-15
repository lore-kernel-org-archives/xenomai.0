Subject: Re: [PATCH] rtdm: Do not return an error from send/recvmmsg if there
 are packets
References: <02a4475e-f687-8e87-1971-1948cecfbf34@siemens.com>
 <4cdc4d6a-f073-611b-1b0e-306dfeecb176@xenomai.org>
 <34b58531-0004-ea65-0384-e338341435e4@xenomai.org>
 <fe10a1df-6846-f706-6e12-85ba252ecce1@siemens.com>
 <VI1PR05MB591796F0F7F5F3E02AFCF879F6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bed36cf7-f4d2-0a1b-b309-a8375e2e4d62@siemens.com>
Date: Fri, 15 Nov 2019 13:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591796F0F7F5F3E02AFCF879F6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, Philippe Gerum <rpm@xenomai.org>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 15.11.19 13:42, Lange Norbert wrote:
> Hello,
> 
> Just for consideration, If you can pass both error value and # of successfully sent packets out of the kernel function,
> perhaps you could return the # (if > 0) and still set errno in case of an (real) error?
> 
> It would be somewhat different to Linux, but that would not be the only difference (like theres no way to block until all msgs are sent/received).

I rather prefer finding and fixing what differentiates us from the kernel.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

