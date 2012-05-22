From: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Date: Tue, 22 May 2012 17:50:31 +0200
Message-ID: <C7408997F5B0784C970ED53C11855FAE011112339166@INSITEOSBS01.insiteo.local>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,

I added this last patch, its seem to be working fine.
I will run endurance testing all night long and give you the result tomorro=
w..
Thanks for your help.

JP
________________________________________
De : Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Date d'envoi : mardi 22 mai 2012 15:33
=C0 : Jean-Pascal JULIEN
Cc : xenomai@xenomai.org
Objet : Re: RE : RE : RE : [Xenomai] A possible mis-interaction between CON=
FIG_PREEMPT and GPIO IRQ handling for ARM, leading to extreme latency

On 05/22/2012 03:23 PM, Jean-Pascal JULIEN wrote:
> Gilles,
>
> In the adeos-ipipe-2.6.38.2-arm-1.18-04.patch this piece of code is not p=
resent :

Just look at what the patch does: it replaces what the current I-pipe
patch has, with what you already have. If you want the patch I sent to
apply correctly, please use the latest I-pipe patch.

--
                                            Gilles.

