Message-ID: <bc4264770702250541u5b07669exe178837f45a7f06@domain.hid>
Date: Sun, 25 Feb 2007 13:41:34 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] rt_timer_start()
In-Reply-To: <45E19067.1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702250528u1f7a4736s919eb998d064289b@domain.hid>
	<45E19067.1@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Ah Ok.

Thanks.

Roland.

On 2/25/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> roland Tollenaar wrote:
> > Hi,
> >
> > The Native API tour dictates that rt_timer_start() MUST be called in
> > all userspace applications that access the rt_timer.
> >
> > It displays and example very similar to the example trivial_periodic.c
> >
> > howeve trivial_periodic.c does not call the rt_timer_start() even
> > though it does have calls such as rt_timer_read.
> >
> > and it seems to work.
> >
> > Why is that?
>
> That tour was written before rt_timer_start() got deprecated.
>
> Always check the latest API documentation when something appears
> contradictory.
>
> Jan
>
>
>

