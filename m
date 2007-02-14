Message-ID: <b647ffbd0702140410r14617bdbt58f60cd9049c52af@domain.hid>
Date: Wed, 14 Feb 2007 13:10:56 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
In-Reply-To: <45D2E86C.2010200@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D25145.3000407@domain.hid>
	<45D2CE27.5040303@domain.hid> <45D2DD6E.5030800@domain.hid>
	<45D2E468.3080402@domain.hid> <45D2E86C.2010200@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

On 14/02/07, Markus Franke <Markus.Franke@domain.hid> wrote:
> Jan Kiszka wrote:
> > Of course, irqloop runs in *primary* mode to be able to handle the
> > events deterministically. So it is not directly affected by CONFIG_PREEMPT.
>
> If I start irqloop in User-Mode, a thread is simply created via Linux
> system call pthread_create() which interacts with the
> xeno_irqbench-driver via ioctl(). But then I don't understand why
> irqloop is running in Primary (Xenomai) Mode? Because of the interaction
> with the RTDM-based driver?
> I am just wondering because I can't see something like rt_task_create().

There is life beyond the native skin. e.g. the posix one.

After all, Xenomai is all about skins (layers implementing various RT
API interfaces).

So pthread_create() as well as ioctl() you may see in irqloop are
implemented ("shadowed") by the posix skin.


-- 
Best regards,
Dmitry Adamushko

