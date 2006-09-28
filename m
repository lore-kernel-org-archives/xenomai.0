Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4517B2F2.6090102@domain.hid>
References: <451786B3.4020506@domain.hid>  <4517B2F2.6090102@domain.hid>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 17:33:27 +0200
Message-Id: <1159457607.4982.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2006-09-25 at 12:44 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > ...
> > A further idea of mine was to inline light-weight parts of the
> > __ipipe_*_root API on UP (no SMP at hand to judge on it as well).
> 
> BTW: I haven't looked at any detail yet, but would PER_CPU here and
> there (e.g. for ipipe_percpu_domain) buy us something on SMP (2.6)?
> 

At the very least, we don't need to share any cacheline for
ipipe_percpu_domain[] which is purely a per-CPU variable.

> Jan
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



