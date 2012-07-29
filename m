Message-ID: <50152B04.6070101@xenomai.org>
Date: Sun, 29 Jul 2012 14:22:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <500FEB0F.9000308@xenomai.org>	<201207282127.33575.paul_c@tuxcnc.org>	<50144E93.5050109@xenomai.org>	<201207291044.22418.paul_c@tuxcnc.org>
	<501519E8.3040509@piments.com> <50151B8D.10307@xenomai.org>
	<50151D82.7080203@piments.com> <50151F4C.2070006@xenomai.org>
	<5015284F.3020204@piments.com>
In-Reply-To: <5015284F.3020204@piments.com>
Content-Type: text/plain; charset=UTF-8
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
To: xenophile <xenophile@piments.com>
Cc: xenomai@xenomai.org

On 07/29/2012 02:10 PM, xenophile wrote:

> On 07/29/12 13:32, Gilles Chanteperdrix wrote:
>> On 07/29/2012 01:24 PM, xenophile wrote:
>>
>>> On 07/29/12 13:16, Gilles Chanteperdrix wrote:
>>>> On 07/29/2012 01:09 PM, xenophile wrote:
>>>>
>>>>> bitmap rendered graphs should be a relic of  the 1990's ;)
>>>>
>>>>
>>>> On the other hand, a bitmap is rendered once and only once, which really
>>>> makes sense for a static page, will appear the same in all navigators,
>>>> including those which do not support svg.
>>>>
>>>
>>> How often it is rendered depends upon the viewer. I don't see how this
>>> relates to whether the page is "static". (I'm assuming you are talking
>>> about static vs dyanamic content at the server end).
>>>
>>> I don't see any fundamental difference in whether you _create_ (as
>>> opposed to render) a graphic in svg , png or jpeg.
>>>
>>> There is nothing about svg/svgz that means you have to create it on the
>>> fly each time you serve a page. It is an XML format but as I said it can
>>> be embedded (hence the svg part can be pre-made).
>>>
>>> I do this on a 200MHz embedded ARM system running lighttpd. The pseudo
>>> real-time output is created in svg every 15min or on demand. The
>>> surrounding html template is static.
>>
>>
>> As far as I understand, the rendering (I am talking about the graphical
>> rendering) is done by every client which wants to view the graph, which
>> is stupid if it is always the same graph (that is what I meant by
>> static). And has a number of issue.
>>
>> I do not understand why you do not want to do the rendering on a 200 MHz
>> ARM, but if the machine serving the page is powerful enough, and the
>> graph not updated frequently, I find it makes a lot of sense to do the
>> rendering only once.
>>
>>> Gnuplot runs on the ARM.
>>
>> I do not discuss the fact that getting gnuplot to generate an svg will
>> consume less power. But overall, it will get all viewer to consume power
>> to do the rendering, which the static bitmap file avoids.
>>
> 
> The whole point of SVG is the S: scalable. If you "render" it to a 
> bitmap on the server no one scale it in their viewer (web browser in 
> this case).
> 
> Now whether decoding png or jpeg compression of an image (including much 
> blank white area) and then interpolating to the final screen rendered 
> size raster image in the users browser is more or less "power efficient" 
> that sending a textual vector description that the viewer draws line by 
> line I have no idea.
> 
> Since the PC is probably consuming about 150W just sitting there I'm not 
> sure what the point aiming for is.


I mean "processing power". Intuitively, generating a text file after
reading points from other text files seems more economic, than drawing
the lines to a bitmap in memory, rendering the text, and compressing
with png. But you are right, this is not even obvious.

> 
> SVG, basically gives the browser and the user total freedom of what size 
> to scale the output. rather than sending a series of dots which have a 
> predetermined resolution.
> 
> My reason for using SVG on the ARM is not save power or because it could 
> not handle producing a png , it is to give the viewer of the graphic the 
> ability to zoom in to any desired level and benefit from things like 
> toggling off lines that obscure the one he's interested in and getting 
> cursor readout of data points on the graph.
> 
> No way is that sort of thing possible with png.
> 
> I don't quite think you are appreciating all the differences between 
> vectorial and bitmap formats.  Hopefully, I've explained some of our 
> confusion over the term "render". The image is only rendered in the 
> viewer, Both vector and bitmap are descriptions of what has to be rendered.


Ok, ok, I am convinced, you can send the patch, now.

-- 
                                                                Gilles.

