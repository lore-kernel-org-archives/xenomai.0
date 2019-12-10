Subject: Re: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xenomai)
References: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
 <CAFLxGvz9X3qtz-tK6egDLuNn2OB6iYuy__-th=61mAbHynV+qg@mail.gmail.com>
 <6858a3b5-adbc-c65f-c11c-92297d4dd8f7@siemens.com>
 <2008645939.112092.1575975265668.JavaMail.zimbra@nod.at>
 <45cda878-fa53-c1b2-881b-06d52e66a32a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4298ac73-340f-5699-7176-ef48b5ab2294@xenomai.org>
Date: Tue, 10 Dec 2019 19:03:22 +0100
MIME-Version: 1.0
In-Reply-To: <45cda878-fa53-c1b2-881b-06d52e66a32a@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger <richard@nod.at>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, xenomai <xenomai@xenomai.org>

On 12/10/19 2:08 PM, Jan Kiszka wrote:
> On 10.12.19 11:54, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> Do you see the same issue with ipipe-core-4.19.82-arm-6 (and Xenomai 3.1)?
>>
>> Since my board does not boot with 4.19, I cannot tell. Still had no time
>> to figure what is going on.
>>
>> Is this a known issue with a fix in newer ipipe releases?
> 
> Can't tell for ARM - Philippe?
> 

I-pipe 4.14 was the first version to officially support PROVE_LOCKING
for arm and arm64. I did a quick check with 4.14.110 over i.MX6QP, and
got no issue running switchtest.

On the other hand, kprobe support has not been considered so far (not
even checked here). Since kprobing affects fault and IRQ handling, this
may have something to do with such splat.

-- 
Philippe.

