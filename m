Message-ID: <50153143.9020302@piments.com>
Date: Sun, 29 Jul 2012 14:49:07 +0200
From: xenophile <xenophile@piments.com>
MIME-Version: 1.0
References: <500FEB0F.9000308@xenomai.org>	<201207282127.33575.paul_c@tuxcnc.org>	<50144E93.5050109@xenomai.org>	<201207291044.22418.paul_c@tuxcnc.org>
	<501519E8.3040509@piments.com> <50151CDC.6010400@xenomai.org>
	<50152378.3070409@piments.com> <5015264D.6070300@xenomai.org>
In-Reply-To: <5015264D.6070300@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 07/29/12 14:02, Gilles Chanteperdrix wrote:
> On 07/29/2012 01:50 PM, xenophile wrote:
>
>> On 07/29/12 13:22, Gilles Chanteperdrix wrote:
>>> On 07/29/2012 01:09 PM, xenophile wrote:
>>>
>>>> bitmap rendered graphs should be a relic of  the 1990's ;)
>>>
>>>
>>> ... but still look much better without getting to much in gnuplot
>>> configuration:
>>> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png
>>> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.svg
>>>
>>
>> There is a problem  with the legend not showing for some reason. If
>> you'd like to send me your gnuplot script and a sample data file I could
>> look what is going wrong. (Off list if you prefer).
>>
>> You may want to explicitly specify the font size as well since it seems
>> you prefer the smaller text in the png.
>>
>> Apart from fixing the problem with the legend , where's the "much better"?
>>
>> Your gnuplot has standalone="no" at the top so you do have a version
>> that can have the interactive features I suggested.
>>
>> In particular toggling lines on/off can be a useful feature with this
>> kind of multiple line plot.
>>
>> Your svg doesn't  zoom either :?
>>
>
>
> Well, the lines are to thick, the fonts are to large, so large that the
> legend can not be printed (but it is a placement issue due to my script,

so specify the line width and text size you'd like. There is not an 
exact 1:1 mapping of line widths between how png and svg render finally.

Also fonts are created on the host machine in the case of png whereas 
the choice of font is done in the viewer with formats like svg, 
postscript , pdf which provide text descriptions not dots. It will 
probably help to explicitly define the font

> I know how to fix that), so, overall the graph looks really ugly. The
> svg graph zooms with my client.

which is ?

Tested you links on linux firefox-14 and Opera . Mine zoom ,yours don't :?

gnuplot> help svg:
...
  `dynamic` allows a svg-viewer to resize plot, whereas the default
  setting, `fixed`, will request an absolute size.

You are inviting the viewer to autoscale, which effectively defeating 
the one of the (potential) benefits of using a scalable format. Opera 
shows in it's scaling widget that it is zooming but then autoscales the 
svg so that I get the same thing on screen.

Since most browsers now seem to autoscale when first showing a graphic 
even if you don't request it , leaving this out is probably the best 
option. This may have a bearing on your font size issues too.

>
> The script is based on scripts/histo.gp in xenomai distribution, with
> simply "set terminal png..." replaced with "set terminal svg dynamic".
> I would gladly accept a patch to this file which makes it render good
> looking svg graphs.
>

I don't have xeno installed an any hardware here but I am willing to 
help you get clean output if you want to link me the script and a sample 
data file.

I am active on gnuplot ML and was behind getting a lot of this stuff 
into gnuplot.

eg.
set terminal svg mouse standalone  font arial 7





