Message-ID: <4BDDA1CF.2060903@domain.hid>
Date: Sun, 02 May 2010 18:01:19 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>	<1266140329.27019.17.camel@domain.hid>	<4B867EB5.9090504@domain.hid>	<4B867FF9.2020709@domain.hid>	<4B868228.10206@domain.hid>	<4B868958.3000503@domain.hid>
	<4B86B0DB.4000600@domain.hid> <4B87CE3E.2070402@domain.hid>
In-Reply-To: <4B87CE3E.2070402@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Hi Stefan,

Stefan Kisdaroczi wrote:
> I have attached a patch against debian xenomai version 2.5.1-4, changes:
>  - create group xenomai on install
>  - added a init-script which sets /sys/.../xenomai_gid if
>    /sys/.../xenomai_gid exists
>  - added a modprobe-script that adds the xenomai_gid parameter if the user
>    did call modprobe without xenomai_gid=
> 
> With this changes, all users which are member of the group xenomai are able
> to run xenomai apps, with xeno_nucleus builtin or as a module.

Looks fine. Just uploaded into Debian. (And renamed
/etc/modprobe.d/xenomai to xenomai.conf.)

Thanks!

bye,
  Roland

