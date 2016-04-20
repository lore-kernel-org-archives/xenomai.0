Date: Wed, 20 Apr 2016 15:48:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160420134815.GB27252@hermes.click-hack.org>
References: <57155DFC.9000606@sigmatek.at>
 <20160419191052.GE29711@hermes.click-hack.org>
 <20160419193006.GG29711@hermes.click-hack.org>
 <5717554B.1090905@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5717554B.1090905@sigmatek.at>
Subject: Re: [Xenomai] rt task & stack overflow
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Wed, Apr 20, 2016 at 12:09:15PM +0200, Johann Obermayr wrote:
> root@sigmatek-arm-mp:~# ./signaltest01arm
> Segmentation fault
> 
> root@sigmatek-arm-mp:~# ./signaltest01arm --sigstack
> linux: signal_handler: 11
> 
> root@sigmatek-arm-mp:~# ./signaltest01armx
> Segmentation fault
> 
> root@sigmatek-arm-mp:~# ./signaltest01armx --sigstack
> Segmentation fault

Have you tried to run the program in gdb to see where the
segmentation fault happens?

> 
> root@sigmatek-arm-mp:~#
> 
> for a standard linux thread the function sigaltstack will work correct.
> But not with xenomai (rt_task_shadow)

The issue is probably not related to sigalstack at all.

> 
> we use kernel 3.0.53 & xenomai 2.6.2.1.
> 
> regards
>    Johann
> 
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

-- 
					    Gilles.
https://click-hack.org

