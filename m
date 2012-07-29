Message-ID: <501545CB.20002@piments.com>
Date: Sun, 29 Jul 2012 16:16:43 +0200
From: xenophile <xenophile@piments.com>
MIME-Version: 1.0
References: <500FEB0F.9000308@xenomai.org>	<201207282127.33575.paul_c@tuxcnc.org>	<50144E93.5050109@xenomai.org>	<201207291044.22418.paul_c@tuxcnc.org>
	<501519E8.3040509@piments.com> <50151CDC.6010400@xenomai.org>
	<50152378.3070409@piments.com> <5015264D.6070300@xenomai.org>
	<50153143.9020302@piments.com> <50153BEB.2010207@xenomai.org>
In-Reply-To: <50153BEB.2010207@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Heads up: I-pipe patch status on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 07/29/12 15:34, Gilles Chanteperdrix wrote:
> The script and data I use to build the graph are all in
> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies
> starting from
> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/histo.gp


I just tested that with gnuplot 4.6  CVS from April 17th. Output looks=20
nice and clean, no font issues, nice fine lines. Ariel is a pretty safe=20
bet on all platforms, it's also the default.

current 4.6 release was on March 8th 2012 so it will virtually=20
identical. Strongly suggest an update, lots of change and bug fixes=20
since 4.4

Mouse interaction may not have been included that far back. Equally=20
inclusion of the js inside the svg using the standalone option was=20
fairly recent, though IIRC it did get included in the March release. (I=20
was mistaken seeing "standalone" in the markup, that predates this=20
option's effect on js)


The font syntax you use if still supported. gnuplot is pretty hardcore=20
about backwards compatibility.

You should add a final line to close the output file. Gnuplot does not=20
close the file since there could be follow on output to the same file.

unset output



I removed "dynamic" and it scales as expected.

In resum=C3=A9, removing dynamic should fix a few defects ; update to 4.6=
=20
recommended unless that are blocking issues with doing so.

Add the missing line to script.


set terminal svg mouse standalone fname "Arial" fsize 8 linewidth 0.6 but=
t
....
unset output

Hardly merits a patch.

HTH



