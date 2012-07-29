Message-ID: <501519E8.3040509@piments.com>
Date: Sun, 29 Jul 2012 13:09:28 +0200
From: xenophile <xenophile@piments.com>
MIME-Version: 1.0
References: <500FEB0F.9000308@xenomai.org>
	<201207282127.33575.paul_c@tuxcnc.org>
	<50144E93.5050109@xenomai.org>
	<201207291044.22418.paul_c@tuxcnc.org>
In-Reply-To: <201207291044.22418.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: I-pipe patch status on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 07/29/12 11:44, Paul wrote:
>> >How do you get the fancy grid with gnuplot? We could add the option
>> >to scripts/histo.gp. Note that I prefer to draw graphs with a log
>> >scale, I find they are more meaningful, otherwise, you do not really
>> >see how the graph ends.
> gnuplot> set grid
>
> The next set of plots, I'll use a log scale as you suggest.
>
>
> Regards, Paul.

current gnuplot has good support for svg, scalable graphics. The 
"standalone" option when setting svg terminal makes an autonomous svg 
file with some nice interactive features like:

clicking on legend to toggle lines' visibility and a button to toggle 
the grid on/off; mouseover cursor coordinate readout; and of course you 
can zoom in without it becoming a pixel blur.

Depending on the number of points plotted it can be quite compact. Also 
the gzip compressed format .svgz can be displayed directly or embedded 
in competent browsers like Firefox/Opera/Safari.

bitmap rendered graphs should be a relic of  the 1990's ;)




