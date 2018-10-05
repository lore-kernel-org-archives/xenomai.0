Date: Fri, 5 Oct 2018 19:09:24 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <620226841.5052965.1538766564288@mail.yahoo.com>
In-Reply-To: <20181005121128.7898c167@md1pvb1c.ad001.siemens.net>
References: <20180925103809.4932-1-rpm@xenomai.org>
 <20180927144203.5e7d006b@md1pvb1c.ad001.siemens.net>
 <20181001165112.18eafb36@md1pvb1c.ad001.siemens.net>
 <0d0ab124-f861-da42-433c-d61195a5e13f@xenomai.org>
 <20181005121128.7898c167@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [I-PIPE][PATCH 00/32] 4.14.71/x86_64 port (split
 series)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

>I instrumented __ipipe_trap_prologue and did not even see the #PF
>there. So it is either in the assembly before that or we do not have
>the trap handler mapped or something like that. nopcid and nopti did
>not help.

I'm going to take a wild guess and say entry_64.S is where the issue is because I can't make heads or tails of the KPTI code.. I might as well be looking at Denuvo.

Alec

