Subject: Re: [PATCH] mercury: Fix include path for cobalt/wrapper.h
References: <18fee8f3-6d25-0e71-5f7d-737c3c34b293@siemens.com>
 <87pn10id25.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cc197f53-7215-e0e7-aa21-30642ff07f2a@siemens.com>
Date: Tue, 16 Feb 2021 10:44:24 +0100
MIME-Version: 1.0
In-Reply-To: <87pn10id25.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>

On 16.02.21 10:20, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Long broken, likely not practically relevant. But now that we known it,
>> let's fix it: There is no mercury/wrapper.h, but we have that file under
>> mercury/copperplate.
>>
> 
> A better fix would be to drop copperplate/wrappers.h. This is an
> internal header, which has no in-tree user. This explains why Mercury
> builds flawlessly even if that file would attempt to pull in a
> non-existent header.

Fine with me - I just wasn't sure about the role of this header.

Patch will follow.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

