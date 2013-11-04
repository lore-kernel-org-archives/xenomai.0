Message-ID: <5277C73E.3020007@xenomai.org>
Date: Mon, 04 Nov 2013 17:11:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5277C86F.5070603@wanadoo.fr>
In-Reply-To: <5277C86F.5070603@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] big deviation on clock_nanosleep wait time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 11/04/2013 05:16 PM, Thierry Bultel wrote:
> Hi,
> 
> My configuration is
> xenomai-2.6.3 + ipipe-1.18-13, freescale kernel rel_imx_3.0.35_4.0.0, on
> the IMX6Q.
> 
> I want to use CONFIG_HIGH_RES_TIMERS and CONFIG_HZ=100, which is the
> default value for the IMX.

Do you observe the same issue without CONFIG_HIGH_RES_TIMERS?


-- 
                                                                Gilles.

