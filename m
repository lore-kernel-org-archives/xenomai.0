Subject: Re: TSN support on xenomai
References: <SG2PR04MB325361212B0F13BA9DE98BC0A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <263bfd52-638e-1205-dc57-c0fb773b0acf@numalliance.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dee89c0f-c026-33c2-da13-42d090f58d6c@siemens.com>
Date: Tue, 16 Jun 2020 10:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <263bfd52-638e-1205-dc57-c0fb773b0acf@numalliance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, xenomai@xenomai.org

On 16.06.20 10:55, Stéphane Ancelot via Xenomai wrote:
> Hi,
> 
> This is natively supported in standard linux kernel
> 

Right. What is missing it linking the Xenomai timebase with that of the
kernel so that we would benefit from Linux doing the sync for us already.

Jan

> Regards,
> 
> S.Ancelot
> 
> Le 16/06/2020 à 10:17, Peter Wong via Xenomai a écrit :
>> Hi,
>>
>> Any plan to support below TSN standards on xenomai?
>>
>> 802.1AS - Timing and Synchronization
>> 802.1Qbv - Enhancements for Scheduled Traffic
>> 802.1Qbu - Frame Preemption
>> 802.1Qav - Forwarding and Queuing
>>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

