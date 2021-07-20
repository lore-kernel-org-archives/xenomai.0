MIME-Version: 1.0
References: <cover.1625777265.git.jan.kiszka@siemens.com>
 <CAFLxGvw34vnYx57bP7cYv5HgRCbmPaGNBQzeQudyU-upq+u_-w@mail.gmail.com>
 <5185508f-d8b7-fb49-de71-65c70eb33f8a@siemens.com>
 <CAFLxGvyKL0gW4Nz41vwDFG6JRWb9YMQxtuB81=24B677mVebdQ@mail.gmail.com>
 <bd64f2a7-f81a-5121-d428-54e3dde17f37@siemens.com>
In-Reply-To: <bd64f2a7-f81a-5121-d428-54e3dde17f37@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 20 Jul 2021 11:33:53 +0200
Message-ID: <CAFLxGvxqpKLF5xE3-D-b_kQoUtZOcpfk-MK8DAo94Sz8VCOoog@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add callback-like mechanism before/after ptrace
 stops
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>

On Tue, Jul 20, 2021 at 11:27 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Then look at dovetail - ipipe will vanish. I'm pretty sure now your
> approach faces the same issue like we do /wrt not delivering fixed-up
> faults.
>
> If that is the case, we should first of all ensure that the foundation
> is provided by the pipeline. Then we can sort out the API model and
> implementation details at Xenomai-level.

I've heard that with dovetail Xenomai no longer sees exceptions.
So this is a set in stone concept?

-- 
Thanks,
//richard

