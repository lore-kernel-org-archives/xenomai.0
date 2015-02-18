Message-ID: <54E4795F.50309@siemens.com>
Date: Wed, 18 Feb 2015 12:37:03 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54E456AE.8070003@free.fr>
 <20150218092420.GA25957@hermes.click-hack.org>
In-Reply-To: <20150218092420.GA25957@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] AMD G/R serie
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, St??phane ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-02-18 10:24, Gilles Chanteperdrix wrote:
> On Wed, Feb 18, 2015 at 10:09:02AM +0100, St??phane ANCELOT wrote:
>> Hi,
>> Is xenomai available for those platforms?
>>
>> AMD G or R series
> 
> What architectures are these beasts ? If x86, then yes, Xenomai
> should work, and if it does not, it should not be hard to get it to work.

Yes, they are plain x86. No fundamental problems, but surprises can
always happen.

I recently did some general latency testings (not with Xenomai, though)
on the AMD-G series board we have here. The results still require closer
examinations, but they were not as good as on usual x86 boxes (a few 10
micros slower). That may be related to the specific board or bios, though.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

