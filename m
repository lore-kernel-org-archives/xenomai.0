Message-ID: <551A4C61.7080804@xenomai.org>
Date: Tue, 31 Mar 2015 09:27:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<CAKk99t2eGYME0BsLCjJV7VMm8VU_2okmpd8sYfMb_02sTvOfLQ@mail.gmail.com>	<55083DA4.3080201@xenomai.org>	<CAKk99t0pG6HWOucFXDw1-_5-=EGQ7faqA22yVog6Ye6TcGjevA@mail.gmail.com>	<550850D5.9060207@xenomai.org>	<CAKk99t0q3iNcah1Us79hJUjjHQCr2rEPu9gukSNjO2a6+Gk3sg@mail.gmail.com>	<CAKk99t3wP-WLemoO_bbsvE4uwh-Sh-5eGPJrM=6cAc5edyQW5Q@mail.gmail.com>	<5508600D.4020500@xenomai.org>	<CAKk99t3xFzLuydH3HoPzWBzjd5DNtC_4Kf3YQuodHDpXTLdsUg@mail.gmail.com>	<550B0626.5090801@xenomai.org>	<550B1584.8040309@xenomai.org>	<CAKk99t0ndeNODKHf3mmL4GTg9wrOnOcsgf_okqx_-dmNitWkXA@mail.gmail.com>	<550FF5FB.3090603@xenomai.org>	<CAKk99t2wHiUC_YCuLVt_4q_OKT_+PCeM3FY1pHSpOoz_faBZ4g@mail.gmail.com>	<CAKk99t3Z-euF4518Q5WsGFmsxqvwRgvz0bTBQm5pbBCD5d8MwA@mail.gmail.com>	<55101373.7010008@xenomai.org>	<CAKk99t2GwZg27UbANwGrKUujXgcQzSv=djj9zMpX3MXk_5YPLQ@mail.gmail.com>
 <CAKk99t270jde=JZaFJ_5nSeOgGBjN1wf9wwh7PTikBFyKwiAAw@mail.gmail.com>
In-Reply-To: <CAKk99t270jde=JZaFJ_5nSeOgGBjN1wf9wwh7PTikBFyKwiAAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/30/2015 06:51 PM, Helder Daniel wrote:
> Hi,
> 
> I installed ipipe patched linux 3.16.7 and Xenomai 3.0-rc4 from the
> scratch and all the compiling errors that I was experiencing were gone.
> 
> So It should have been a local installation issue as you pointed out.
> Probably due to many reinstalls of successive Xenomai new versions,
> without proper clean up of the oldest.
> I am just cleaning the oldest one removing folder /usr/xenomai.
> May be there is a better way?
> 

$ make uninstall

-- 
Philippe.

