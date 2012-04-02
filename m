Message-ID: <4F79B925.2060303@domain.hid>
Date: Mon, 02 Apr 2012 16:35:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1SEhxD-0007Jo-Tb@domain.hid>
In-Reply-To: <E1SEhxD-0007Jo-Tb@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Add regression test
 for mprotect on pinned memory
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

On 04/02/2012 04:09 PM, GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 410e90d085d21dc913f8724efafe6ae75bd3c952
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=410e90d085d21dc913f8724efafe6ae75bd3c952
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Fri Mar 30 18:06:27 2012 +0200
> 
> Add regression test for mprotect on pinned memory
> 
> This tests both the original issue of mprotect reintroducing COW pages
> to Xenomai processes as well as the recently fixed zero page corruption.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> +static void check_inner(const char *fn, int line, const char *msg,
> +			int status, int expected)
> +{
> +	if (status == expected)
> +		return;
> +
> +	rt_task_set_mode(T_WARNSW, 0, NULL);
> +	rt_print_flush_buffers();
> (...)
> +static void check_value_inner(const char *fn, int line, const char *msg,
> +			      int value, int expected)
> +{
> +	if (value == expected)
> +		return;
> +
> +	rt_task_set_mode(T_WARNSW, 0, NULL);
> +	rt_print_flush_buffers();
> (...)
> +void sigdebug_handler(int sig, siginfo_t *si, void *context)
> +{
> +	unsigned int reason = si->si_value.sival_int;
> +
> +	rt_print_flush_buffers();
> (...)
> +
> +	rt_task_set_mode(T_WARNSW, 0, NULL);
> +	rt_print_flush_buffers();

Maybe you could use posix skin's printf instead of putting calls to
rt_print_flush_buffers all over the place? I did not mean for this call
to be exported, I only added it for internal use by the posix skin.

-- 
					    Gilles.

