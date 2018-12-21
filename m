Date: Fri, 21 Dec 2018 20:37:33 +0100
From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: Re: I-pipe 4.4.x-cip
Message-ID: <20181221193733.6egh3lx3ezjfpg3o@jholzmayr.localdomain>
References: <169e6cda-32e6-0dd9-f709-ef2de587a77a@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169e6cda-32e6-0dd9-f709-ef2de587a77a@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Hi Jan,

On Thu, Dec 20, 2018 at 05:32:37PM +0100, Jan Kiszka wrote:
> Hi all,
> 
> just a quick note that I started a 4.4-cip based I-pipe tree:
> 
> https://gitlab.denx.de/Xenomai/ipipe/tree/ipipe-4.4.y-cip
> 
> So far it's just a merge of ipipe-4.4.y @ipipe-core-4.4.166-x86-12 with the
> CIP tree @4.4.166-cip29. I'm not yet sure whether to switch 4.4 completely
> to -cip or have both running in parallel for some more time.

Thanks, https://github.com/LetoThe2nd/meta-xenomai has been updated
accordingly.

> 
> For now, I would ask everyone interested in this baseline, may it be on x86
> or ARM, to try out the new branch.

Preliminary results on Beaglebone Black:
- xeno-test passes
- latency -t 0 maxes out at ~70µs
- latency -t 2 maxes out at ~23µs

Our companys long term testing booth is unavailable until Jan 7th, so
more delay again for proper results, sorry.

Greetz
-- 
———————————————
Josef Holzmayr
Software Developer Embedded Systems

Tel: +49 8444 9204-48
Fax: +49 8444 9204-50

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de
———————————————
Amtsgericht Ingolstadt – GmbH: HRB 191328 – KG: HRA 170393
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
Ust-IdNr: DE 128592548 

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


