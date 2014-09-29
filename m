Message-ID: <5429CAF1.9070603@xenomai.org>
Date: Mon, 29 Sep 2014 23:11:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5423F8E3.3060006@xenomai.org>
 <D04EDD17.190CB%shartmann@cnt.canon.com> <542976B2.30804@xenomai.org>
 <D04F0E52.190EE%shartmann@cnt.canon.com>
In-Reply-To: <D04F0E52.190EE%shartmann@cnt.canon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Hartmann <shartmann@cnt.canon.com>, Xenomai <xenomai@xenomai.org>

On 09/29/2014 08:44 PM, Steve Hartmann wrote:
> On 9/29/14 10:11 AM, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 09/29/2014 04:59 PM, Steve Hartmann wrote:
>>> Just FYI, When following the directions to build debian packages, the
>>> debian packages are named with 2.6.3 filenames rather than the expected
>>> 2.6.4.
>>
>> Yes, we are not going to update the instructions every time we release
>> an new version. Which is why the instructions say:
>>
>> This howto was written for Xenomai 2.6.3, please use the latest stable
>> Xenomai release and adapt the version numbers accordingly.
>>
>> Then, when building the kernel:
>>
>> We use Xenomai 2.6.3 and Linux 3.10.32 on x86 in the following example,
>> please adapt it to the versions and architectures you want to install.
>>
>> Do you see a way to make the instructions more clear?
>>
>> -- 
>>                                                                Gilles.
> 
> Gilles,
> 
> OK, you are right, it is my fault.  It was the word-wrap in the
> instructions that got me screwed up:
> 
> Create a new debian changelog entry:
> xenomai-2.6.3$ DEBEMAIL="your@email" DEBFULLNAME="Your Name" debchange -v
> 2.6.3 Release 2.6.3
> 
> In my browser looks like:
> 
> Create a new debian changelog entry:
> xenomai-2.6.3$ DEBEMAIL="your@email" DEBFULLNAME="Your Name" debchange -
> v 2.6.3 Release 2.6.3
> 
> So I left everything off the second line, which was actually a
> continuation of the first line.

I tried and improve the visibility of shell command lines by changing
the style they use, the line breaks are also now explicit with a \

-- 
                                                                Gilles.

