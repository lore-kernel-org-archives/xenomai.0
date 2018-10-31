Subject: Re: [PATCH] copperplate/clockobj: prevent warning with -Wconversion
References: <1540883612.2354.2.camel@smigroup.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <43f0ce47-d677-3600-1826-2f696d258936@siemens.com>
Date: Wed, 31 Oct 2018 18:42:22 +0100
MIME-Version: 1.0
In-Reply-To: <1540883612.2354.2.camel@smigroup.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 30.10.18 08:13, Mauro Salvini wrote:
> make cast explicit to avoid warning when user code is compiled with
> -Wconversion

Please sign-off your patches, according to CONTRIBUTING.md.

> ---
>   include/copperplate/clockobj.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/copperplate/clockobj.h
> b/include/copperplate/clockobj.h
> index 8568794d9..063bcce90 100644
> --- a/include/copperplate/clockobj.h
> +++ b/include/copperplate/clockobj.h
> @@ -136,7 +136,7 @@ void clockobj_ns_to_timespec(ticks_t ns, struct
> timespec *ts)

Something mangled this line, probably your mail client.

>   {
>   	unsigned long rem;
>   
> -	ts->tv_sec = cobalt_divrem_billion(ns, &rem);
> +	ts->tv_sec = (__kernel_time_t)cobalt_divrem_billion(ns, &rem);

Why not time_t, the public target type?

>   	ts->tv_nsec = rem;
>   }
>   
> -- 
> 2.11.0
> 
> 

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

