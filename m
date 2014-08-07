Message-ID: <53E3D712.3070801@xenomai.org>
Date: Thu, 07 Aug 2014 21:44:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
 <53E3CD23.5040909@xenomai.org> <53E3D084.2000506@tuebingen.mpg.de>
 <53E3D2FF.5000407@xenomai.org> <53E3D50D.7060701@tuebingen.mpg.de>
In-Reply-To: <53E3D50D.7060701@tuebingen.mpg.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ludovic Righetti <ludovic.righetti@tuebingen.mpg.de>, Paul Janzen <pcj@xenomai.sez.to>, xenomai@xenomai.org

On 08/07/2014 09:35 PM, Ludovic Righetti wrote:
> 
>> I suspect you could run any loop, like cat /proc/interrupts, and see the
>> same issue. Are you running with a frame buffer in the no-x mode?
>>
> that's what I thought too, but /proc/interrupts or /proc/xenomai/sched
> (or others) do not seem to create any issue (below the output for
> interrupts, watching other /proc/ files give similar results).
> 
> Let me check about the fb.
> 

Just for kicks, could you try this patch ? it does NOT fix anything,
only maybe papering over an issue we don't know about yet:

diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 3391f4a..16d96d3 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -877,7 +877,7 @@ static int vfile_stat_next(struct
xnvfile_snapshot_iterator *it, void *data)
 		 * We are done with actual threads, scan interrupt
 		 * descriptors.
 		 */
-		goto scan_irqs;
+		return 0;

 	thread = link2thread(priv->curr, glink);
 	priv->curr = nextq(&nkpod->threadq, priv->curr);

> ludovic
> 
> 
> 
> 
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|     -2.322|     -1.053|      7.677|       0|     0|    
> -2.322|      7.677
> RTD|     -2.321|     -1.062|      8.224|       0|     0|    
> -2.322|      8.224
> RTD|     -2.322|     -1.058|      7.195|       0|     0|    
> -2.322|      8.224
> RTD|     -2.320|     -1.050|      7.070|       0|     0|    
> -2.322|      8.224
> RTD|     -2.321|     -1.056|      7.389|       0|     0|    
> -2.322|      8.224
> RTD|     -2.323|     -1.060|      6.365|       0|     0|    
> -2.323|      8.224
> RTD|     -2.320|     -1.050|      8.547|       0|     0|    
> -2.323|      8.547
> RTD|     -2.320|     -1.051|      8.097|       0|     0|    
> -2.323|      8.547
> RTD|     -2.320|     -1.062|      7.406|       0|     0|    
> -2.323|      8.547
> RTD|     -2.321|     -1.054|      9.558|       0|     0|    
> -2.323|      9.558
> RTD|     -2.321|     -1.061|      6.994|       0|     0|    
> -2.323|      9.558
> RTD|     -2.321|     -1.064|      5.545|       0|     0|    
> -2.323|      9.558
> 


-- 
Philippe.

