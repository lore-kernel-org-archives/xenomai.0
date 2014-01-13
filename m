Message-ID: <52D44A71.9030602@xenomai.org>
Date: Mon, 13 Jan 2014 21:20:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8ceffc54095e43d88f6dfa0edd0bb852@DBXPR03MB093.eurprd03.prod.outlook.com>
 <52496200.2010808@xenomai.org>
 <295e5f6a1e6849079d9fb3e53dcc1827@DBXPR03MB093.eurprd03.prod.outlook.com>
 <524B1F6C.7080705@xenomai.org>
 <0181d61119d749ecaf4bfea3b3c827f3@DBXPR03MB093.eurprd03.prod.outlook.com>
 <524BDFD7.5010104@xenomai.org>
 <753016a9a00c43fca6252ef26d024461@DBXPR03MB093.eurprd03.prod.outlook.com>
 <524EA63E.8080507@xenomai.org>
 <11e0247bbd174e5bb553b1374326c219@DBXPR03MB093.eurprd03.prod.outlook.com>
In-Reply-To: <11e0247bbd174e5bb553b1374326c219@DBXPR03MB093.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] No GPIO IRQ on imx28(apf28), kernel 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine MOREL <A.MOREL@polysoude.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/13/2014 05:38 PM, Antoine MOREL wrote:
> Hello Gilles,
> 
> You updated the adeos patch but you forgot to include the <linux/ipipe.h> in the gpio-mxs.c

I applied the patch you told me fixed the issue... Will add the #include
then.


-- 
                                                                Gilles.

