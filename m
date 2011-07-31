Message-ID: <4E358F10.7070203@domain.hid>
Date: Sun, 31 Jul 2011 19:21:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QnZD3-00080U-DV@xenomai.org>
In-Reply-To: <E1QnZD3-00080U-DV@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : rt_print: Provide
	rt_puts
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

On 07/31/2011 06:49 PM, GIT version control wrote:
> +int rt_puts(const char *s)
> +{
> +	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
> +}

gcc for ARM chokes here: it says that NULL can not be converted to a
va_list, however I try it.

-- 
                                                                Gilles.

