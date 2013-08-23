Message-ID: <2dbdf7f7f5902752f78dac8d1f445822.squirrel@127.0.0.1>
In-Reply-To: <521784AE.4090802@gmail.com>
References: <52152657.4090600@gmail.com> <521527D7.1060600@xenomai.org>
	<521784AE.4090802@gmail.com>
Date: Fri, 23 Aug 2013 18:44:10 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] ipipe patch for 3.6.0 arm?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: sagar.behere@gmail.com
Cc: xenomai@xenomai.org


Sagar Behere wrote:
> On 08/21/2013 10:49 PM, Gilles Chanteperdrix wrote:
>> On 08/21/2013 10:43 PM, Sagar Behere wrote:
>>> Hello,
>>>
>>> I wish to run xenomai on a gumstix duovero (OMAP4430-based). A kernel
>>> supporting the duovero is supposedly under development in the omap-3.6
>>> branch of Steve Sakoman's repo
>>>
>>> http://git.sakoman.com/git/gitweb.cgi?p=linux.git;a=shortlog;h=refs/heads/omap-3.6
>>>
>>> However, I don't see an ipipe patch for 3.6.0 in
>>> http://download.gna.org/adeos/patches/v3.x/arm/older/
>>>
>>> So how does one go about using xenomai with a 3.6.0 kernel?
>>
>> You have two choices:
>> 1- port the I-pipe patch to the target kernel
>> 2- back/forward port the board specific changes to a kernel which has an
>> I-pipe patch.
>
> Hmm, I noticed tags for v3.9.4 and v3.10-rc2 at

Why not using the branch for 3.8? It is the latest I-pipe tree, the other
trees are work in progress.

-- 
                                              Gilles


