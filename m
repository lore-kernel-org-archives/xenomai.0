Message-ID: <52DFAA18.6080703@xenomai.org>
Date: Wed, 22 Jan 2014 12:23:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52DF9C5F.70005@geral.com>
In-Reply-To: <52DF9C5F.70005@geral.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexandre COFFIGNAL <acoffignal@geral.com>
Cc: xenomai@xenomai.org

On 01/22/2014 11:24 AM, Alexandre COFFIGNAL wrote:
> Hi all,
> 
> I use two rtcan flexcan on imx28-evk board.
> 
> If both rtcan devices receive a data at the same time, this cause a freeze.
> After investigation, i found that if I replace in flexcan_rx_interrupt 
> these instructions :
> -        *(__be32 *)(cf->data + 0) =
> -            cpu_to_be32(flexcan_read(&mb->data[0]));
> -        *(__be32 *)(cf->data + 4) =
> -            cpu_to_be32(flexcan_read(&mb->data[1]));
> 
> by these
> 
> +        data0 = flexcan_read(&mb->data[0]);
> +        data1 = flexcan_read(&mb->data[1]);
> +
> +        cf->data[3]=((data0 >> 0)  & 0xFF) ;
> +        cf->data[2]=((data0 >> 8)  & 0xFF) ;
> +        cf->data[1]=((data0 >> 16)  & 0xFF) ;
> +        cf->data[0]=((data0 >> 24)  & 0xFF) ;
> +        cf->data[7]=((data1 >> 0)  & 0xFF) ;
> +        cf->data[6]=((data1 >> 8)  & 0xFF) ;
> +        cf->data[5]=((data1 >> 16)  & 0xFF) ;
> +        cf->data[4]=((data1 >> 24)  & 0xFF) ;
> 
> rtcan flexcan works perfectly.
> is  anyone know what is the problem with first instructions ?

Probably mb->data does not have the right alignment. Could you not
arrange to get it properly aligned? Failing that, you should use
put_unaligned instead of open coding it.


-- 
                                                                Gilles.

