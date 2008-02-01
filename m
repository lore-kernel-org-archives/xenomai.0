Message-ID: <2ff1a98a0802010200q981e76fkd2340c6ba7796157@domain.hid>
Date: Fri, 1 Feb 2008 11:00:47 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47A2EE40.2070602@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>
	<2ff1a98a0802010120u6fdf215apf0a542e0c2b2bcff@domain.hid>
	<d3f72a390802010142g3ac085b5qb2104ccd108796ec@domain.hid>
	<2ff1a98a0802010153l70062d8eo41c709715ad4fcdb@domain.hid>
	<47A2EE40.2070602@domain.hid>
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
To: Soft Axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 1, 2008 at 11:02 AM, Soft Axel <softaxel@domain.hid> wrote:
>
>  Gilles Chanteperdrix ha scritto:
>
>  On Fri, Feb 1, 2008 at 10:42 AM, axel axel <softaxel@domain.hid> wrote:
>
>
>  2008/2/1, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
>
>  On Fri, Feb 1, 2008 at 10:08 AM, axel axel <softaxel@domain.hid> wrote:
>
>
>  Hi,
>
> i try to use rt_task_sleep( 10000000 ) in a user-space task under
> round-robin scheduling but doesnt' work.
>
>  Do not forget that the number passed to rt_task_sleep is a count of
> ticks (and documented as such), so, if you want to sleep for 10ms, you
> should call:
> rt_task_sleep(rt_timer_ns2ticks(10000000))
>
>  i try also this but nothing is changed.
>
>  Of course, but about the other question: do you observe the same
> behaviour with xenomai trunk ?
>
>
>  What do you mean  xenomai trunk ?
>
>  this is my actual configuration:
>   - xenomai-2.4-rc5
>   - kernel 2.6.20.4 arm cirrus ep9315 patched
>
>  have i try with xenomai 2.4.1 ?

No, please try Xenomai trunk:
https://gna.org/svn/?group=xenomai

-- 
                                               Gilles Chanteperdrix

