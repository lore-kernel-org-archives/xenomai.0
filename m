Subject: Re: [Xenomai-help] rt_intr_create returns ENOSYS ?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C532B8.3070100@domain.hid>
References: <44C532B8.3070100@domain.hid>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 11:25:30 +0200
Message-Id: <1153905930.4946.63.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-07-24 at 22:51 +0200, Hannes Mayer wrote:
> Ciao Philippe!
> 
> Philippe Gerum wrote:
> [...]
> >>>> Any enlightenment very much appreciated!
> >>> CONFIG_XENO_OPT_NATIVE_INTR? It's default off now.
> >> Yeah, works. Thanks! :-)
> >>
> >> What's the reason for defaulting to off ?
> >> Force users to write RTDM stuff ?
> > 
> > This gives a strong hint about what would be a good design decision when
> > crafting a device driver over Xenomai: i.e. use RTDM.
> 
> Absolutely, but if one just wants to capture the parallel
> port int, I think it's a little overkill to make a driver
> for it.
> 
> Anyway, is that documented somewhere, that
> CONFIG_XENO_OPT_NATIVE_INTR is default off now and that
> folks should preferably make RTDM drivers now ?
> I'd suggest to add that somewhere...
> 

It's already present in OPT_NATIVE_INTR's help section for 2.6, but this
is missing for 2.4 (no Xenomai help strings available with 2.4
actually).

> Tanti saluti,
> Hannes.
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



