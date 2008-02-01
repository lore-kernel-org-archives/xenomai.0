Message-ID: <2ff1a98a0802010120u6fdf215apf0a542e0c2b2bcff@domain.hid>
Date: Fri, 1 Feb 2008 10:20:28 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>
Subject: Re: [Xenomai-core] rt_task_sleep doesn't work with round robin
	scheduling
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 1, 2008 at 10:08 AM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> i try to use rt_task_sleep( 10000000 ) in a user-space task under
> round-robin scheduling but doesnt' work.

Do not forget that the number passed to rt_task_sleep is a count of
ticks (and documented as such), so, if you want to sleep for 10ms, you
should call:
rt_task_sleep(rt_timer_ns2ticks(10000000))

>
> It returns the value -11.
>
> Any idea ?
>
> Thanks a lot
>
> Roberto Bielli
>
> _______________________________________________
>  Xenomai-core mailing list
>  Xenomai-core@domain.hid
>  https://mail.gna.org/listinfo/xenomai-core
>
>



-- 
                                               Gilles Chanteperdrix

