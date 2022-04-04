MIME-Version: 1.0
References: <20220403144800.1776095-1-rpm@xenomai.org>
In-Reply-To: <20220403144800.1776095-1-rpm@xenomai.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 4 Apr 2022 21:19:52 +0200
Message-ID: <CAFLxGvzvAosUFxxBD24Rk92iSN=n5yw2PCYW34mE9_yvsfM7ew@mail.gmail.com>
Subject: Re: [PATCH] tick: irq_pipeline: fix proxying of a broadcast device
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sun, Apr 3, 2022 at 4:48 PM Philippe Gerum via Xenomai
<xenomai@xenomai.org> wrote:
>
> From: Philippe Gerum <rpm@xenomai.org>
>
> When a proxy device is taking control of a (real) broadcast device, we
> have to:
>
> - remove the real device from the clockevents_list
> - keep that device ticking, i.e. no shutdown
>
> Fix tick_check_new_device() accordingly.
>
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>

I'm not an expert in this area but your change makes sense to me.

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

