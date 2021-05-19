Subject: Re: y2038 dependency to wip/dovetail
References: <d9592ffe-9cd8-34dd-1101-fed34aeb49ac@siemens.com>
 <674eabdc-cce4-e1e3-83be-bf99de174d75@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <05c2fdce-16e2-49fa-e582-31e743e2f487@siemens.com>
Date: Wed, 19 May 2021 19:41:48 +0200
In-Reply-To: <674eabdc-cce4-e1e3-83be-bf99de174d75@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Song Chen <chensong_2000@189.cn>

On 19.05.21 19:23, Jan Kiszka wrote:
> On 19.05.21 17:34, Florian Bezdeka wrote:
>> Hi Jan,
>>
>> as already mentioned this morning during Xenomai community call, the
>> y2038 stuff has one more dependency that is not in next yet:
>>
>> We need this commit from wip/dovetail:
>>
>> 336f9d67e5a4 ("lib/cobalt: dovetail: use clock_gettime() vcall for reading timestamps")
>>
> 
> Ok, but that is for mechanical patch-collision reasons, not for
> functional ones, right?

Right. The mentioned patch introduces a second place where the
sc_cobalt_clock_gettime syscall is used, so we have to care about them both.

> 
> Might be trickier to reorder the series reasonably for that.

The other way around would be adding a helper that we could introduce on
top of next and the mentioned patch has to be reworked a bit to use the
helper at both locations.

> 
> Jan
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

