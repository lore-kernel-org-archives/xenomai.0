Message-ID: <48B2A44F.3070001@domain.hid>
Date: Mon, 25 Aug 2008 14:23:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B2994A.1050708@domain.hid> <48B2A0A3.5030308@domain.hid>
	<48B2A2B2.9070609@domain.hid> <48B2A3CE.1080205@domain.hid>
In-Reply-To: <48B2A3CE.1080205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Native skin: user space handles sharable between
 processes?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> what is the policy for the user space handles the native skin generates:
>>>> Can the user share them between processes via putting them into shared
>>>> memory (like it is allowed for some POSIX objects)?
>>>>
>>>> I'm wondering if I have to use the POSIX pattern to resolve the address
>>>> of a fast mutex: If shared, look to global heap, otherwise use
>>>> process-local heap.
>>> The posix skin does only this only the first time. If the address is
>>> local, it is computed and stored locally and never recomputed again.
>> What remains is "if (shadow->attr.pshared) ...", so a condition + some
>> bit in the shadow data structure.
>>
>> I could merged that bit into the lowest bit of the lock pointer, OK, but
>> would still have to check for it. If native defines that a handle is
>> only valid within the process that obtained it, I could skip that dance
>> altogether.
> 
> Ok. I understand what you mean. I wanted to work this around for the
> POSIX API, but let us consider a real-life fact: the process-shared
> objects are a corner-case. So, let us not spend too much sweat on it.

$CUSTOMER will like that, too: I'm going the easy way. :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

