MIME-Version: 1.0
References: <20220406210614.17715-1-richard@nod.at>
 <6fabb15e3e078aae8bc23d1b4970f484e03e9943.camel@siemens.com>
In-Reply-To: <6fabb15e3e078aae8bc23d1b4970f484e03e9943.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 7 Apr 2022 10:04:24 +0200
Message-ID: <CAFLxGvwpPFtdxjBrQ4cEpbniHTX9YmZ-pmWCtR2ZOutPuD82HQ@mail.gmail.com>
Subject: Re: [PATCH] Remove __work from PIPELINE_INBAND_WORK_INITIALIZER
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "richard@nod.at" <richard@nod.at>

On Thu, Apr 7, 2022 at 10:03 AM Bezdeka, Florian via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi Richard,
>
> On Wed, 2022-04-06 at 23:06 +0200, Richard Weinberger via Xenomai
> wrote:
> > ipipe took a copy of the queued work, __work was used to determine how much
> > bytes had to get copied.
> > With dovetail no copy as taken and the __work parameter is no longer
>                         ^^ is
> > useful, so we can get rid of it.
>
> The rest LGTM. Commit message could be fixed up on merge as long as Jan
> does not insist on sending out a v2.

I'll happily send a v2. :-)

-- 
Thanks,
//richard

