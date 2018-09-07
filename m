References: <6E41044F-5CEE-483A-8472-54CD2B32D561@korgrd.com>
 <aa492d6d-704e-fa38-04bf-5383c72e0b5b@siemens.com>
 <BF5542CE-8DA4-490F-8C75-B8F007C711C8@korgrd.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <482a8745-cf85-a98f-e631-23ce3ba9bf8b@siemens.com>
Date: Fri, 7 Sep 2018 18:24:03 +0200
MIME-Version: 1.0
In-Reply-To: <BF5542CE-8DA4-490F-8C75-B8F007C711C8@korgrd.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [documentation]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>, Xenomai <xenomai@xenomai.org>

Hi Steve,

[re-adding the list]

On 2018-09-06 18:43, Steve Pavao wrote:
> Jan,
> 
> Thanks for that fix.
> 
> I also just noticed the table of contents on that page doesn’t work in either Chrome or Safari.  User can’t click links and go to that section successfully.
> 
> Also many of the links on the page that refer to other sections on the pagedon’t work.
> 
> If all those section links worked it would actually be quite helpful to the learning process.

Thanks for the heads-up. I suppose we need to dig through the details 
and sort them out one by one. Contributions would be very welcome, we 
just have the administrative limitation that we cannot grant access to 
the wiki to the public or even to a larger group of individuals.

I've chatted with Philippe and he suggested to work against the wiki git:

     git://gitlab.denx.de:/xenomai.wiki.git

So... if you (or anyone else) would like to fix some of those finding, 
we would be very happy to merge patches against that repo! Just send 
them, maybe tagged with [wiki], to the mailing list as if they were code 
fixes.

Thanks in advance!
Jan

> 
> - Steve
> 
> 
>> On Sep 6, 2018, at 11:30 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 2018-09-06 17:16, Steve Pavao wrote:
>>> MInor issue following a link on this page:
>>> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_To_Xenomai_POSIX <https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_To_Xenomai_POSIX>
>>> "This description of Xenomai is a bit sketchy, for more information, you
>>> should have a look at the Life with Adeos article.”
>>> Unable to link to “Life with Adeos” article due to lack of GitLab account.  It brings me to a GitLab login screen.  I don’t have an account.
>>> It was easy enough to find the article elsewhere on the web, however.
>>
>> Fixed, and another one in the same article. Thanks for the hint!
>>
>> Jan
>>
>> -- 
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

