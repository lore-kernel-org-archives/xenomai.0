Subject: Re: [PATCH 1/3] cobalt uapi: Introducing new feature flag for
 settime64 availability
References: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
 <20201113115932.276959-1-florian.bezdeka@siemens.com>
 <20201113115932.276959-2-florian.bezdeka@siemens.com>
 <a3b9965d-57d1-6d41-4cac-5e462379a66d@siemens.com>
 <0ea225343dac0d572f968955af1ebff988a210ef.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fb9270fc-c649-f39e-4b3f-0f3c3dd8e9fe@siemens.com>
Date: Sat, 14 Nov 2020 08:33:52 +0100
MIME-Version: 1.0
In-Reply-To: <0ea225343dac0d572f968955af1ebff988a210ef.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>

On 13.11.20 17:18, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Fri, 2020-11-13 at 14:25 +0100, Jan Kiszka wrote:
>> On 13.11.20 13:00, florian.bezdeka--- via Xenomai wrote:
>>> From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>
>>> Adding a new feature flag to allow the library asking for settime64
>>> support. That will allow the library to use the new system call if
>>> it
>>> is available / supported by the kernel.
>>>
>>
>> As proposed in the other thread, we should state that this flag is
>> supposed to be dropped on the next major ABI revision update.
> 
> I agree. The ABI revision of all supported architectures has to be
> incremented when removing this flag.
> 
> How do we make sure that the necessary steps are taken once the next
> major release process starts? Is there some kind of "next major branch"
> available where we could apply patches to after settime64 stuff was
> merged to "next"?

next and master are currently "stable 3.1.x". There is no branch for a
next major release yet. But you could leave a comment at a line that
defines the ABI revision and, thus, needs to be touched on next bump.

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


