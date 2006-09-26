Date: Tue, 26 Sep 2006 17:07:21 +0200
Message-Id: <J67GO9$2B9117C0B95CB2D9676C399264D0207F@laposte.net>
Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
From: "gilles\.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "jan.kiszka" <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

---------- Debut du message initial -----------

De     : adeos-main-bounces@domain.hid
A      : adeos-main@gna.org
Copies : 
Date   : Mon, 25 Sep 2006 12:44:02 +0200
Objet  : Re: [Adeos-main] [PATCH+HACK] optimise root stalling

> Jan Kiszka wrote:
> > ...
> > A further idea of mine was to inline light-weight parts of the
> > __ipipe_*_root API on UP (no SMP at hand to judge on it as
well).
> 
> BTW: I haven't looked at any detail yet, but would PER_CPU
here and
> there (e.g. for ipipe_percpu_domain) buy us something on SMP
(2.6)?

I think to remember that the PER_CPU support uses
smp_processor_id(), 
and we know that smp_processor_id() must not be used over Xenomai
stacks.

-- 
                 Gilles Chanteperdrix=0A=0AAcc=E9dez au courrier =E9lectr=
onique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34=80 TTC /mn) 
1 Giga de stockage gratuit =96 Antispam et antivirus int=E9gr=E9s 
=0A


