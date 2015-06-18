Message-ID: <7ad4e107e9fd70e40e7a622724d8e211.squirrel@sourcetrek.com>
In-Reply-To: <6272170.M7jmfjjzjE@soho>
References: <6272170.M7jmfjjzjE@soho>
Date: Thu, 18 Jun 2015 17:27:32 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Rtnet driver of RTL8111/8168/8411
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org


Leopold Palomo-Avellaneda wrote:
> Hi,
>
> just to confirm. I assume that if my box has this ethernet chipset:
>
> Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit
> Ethernet
>
> the rt_r8169 doesn't work, although the linux module is r8169.
>
> Is it correct?
>
> And I'm saying this because although I'm using xenomai 2.6.4 (latest
> stable)
> and rtnet (git updated) when I load the module no rtethX interface is
> generated.

I think rt_8169 supports 8169 only. I added support for the chipset on my
Atom-based board to xenomai 3 rtnet. Do not remember which it was 81111 or
8168.


-- 
                                            Gilles.
https://click-hack.org


