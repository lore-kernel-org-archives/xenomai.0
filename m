Subject: Re: CONFIG_XENO_DRIVERS_NET_CHECKED not possible to enable
References: <VI1PR05MB591714E870DB124146B05FB4F6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <743f7e3a-46ea-69a3-f4e2-b42395540d35@siemens.com>
Date: Tue, 17 Dec 2019 07:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591714E870DB124146B05FB4F6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

On 16.12.19 18:49, Lange Norbert via Xenomai wrote:
> Seems to me like a lot instances of XENO_DRIVERS_NET_CHECKED should be renamed to XENO_DRIVERS_RTNET_CHECKED
> 

Good catch, was always wrong. But as the higher-level config is called 
XENO_DRIVERS_NET, we should rather rename XENO_DRIVERS_RTNET_CHECKED.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

