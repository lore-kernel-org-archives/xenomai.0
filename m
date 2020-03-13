Subject: Re: Namespace pollution due to compiler.h in Xenomai 3.1
References: <CAFLxGvw70Rm88zfFXRqLv2_qJkd=k_C-mYxLCX0qnFwCYyGZyg@mail.gmail.com>
 <b5fe4180-4d04-3031-6d12-b7c9ccfa22ad@siemens.com>
 <20200313141229.7C87C24003E@gemini.denx.de>
 <20200313142248.2B7CE24003E@gemini.denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c891070d-ca78-97ed-8a39-faab4d5f34b4@siemens.com>
Date: Fri, 13 Mar 2020 15:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <20200313142248.2B7CE24003E@gemini.denx.de>
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
To: Wolfgang Denk <wd@denx.de>, Wolfgang Denk via Xenomai <xenomai@xenomai.org>

On 13.03.20 15:22, Wolfgang Denk wrote:
> Hi,
> 
> In message <20200313141229.7C87C24003E@gemini.denx.de> I wrote:
>>
>>>> We noticed because out application also defines __packed...
>>>
>>> That's indeed bad style which I didn't realize so far. All those
>>> short-hands should be prefixed, e.g. like qt does (Q_NORETURN, Q_LIKELY
>>> etc.).
>>
>> Was there not a rule in ANSI C that the use of double underscores in
>> identifiers is reserved compiler internal definitions?  I would expect
>> that it's ok in compiler.h but incorrect in any application headers.
> 
> For example C99 section 7.1.3 (see [1]):
> 
>          All identifiers that begin with an underscore and either an
>          uppercase letter or another underscore are always reserved
>          for any use.
> 
> [1] https://busybox.net/~landley/c99-draft.html#7.1.3
> 
> 
> So IMHO any definition of __packed... in application code is not
> standard conforming.
> 

That is correct as well and should be fixed in their application.

Still, I don't think Xenomai should use such defines on its own when 
other libs avoid this as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

