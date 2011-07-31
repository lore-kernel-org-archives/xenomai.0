Message-ID: <4E35950E.6000900@domain.hid>
Date: Sun, 31 Jul 2011 19:46:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QnZD3-00080U-DV@xenomai.org> <4E358F10.7070203@domain.hid>
	<4E359412.4090309@domain.hid>
In-Reply-To: <4E359412.4090309@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/31/2011 07:42 PM, Jan Kiszka wrote:
> On 2011-07-31 19:21, Gilles Chanteperdrix wrote:
>> On 07/31/2011 06:49 PM, GIT version control wrote:
>>> +int rt_puts(const char *s)
>>> +{
>>> +	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
>>> +}
>>
>> gcc for ARM chokes here: it says that NULL can not be converted to a
>> va_list, however I try it.
> 
> Hmm. Does this work?
> 
> diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
> index 186de48..52538d8 100644
> --- a/src/skins/common/rt_print.c
> +++ b/src/skins/common/rt_print.c
> @@ -243,7 +243,9 @@ int rt_printf(const char *format, ...)
> 
>  int rt_puts(const char *s)
>  {
> -	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
> +	va_list dummy;
> +
> +	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, dummy);
>  }
> 
>  void rt_syslog(int priority, const char *format, ...)
> 
> 
> Not really beautiful as well, I know.

It seems to work now, but some later version of gcc may decide to warn
us that this argument is used without being initialized...

-- 
                                                                Gilles.

