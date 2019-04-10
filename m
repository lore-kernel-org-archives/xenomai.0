Subject: Re: (unknown)
References: <20190410111408.18824-1-norbert.lange@andritz.com>
 <d49a86dd-c391-c403-27ef-a6420cd094a7@siemens.com>
 <VI1PR05MB5917B5956F2E9365F10D6539F62E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b4014ca5-c237-6b52-2a26-6ae69f07417b@siemens.com>
Date: Wed, 10 Apr 2019 16:47:50 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917B5956F2E9365F10D6539F62E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, Xenomai <xenomai@xenomai.org>

[re-adding the list]

On 10.04.19 16:44, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Jan Kiszka via
>> Xenomai
>> Sent: Mittwoch, 10. April 2019 16:36
>> To: Norbert Lange <nolange79@gmail.com>; xenomai@xenomai.org
>> Subject: Re: (unknown)
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR ATTACHMENTS.
>>
>>
>> On 10.04.19 13:14, Norbert Lange via Xenomai wrote:
>>> V3 of the patchset, corrected many checkstyle issues, simplified
>>> condvar autoinit.
>>>
>>> I did not use ARRAY_SIZE, as that would need another include.
>>>
>>
>> All applied now. Patch 1 was not cleanly based on next, though. I think some
>> local style cleanup was missing.
> 
> I based all patches on master, thought this is the primary development branch?
> 

Line 566 in lib/cobalt/mutex.c had a trailing tab, your patch context did not, 
and that made the application fail. Maybe that was removed while transporting 
the patch into your mail client - better use git send-email in that case.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

