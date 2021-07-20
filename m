Subject: Re: [PATCH v2 0/3] Add callback-like mechanism before/after ptrace
 stops
References: <cover.1625777265.git.jan.kiszka@siemens.com>
 <CAFLxGvw34vnYx57bP7cYv5HgRCbmPaGNBQzeQudyU-upq+u_-w@mail.gmail.com>
 <5185508f-d8b7-fb49-de71-65c70eb33f8a@siemens.com>
 <CAFLxGvyKL0gW4Nz41vwDFG6JRWb9YMQxtuB81=24B677mVebdQ@mail.gmail.com>
 <bd64f2a7-f81a-5121-d428-54e3dde17f37@siemens.com>
 <CAFLxGvxqpKLF5xE3-D-b_kQoUtZOcpfk-MK8DAo94Sz8VCOoog@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7daf0026-aab0-0d32-b52f-3f5ce993a7ac@siemens.com>
Date: Tue, 20 Jul 2021 12:53:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxqpKLF5xE3-D-b_kQoUtZOcpfk-MK8DAo94Sz8VCOoog@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>

On 20.07.21 11:33, Richard Weinberger wrote:
> On Tue, Jul 20, 2021 at 11:27 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Then look at dovetail - ipipe will vanish. I'm pretty sure now your
>> approach faces the same issue like we do /wrt not delivering fixed-up
>> faults.
>>
>> If that is the case, we should first of all ensure that the foundation
>> is provided by the pipeline. Then we can sort out the API model and
>> implementation details at Xenomai-level.
> 
> I've heard that with dovetail Xenomai no longer sees exceptions.
> So this is a set in stone concept?

Xenomai can no longer declare exceptions resolved. It still sees them.

If we come up with a reasonable use case, I can't imagine that this is
set in stone.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

