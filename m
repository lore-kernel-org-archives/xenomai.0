Subject: Re: stalled head domain with 3.1rc4
References: <VI1PR05MB5917452476FF30146D701888F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB591740A31653FE8542171311F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB5917FB6355396C28F99B79EDF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <978c3a94-ae94-3982-3fdc-22e6f28d4aa4@siemens.com>
 <VI1PR05MB5917084161925CAB5627714DF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <6ef04e88-b7aa-2025-3ec8-ec11e8ff8ec5@siemens.com>
 <VI1PR05MB591737DED93D2292E8CEB058F6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <07e9ac3c-789e-f399-edd3-cf7d7e8db4e1@siemens.com>
 <VI1PR05MB5917F25EE52D5E9C8F43B8B0F6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d5809aba-5e62-212e-5519-ac024e4862fb@siemens.com>
Date: Mon, 16 Dec 2019 14:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917F25EE52D5E9C8F43B8B0F6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

On 16.12.19 14:03, Lange Norbert wrote:
>> I still need to find the actually used pattern in the latest kernel.
>> It's not the one I suspected.
>>
>> Do I have your config for this setup already?
> 
> Attached now

Analyzing... not very different to mine /wrt tracing.

Can you reproduce the issue by running only some of the Xenomai test 
cases while turning on tracing?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

