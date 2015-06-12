Message-ID: <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
In-Reply-To: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
References: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
Date: Sat, 13 Jun 2015 01:02:01 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM-native mainlining - status?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>


Michael Haberler wrote:
> Q - can I assume "RTDM-native" will be part of RT-PREEMPT if/when that
> goes mainline?
>
> or must I assume this will remain a Xenomai-specific way of doing things
> which will not be available via a torvalds kernel?

Yes, you can assume that. I do not see any way merging RTDM-native would
make sense for mainline. I mean, from their point of view, it would be
just redundant. For instance, from what I could gather, drivers based on
"OS abstraction layers" have been refused, and the people who wanted to
get them merged, asked to rewrite them using Linux driver API without the
abstraction layer.

>
>
> - Michael
>
> background - since we have a portable RT application, investing into RTDM
> drivers makes a lot more sense if both RT kernel flavors can make use of
> them (in fact three if a vanilla kernel is used - which is good enough for
> certain applications)

Well, if RTDM-native is made an out-of-tree Linux kernel module, you will
be able to compile it without applying patches, I think that would be good
enough for the usages you envision.


-- 
                    Gilles.


