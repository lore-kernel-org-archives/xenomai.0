References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org> <20150805172427.GA21690@hermes.click-hack.org>
 <55C30F85.1090505@xenomai.org> <20150806074939.GA20331@hermes.click-hack.org>
 <55C31423.6070008@xenomai.org>
 <208C6975C932E94F86239FEA59CCA632E0D9E8A1@AUSMXMBX02.mrws.biz>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55C3795D.5000703@xenomai.org>
Date: Thu, 6 Aug 2015 17:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <208C6975C932E94F86239FEA59CCA632E0D9E8A1@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland-web.com
Cc: xenomai@xenomai.org

On 08/06/2015 11:25 AM, dietmar.schindler@manroland-web.com wrote:
>> Von: Philippe Gerum
>> Gesendet: Donnerstag, 6. August 2015 10:01
>>
>> ..., but the ternary operator is a bit special since by
>> design, it won't compete for precedence with the expressions it evaluates.
> 
> Actually, this is not special - no operator will "compete for precedence with the expressions it evaluates", because _which_ expressions it evaluates is determined by the very outcome of the "competition for precedence". And sure enough, the expression
> 
>     b = a ? 0 : 1
> 

I would tend to think that associativity is part of the issue. e.g.
right association solves the ambiguity between multiple assignments
operators with the same precedence.

> is not equivalent to
> 
>     (b = a) ? 0 : 1
> 
> (but by this remark I do not at all want to advocate the undue use of parentheses).
> 

Clearly. This said, the original remark was rather about the precedence
between operators from the test expression and the operators forming the
ternary conditional itself.

-- 
Philippe.

