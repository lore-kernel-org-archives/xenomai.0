Message-ID: <4EA7DEC3.9010706@domain.hid>
Date: Wed, 26 Oct 2011 12:19:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>
	<0db9974c036abae53f74.1318861190@domain.hid>
In-Reply-To: <0db9974c036abae53f74.1318861190@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH 1 of 4] psos.h: add definition of
	ERR_OBJTFULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>, xenomai@xenomai.org

On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid>
> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>
> ---
>   include/psos/psos.h |  1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/psos/psos.h b/include/psos/psos.h
> --- a/include/psos/psos.h
> +++ b/include/psos/psos.h
> @@ -97,6 +97,7 @@
>   #define ERR_OBJDEL   0x05
>   #define ERR_OBJID    0x06
>   #define ERR_OBJTYPE  0x07
> +#define ERR_OBJTFULL 0x08
>   #define ERR_OBJNF    0x09
>
>   #define ERR_NOTCB    0x0E

Where is this error code used in the Xenomai tree? Can't find it right now.

-- 
Philippe.

