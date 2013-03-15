MIME-Version: 1.0
In-Reply-To: <e21b6c3989fe9c98508a.1363359173@devws108>
References: <e21b6c3989fe9c98508a.1363359173@devws108>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 15 Mar 2013 18:14:09 +0100
Message-ID: <CAMJ=MEdFSN+QzY+iduGC7E9OCXdJoZUbZEH1BRCE-+fA3y0DvA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [PATCH] psos skin: time_slice is specified in ticks
	instead of ns
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Fri, Mar 15, 2013 at 3:52 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
> The pSOS skin uses a default timeslice of 1000 sec.
> In comments it is mentioned that the value is specified in ms
> while the place where the variable is used assumes that it is
> in ticks.
>
> Rename time_slice to time_slice_in_ticks to make this clear.
> Additionally, increase the timeslice from the intended 1ms
> to 5ms to reduce the overhead a bit.
>
> Signed-off-by: Ronny Meeus <ronny.meeus@gmail.com>
>
> diff --git a/lib/psos/init.c b/lib/psos/init.c
> --- a/lib/psos/init.c
> +++ b/lib/psos/init.c
> @@ -39,7 +39,7 @@ unsigned int psos_long_names;
>
>  static unsigned int clock_resolution = 1000000; /* 1ms */
>
> -static unsigned int time_slice = 1000000; /* 1ms */
> +static unsigned int time_slice_in_ticks = 5;
>
>  static const struct option psos_options[] = {
>         {
> @@ -71,7 +71,7 @@ static int psos_parse_option(int optnum,
>                 clock_resolution = atoi(optarg);
>                 break;
>         case time_slice_opt:
> -               time_slice = atoi(optarg);
> +               time_slice_in_ticks = atoi(optarg);
>                 break;
>         default:
>                 /* Paranoid, can't happen. */
> @@ -113,7 +113,7 @@ static int psos_init(void)
>         }
>
>         /* Convert pSOS ticks to timespec. */
> -       clockobj_ticks_to_timespec(&psos_clock, time_slice, &psos_rrperiod);
> +       clockobj_ticks_to_timespec(&psos_clock, time_slice_in_ticks, &psos_rrperiod);
>
>         return 0;
>  }

To be clear, this is a patch for the xenomai forge repository.

