Date: Mon, 14 Dec 2015 23:19:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151214221910.GB16627@hermes.click-hack.org>
References: <44cb82ce.15337.151812ff429.Coremail.ericvic@163.com>
 <20151208112320.GA24418@hermes.click-hack.org>
 <5d8dd3ae.5ccc.1519e440866.Coremail.ericvic@163.com>
 <20151214064253.GC7035@hermes.click-hack.org>
 <653fe8d9.f6c1.1519f7e1ec0.Coremail.ericvic@163.com>
 <20151214080316.GB27298@hermes.click-hack.org>
 <613bbb7c.109f7.1519f9cec39.Coremail.ericvic@163.com>
 <1f53ebaf.11cf1.1519fbd18eb.Coremail.ericvic@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f53ebaf.11cf1.1519fbd18eb.Coremail.ericvic@163.com>
Subject: Re: [Xenomai] ipipe-gch-ipipe-3.0-imx6q latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: eric <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 14, 2015 at 05:05:48PM +0800, eric wrote:
>    Above i use the wrong version about latency test , now it works and the latency test 
>  
> RTD|     22.513|     39.832|     60.649|       0|     0|     11.269|     63.939
> RTD|     27.225|     40.068|     61.134|       0|     0|     11.269|     63.939
> RTD|     27.270|     40.531|     60.103|       0|     0|     11.269|     63.939
> RTD|     14.876|     39.540|     61.451|       0|     0|     11.269|     63.939
> RTD|     15.890|     39.760|     68.512|       0|     0|     11.269|     68.512
> RTD|     10.951|     29.915|     61.269|       0|     0|     10.951|     68.512
> RTD|     10.981|     12.596|     15.118|       0|     0|     10.951|     68.512
> RTD|     10.814|     12.648|     16.284|       0|     0|     10.814|     68.512
> RTD|     10.920|     12.636|     15.057|       0|     0|     10.814|     68.512
> RTT|  00:09:38  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     10.784|     12.672|     15.465|       0|     0|     10.784|     68.512
> RTD|     11.071|     12.602|     15.374|       0|     0|     10.784|     68.512
> RTD|     10.904|     12.632|     14.859|       0|     0|     10.784|     68.512
> RTD|     10.934|     12.639|     15.056|       0|     0|     10.784|     68.512
> RTD|     11.010|     12.575|     15.146|       0|     0|     10.784|     68.512
> 

So the latency is below 100us, much less than 500us. It seems a bit
high though, do you have any debug option enabled? Do you run this
with a real-time load?

-- 
					    Gilles.
https://click-hack.org

