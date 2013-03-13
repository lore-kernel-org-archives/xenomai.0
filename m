Message-ID: <51406EAA.5000303@xenomai.org>
Date: Wed, 13 Mar 2013 13:18:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<5136F3A6.8090400@antcom.de> <513F96BA.4030309@xenomai.org>
	<513F9DF2.2030803@antcom.de>
In-Reply-To: <513F9DF2.2030803@antcom.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/12/2013 10:28 PM, Roland Stigge wrote:

> On 03/12/2013 09:57 PM, Gilles Chanteperdrix wrote:
>> Roland, at some point I lost track of what your intentions were. In the
>> following mail:
>> http://www.xenomai.org/pipermail/xenomai/2012-July/000473.html
>>
>> You seemed to agree to take care of the debian directory in xenomai
>> sources, asking me to simply warn you before a release.
>> Which I did before the 2.6.2 release in the following mail:
>>
>> http://www.xenomai.org/pipermail/xenomai/2012-December/027051.html
>>
>> With a list of things which could be changed in the debian/rules file,
>> inviting you to do what I had understood you had agreed to do.
> 
> When you propose things, and implement them, fine. That's your decision.
> When you propose things and I implement them, also fine. That's my
> decision. But please don't expect me to just follow commands. That's not
> my nature at all. Sorry.


Actually, what I quoted above is the contrary, you commanded me to warn
you before a release, and I obeyed. The real question at the beginning
of the mail is do you intend or not to maintain the debian directory in
xenomai sources?

> 
>> http://www.xenomai.org/pipermail/xenomai/2012-December/027052.html
>> You simply told me that you did not even try debian/rules, following
>> this, Leopold sent a post with a patch to fix the issue before the
>> release, but your reply could be interpreted as the fact that the patch
>> was actually broken, you did not send a fixed patch for the update, and
>> as a result 2.6.2 was released with a broken debian directory.
> 
> Please don't over-interpret things I actually didn't say at all. Every
> patch is welcome, including things you propose, and from other
> contributors. When I see conflicts in the code, I will state that clearly.


I interpreted you first mail:
http://www.xenomai.org/pipermail/xenomai/2012-July/000473.html
as the fact that you agreed to maintain the debian directory.

> 
>> Which is why, for the 2.6.2.1 release, I did not warn you (since it had
>> proved useless anyway)
> 
> This is also your interpretation of things, and your own decision. Not
> discussed with me.
> 
> Sorry when I missed some detail in the past. Please don't let this lead
> to bad further communication in return, or blaming each other.


I am not trying to blame you, I am trying to get a clear answer. If you
say you will maintain the debian directory, then I would not merge
patches touching it without your consent, if you say you do not, then I
can merge the changes.

> 
> Thanks,
> 
> Roland
> 
> 
> PS: I consider Debian itself the primary source of Debian packages and
> will continue to do so. When people ask specific questions about those,
> I'll answer accordingly.


This point of view is the point of view of the Debian community, but
when you answer on this mailing list, your answers can be interpreted as
coming from the "Xenomai community". And the Xenomai and Linux CNC
communities provide unofficial pre-built packages for several Debian
derivatives with the explicit purpose of avoiding newbies to have to ask
the same questions over and over again about compiling a kernel. So,
when you answer on this mailing list, it would be less disturbing if you
mentioned the solutions proposed by these communities. With all the
warnings you want about the packages not being official Debian packages.

> 
> PPS: If you consider your tone as helpful towards positive motivation of
> contributors, please rethink.

Everyone has its limitation, mine is to be unable to deal with nuances
in general and when communicating in particular. The only fix I know for
it is to avoid communicating. But when I read your answers to "Tom Z", I
can not really stay silent.

-- 
                                                                Gilles.

