Message-ID: <48AFE498.2060805@domain.hid>
Date: Sat, 23 Aug 2008 12:21:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid>
In-Reply-To: <48AFCB3F.6070902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi Jan,

Please do not use my address at gmail, gna does not want me to post from
this address:

2008-08-23 12:10:19 1KWq4T-0000zD-9E ** xenomai@xenomai.org <Xenomai-core@domain.hid
> R=dnslookup T=remote_smtp: SMTP error from remote mailer after RCPT TO:<Xenomai-
core@domain.hid>: host mail.gna.org [88.191.250.46]: 550 rejected because gmail.com i
s in a black list at dsn.rfc-ignorant.org

so, here is a repost of my answer:

Jan Kiszka wrote:
> > Hi Gilles,
> > 
> > trying to understand the cb_read/write lock usage, some question came up
> > here: What prevents that the mutexq iteration in pse51_mutex_check_init
> > races against pse51_mutex_destroy_internal?

Well, I am afraid the mechanism used is not 100% safe. Anyway, the aim
is to catch most of invalid usages, it seems we can not catch them all.

> > 
> > If nothing, then I wonder if we actually have to iterate over the whole
> > queue to find out whether a given object has been initialized and
> > registered already or not. Can't this be encoded differently?
> > 
> > BTW, shadow_mutex.mutex is a kernel pointer sitting in a user-reachable
> > memory region? Why not using a handle here, like the native skin does?
> > Won't that allow to resolve the issue above as well?

This has been so from the beginning, and I did not change it.

-- 
					    Gilles.

