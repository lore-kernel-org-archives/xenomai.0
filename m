Subject: Re: [PATCH] cobalt: remove call to sigprocmask
References: <20190712111849.25670-1-norbert.lange@andritz.com>
 <debb723e-9470-8911-02ec-fce4aefa1546@siemens.com>
 <VI1PR05MB59175FED00839E697F933EDCF6F20@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f6abf89c-f1a4-6232-4b5f-eb675f07f32e@siemens.com>
Date: Fri, 12 Jul 2019 16:40:27 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59175FED00839E697F933EDCF6F20@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 12.07.19 15:26, Lange Norbert via Xenomai wrote:
> 
> 
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Jan Kiszka
>> via Xenomai
>> Sent: Freitag, 12. Juli 2019 15:07
>> To: Norbert Lange <nolange79@gmail.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH] cobalt: remove call to sigprocmask
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 12.07.19 13:18, Norbert Lange via Xenomai wrote:
>>> sigprocmask should not be used in multithreaded applications, doing so
>>> is "unspecified".
>>
>> Is this more than cosmetic on Linux? Then it should be documented here
>> because we shipped the change in 3.0.9, and if that may have caused
>> regressions, users should know.
> 
> There is no practical issue to be expected, AFAIK with NPTL at least.
> The only issue could be, that libpthread is not pulled in (might need to run some setup), but that’s ensured with libcobalt.

OK, applied to next. Will add to stable as well, just to avoid confusion.

> 
> Sorry for the mess, must have send a stale patch in the first place (always get problems with whitespace issues).
> 

No problem.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

