Message-ID: <52EFFF2B.1080509@xenomai.org>
Date: Mon, 03 Feb 2014 21:42:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <1391159926.16255.YahooMailNeo@web163901.mail.gq1.yahoo.com>
 <201401311412.40855.paul_c@tuxcnc.org> <201402022350.08460.paul_c@tuxcnc.org>
In-Reply-To: <201402022350.08460.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debuild of xenomai failing: Directory nonexistent
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/03/2014 12:50 AM, Paul wrote:
> On Friday 31 January 2014, Paul wrote:
>> On Friday 31 January 2014, Huub Van Niekerk wrote:
>>> Despite starting all over (tar jxf xenomai), downloading and
>>> patching again, debuild stops at exactly the same place. I still
>>> wonder why debuild on x86 (Ubuntu 10.04) worked great instantly and
>>> on armhf (Ubuntu 12.04) keeps ending in error. I just ran a test
>>> with standard "debuild -uc -us" on Ubuntu 12.04 x86 and it delivers
>>> the expected xenomai deb files without a problem. So why doesn't it
>>> do the same on armhf ?
>>
>> This is sounding more like a bug either in Ubuntu 12.04 or some
>> peculiarities with this particular armhf flavour rather than a
>> Xenomai issue.
> 
> The reason dh_installdirs is not working for this particular build is 
> because armhf is not listed as a supported architecture - This would 
> prevent all architecture dependant packages from being built and just 
> produce xenomai-kernel-source and xenomai-doc.
> 
> Attached are two patches, the first should have been part of an earlier 
> patch that included static devices in libxenomai1.
> 
> The second patch adds armhf support to the list of binary packages 
> generated.
> 
> Need to rework debian/rules to give a cleaner split between arch 
> dependant and common packages - Will work on this later in the week.

Merged, thanks.


-- 
                                                                Gilles.

