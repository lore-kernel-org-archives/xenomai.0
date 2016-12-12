References: <10829881481323326@web27g.yandex.ru>
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <f07822d2-e30a-d394-bae6-bdf776c0f03a@sigmatek.at>
Date: Mon, 12 Dec 2016 11:16:33 +0100
MIME-Version: 1.0
In-Reply-To: <10829881481323326@web27g.yandex.ru>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Long time system slow down on imx6
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Am 09.12.2016 um 23:42 schrieb Marco:
>     We are notice a very strange problem on a imx6 with kernel
>     Linux3.0.35-4.1.0 + xenomai_2.6.4. After machine runs for 8 - 10 hours
>     we found the system blocked in may different ways (user interface
>     tcp/ip interface ecc..)
>
>     Â
>
>     We check into /proc/timer_list and we found the next event was
>     scheduled in the past.
>
>     Â
>
>     We found some items about timer blocked but all the patches indicated
>     was already applied.
>
>     Â
>
>     Maybe someone have seen a similar problem ?
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
Hello,

i don't known if it is the same problem.
But we search a lost wakeup problem with "select" and a short timeout. (1ms)

Regards
   Johann


