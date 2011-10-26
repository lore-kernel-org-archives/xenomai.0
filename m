Message-ID: <4EA7DF4E.7030403@domain.hid>
Date: Wed, 26 Oct 2011 12:22:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>
	<8493adf46f985831fad1.1318861192@domain.hid>
In-Reply-To: <8493adf46f985831fad1.1318861192@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH 3 of 4] psos: add tm_getm function
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: xenomai@xenomai.org

On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid>
> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>
> ---
>   include/psos/psos.h |  2 ++
>   lib/psos/tm.c       |  7 +++++++
>   2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/include/psos/psos.h b/include/psos/psos.h
> --- a/include/psos/psos.h
> +++ b/include/psos/psos.h
> @@ -363,6 +363,8 @@ u_long tm_set(u_long date,
>   	      u_long time,
>   	      u_long ticks);
>
> +u_long tm_getm(unsigned long long *ns);
> +
>   u_long tm_wkafter(u_long ticks);
>
>   u_long tm_wkwhen(u_long date,
> diff --git a/lib/psos/tm.c b/lib/psos/tm.c
> --- a/lib/psos/tm.c
> +++ b/lib/psos/tm.c
> @@ -309,3 +309,10 @@ u_long tm_get(u_long *date_r, u_long *ti
>
>   	return SUCCESS;
>   }
> +
> +u_long tm_getm(unsigned long long *ns_r)
> +{
> +	*ns_r = clockobj_get_tsc();
> +	return SUCCESS;
> +}

-	*ns_r = clockobj_get_tsc();
+	*ns_r = clockobj_tsc_to_ns(clockobj_get_tsc());


-- 
Philippe.

