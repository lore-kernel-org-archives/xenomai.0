From: TALBI Ahmed -EXT <ahmed.talbi-ext@alstom.com>
Date: Tue, 17 May 2016 09:52:59 +0000
Message-ID: <2c54c2411dc94f87abcf483760e6bf93@AM3PR48MB0177.041d.mgd.msft.net>
References: <f5af5dc73c2046f789592c7f15246c24@AM3PR48MB0177.041d.mgd.msft.net>
 <20160514123051.GB27354@hermes.click-hack.org>
 <3CC67847-B96B-4A25-A4C0-D92F267E4E3F@temporubato.com>
 <28dcd6ac421c4696a7f60ccef160c8ef@AM3PR48MB0177.041d.mgd.msft.net>,
 <20160517094127.GC2668@hermes.click-hack.org>
In-Reply-To: <20160517094127.GC2668@hermes.click-hack.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] system freeze on IMX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Ok, got it Gilles...

I will give a try for both proposals. The issue is hard to reproduce (may b=
e 2 or 3 days under stress...).
Back to you as soon as I have news

Ahmed

________________________________________
De : Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Envoy=E9 : mardi 17 mai 2016 11:41:27
=C0 : TALBI Ahmed -EXT
Cc : Rolf W=F6hrmann; xenomai@xenomai.org
Objet : Re: [Xenomai] system freeze on IMX6

On Tue, May 17, 2016 at 09:11:09AM +0000, TALBI Ahmed -EXT wrote:
> In the logs I attached I can see that xnlock  is locked in do_taskexit_ev=
ent (by CPU0) and then in the same context we try to lock it a second time =
in xintr_clock_handler. May this be the issue ? or is xnlock a recursive lo=
ck ?

You are misreading the logs. xnintr_clock_handler tries to get the
lock on one cpu, while do_taskexit_event got it on another cpu. The
root cause of the problem is a fault when xnlock_spin is trying to
print some message. Probably because it has spin for too long. You
can try to disable spinlock debugging, but I am afraid you will get
a lockup instead.

--
                                            Gilles.
https://click-hack.org

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

