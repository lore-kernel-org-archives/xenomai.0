Message-ID: <e325d110607310723r18eec657vf1e9bd6d7fdde2a5@domain.hid>
Date: Mon, 31 Jul 2006 15:23:08 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] configuration scripts doesn't work
In-Reply-To: <17613.60695.176599.493100@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607310304pac72cf3pad25cec643be0edf@domain.hid>
	<17613.60695.176599.493100@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

The error message i get when try to run the latency test program..
warming up...
latency: failed to set periodic, code -110

The message you got initially told you that a discrepancy between the
CPU selected at kernel level and the user-support has been detected.
To fix this, you need to select a x86 CPU supporting a timestamp
counter when configuring your kernel, since by default, the configure
script assumes --enable-x86-tsc.


May i know what does it mean by "x86 CPU supporting a timestamp
counter when configuring your kernel"?

Regards,
Kim Chuan.


On 7/31/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Kim Chuan Lim wrote:
>  > ./configure --enable-x86-sep --enable-x86-tsc
>  >
>  > Xenomai: incompatible feature set
>  > (required="sep tsc", present="sep", missing="tsc").
>  >
>  > https://mail.gna.org/public/xenomai-help/2006-04/msg00198.html
>  >
>  > I managed to fix it by following the same way.. can someone fix it in
>  > the trunk or next distribution please.
>
> As explained in the mail you have found, there is nothing to be fixed in
> Xenomai sources. What need to be fixed is the flags you passed to
> configure.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

