Message-ID: <519F2C7E.6050808@siemens.com>
Date: Fri, 24 May 2013 11:01:50 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
	<20130523213304.D53E738047C@gemini.denx.de>
	<519F08C1.6060306@xenomai.org>
In-Reply-To: <519F08C1.6060306@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Next Xenomai Release?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-05-24 08:29, Gilles Chanteperdrix wrote:
> On 05/23/2013 11:33 PM, Wolfgang Denk wrote:
> 
>> Dear "Poole Jr, Donald R.",
>>
>> In message <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu> you wrote:
>>>
>>> I guess I overlooked that post and response. Any clarifying words/steps on
>>> what needs to be done to get the 3.8.x kernel patched with Xenomai for
>>> running on the Beaglebone/Raspberry Pi in the meantime?
>>
>> Adding support for a v3.8.x kernel appears to be not really
>> attractive, given that v3.8 has already reached EOL...
> 
> 
> From what I understand from this post:
> http://www.linuxfoundation.org/news-media/blogs/browse/2013/02/linux-38-not-longterm-kernel
> 
> And this page:
> https://www.kernel.org/category/releases.html
> 
> Every stable kernel until october 2013 will be EOLed when the next
> kernel is out.
> 
> So, any other kernel than 3.0 and 3.4 is not "attractive" until october
> 2013.
> 
> As it turns out however, 3.8 is a bit less unattractive than the others,
> because Canonical seem to have announced they would be maintaining it
> for a while longer (until August 2014, it seems) in the following post:
> https://lwn.net/Articles/550581/

Indeed. On x86, the only currently available I-pipe alternative to 3.8
is 3.5. And that one is in EOL for an even longer time now.

We will move on to 3.9 or 3.10 soon, but most probably not soon enough
for the next Xenomai release.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

