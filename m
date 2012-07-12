Message-ID: <4FFEF51B.6000307@antcom.de>
Date: Thu, 12 Jul 2012 18:02:35 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org>
	<4FFDA171.3010201@nta-inc.net>	<4FFDAF59.9010000@xenomai.org>	<20120711174844.GG19565@csclub.uwaterloo.ca>	<4FFE1841.1070409@xenomai.org>
	<4FFE8B7C.6090101@antcom.de>	<4FFE9477.5070002@xenomai.org>
	<4FFEE9E8.2040008@nta-inc.net> <4FFEF029.1090901@antcom.de>
	<4FFEF20D.6030709@xenomai.org>
In-Reply-To: <4FFEF20D.6030709@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
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

On 07/12/2012 05:49 PM, Gilles Chanteperdrix wrote:
> On 07/12/2012 05:41 PM, Roland Stigge wrote:
>> On 07/12/2012 05:14 PM, Jeff Webb wrote:
>>>>> I unfortunately don't have the ressources to regularly sync/update
>>>>> debian/* in the xenomai.org dev repository.
>>>
>>> Do you have the resources to update debian/* on xenomai.org just before
>>> each release is made?  I don't think it's necessary to update it any
>>> more often than that.  I'm assuming that you eventually package each
>>> release anyway, so it would be nice to do it before a release is made
>>> official.  Of course, if you don't have time for that or your
>>> availability doesn't line up with the timeframe for a release, that is
>>> understandable.  I am just asking if the problem is trying to keep the
>>> git repository up to date all the time, or if you don't even have time
>>> to do it for each release.
>>
>> It would be possible for me if I get ~2 weeks notice before a Xenomai
>> release to already do _before_ the Xenomai release what I would normally
>> do _afterwards_ anyway (for Debian). Gilles, is this possible?
> 
> Yes, it is possible, of course.
> 
> Next question: the current debian directory is (I believe), compatible
> with Debian stable. The rationale being that it allows people to install
> the latest xenomai revision on Debian stable.

Yes, that makes sense. All other targets are moving too quickly. ;-)

A build using this debian/* will also most often work (but not
guaranteed to be working always) on Debian testing/unstable. (In
contrast to testing/unstable's debian/* which will often break on Debian
stable systems.)

Responsible users would either use Debian stable, or be proficient
enough to know the differences between stable/testing/unstable and be
able to tweak things.

Roland

