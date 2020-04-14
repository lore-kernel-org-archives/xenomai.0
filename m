MIME-Version: 1.0
References: <89d53aa4-dce0-a519-8f53-09b7e1733208@siemens.com>
 <CAFLxGvzPB=BWy8Hy3-Ecw8YyLFVwUtUZ6G5mzXufM=KZQ7hbiQ@mail.gmail.com>
 <76ce4148-ea3c-fd50-f300-a019b17e8f01@siemens.com>
In-Reply-To: <76ce4148-ea3c-fd50-f300-a019b17e8f01@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 14 Apr 2020 11:24:19 +0200
Message-ID: <CAFLxGvwVq=6xvbLFS=GEdG1aZjFFzVssD6X0rrwS5mJhUr3oPQ@mail.gmail.com>
Subject: Re: [PATCH] ipipe: tracer: Hook into panic path just like ftrace does
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
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Apr 14, 2020 at 11:18 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Actually, I just copied over and thought of this panic trace as a
> replacement of ftrace because the latter is not pipeline-aware, lacking
> state information about it. I don't see the use case of have both
> enabled yet, do you?

The only use case I can think of is a case where I don't know at all
what is happening
on my system and therefore almost all debugging mechanisms are enabled.

-- 
Thanks,
//richard

