Message-ID: <4C56EFAE.2020605@domain.hid>
Date: Mon, 02 Aug 2010 18:17:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100802142702.2554C11D922@domain.hid>
	<4C56DFE5.50209@domain.hid>
In-Reply-To: <4C56DFE5.50209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Misleading git tags
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Wolfgang Denk wrote:
>> Dear Gilles,
>>
>> I noticed that "git describe" does not provide helpful information for
>> the Xenomai repository.
>>
>> For the current code (tagged as v2.5.4) I still get:
>>
>> 	-> git describe
>> 	v2.5.1-349-gf8fa381
>>
>> Only with the "--tags" option I get the expected result:
>>
>> 	-> git describe --tags
>> 	v2.5.4
>>
>> The behaviour changes from version to version:
>>
>> 	-> git describe v2.5.0
>> 	fatal: No annotated tags can describe 'fddf7831dc53cce70b7196314cbd0b3aec028350'.
>> 	However, there were unannotated tags: try --tags.
>> 	-> git describe v2.5.1
>> 	v2.5.1
>> 	-> git describe v2.5.2
>> 	v2.5.1-142-g6b3e8f2
>> 	-> git describe v2.5.3
>> 	v2.5.1-232-g55bf2d3
>> 	-> git describe v2.5.4
>> 	v2.5.1-349-gf8fa381
>>
>>
>> My recommendation is to always annotate release tags to avoid such
>> confusion.  Thanks.
> 
> Ok. I annotated 2.5.1 and asked Philippe about it, he told me that he
> never annotated 2.4 releases, so I stopped annotating them. In fact
> annotating 2.5.1 was the real mistake, but I guess you are right, I
> should annotate all of them. Can we change the annotation afterwards?

Actually the 2.4 branch is annotated, except for the two last releases.

-- 
					    Gilles.

