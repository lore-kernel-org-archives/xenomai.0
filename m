Subject: Re: [PATCH v2] ci: Update build environment to Ubuntu 18.04
References: <f2377f95-78fc-4c83-0eb0-204babeb51e6@siemens.com>
 <08337573-b545-aff2-315b-174504c4caf2@siemens.com>
 <38ca40f7-fcde-ceaa-1c91-f4b809a9e0a6@siemens.com>
 <52277842.1e8b158zFm@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2bf26a72-b33f-f461-0cae-b01d549846f4@siemens.com>
Date: Tue, 3 Sep 2019 15:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <52277842.1e8b158zFm@omoikane>
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
To: "steven.seeger flightsystems.net" <steven.seeger@flightsystems.net>
Cc: Xenomai <xenomai@xenomai.org>

[moving to the right list - did a mistake on first posting]

On 03.09.19 15:01, steven.seeger flightsystems.net wrote:
> On Monday, September 2, 2019 4:10:52 AM EDT Jan Kiszka wrote:
>> On 02.09.19 10:09, Jan Kiszka wrote:
>>> Steven, any chance we get ppc to a newer gcc? Are the issues
>>>
>>> https://travis-ci.com/xenomai-ci/xenomai/jobs/229976797#L786
>>> https://travis-ci.com/xenomai-ci/xenomai/jobs/229922504#L3071
>>>
>>> fixed in newer 4.14 releases?
> 
> Strange. I build with gcc 7.3.0. I was going to try and get to some ppc stuff
> this week. I need to do some updates on the vendor board I have with 4.19 and
> then I will test with xenomai. Hopefully I can get to that later this week.
> 
> I have seen the error with missing symbol _restgpr_31_x but it's been so long
> I forget what the resolution was.

Maybe this helps:

https://lore.kernel.org/patchwork/patch/873596/

Do we have that change in the kernel we build? If not, can we get it by updating 
to a more recent 4.14 kernel?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

