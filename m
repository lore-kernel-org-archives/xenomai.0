Message-ID: <20520308-b588-f1db-e9ff-bc65087a6fd2@siemens.com>
Date: Wed, 13 Apr 2022 20:58:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Revive alchemy tests
Content-Language: en-US
References: <20220408080401.22235-1-richard@nod.at>
 <1e9b7d24-a1db-7849-568d-36756584570a@siemens.com>
 <529434956.250361.1649859241634.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <529434956.250361.1649859241634.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@xenomai.org>

On 13.04.22 16:14, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> An: "richard" <richard@nod.at>, "xenomai" <xenomai@xenomai.org>
>> Gesendet: Mittwoch, 13. April 2022 14:56:16
>> Betreff: Re: [PATCH 0/6] Revive alchemy tests
> 
>> On 08.04.22 10:03, Richard Weinberger via Xenomai wrote:
>>> This patch series is a first attempt to integrate the currently abandoned
>>> alchemy tests into Xenomai's test suite.
>>> Since each test assumes running as own process a test driver is needed
>>> which executes each tests separately.
>>> The driver makes use of the smokey framework.
>>>
>>
>> A valuable step forward. Just wondering, before actually taking it, if
>> that can be a pattern for the rest as well (psos, vxworks) or if there
>> is anything that should be considered in addition to allow them
>> following later on.
> 
> I think the same approach will work for psos and vxworks too.
> If you're fine with the proposed approach I'd prepare a v2 of this series
> with psos and vxworks included.

Thanks! Will have a look and let you know if I have remarks on details
as well.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

