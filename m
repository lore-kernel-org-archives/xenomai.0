Date: Tue, 15 Dec 2015 07:17:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215061746.GI16627@hermes.click-hack.org>
References: <44cb82ce.15337.151812ff429.Coremail.ericvic@163.com>
 <20151208112320.GA24418@hermes.click-hack.org>
 <5d8dd3ae.5ccc.1519e440866.Coremail.ericvic@163.com>
 <20151214064253.GC7035@hermes.click-hack.org>
 <653fe8d9.f6c1.1519f7e1ec0.Coremail.ericvic@163.com>
 <20151214080316.GB27298@hermes.click-hack.org>
 <613bbb7c.109f7.1519f9cec39.Coremail.ericvic@163.com>
 <1f53ebaf.11cf1.1519fbd18eb.Coremail.ericvic@163.com>
 <20151214221910.GB16627@hermes.click-hack.org>
 <6dfbaaba.3bb5.151a3220b87.Coremail.ericvic@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dfbaaba.3bb5.151a3220b87.Coremail.ericvic@163.com>
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

On Tue, Dec 15, 2015 at 08:54:56AM +0800, eric wrote:
> >
> >So the latency is below 100us, much less than 500us. It seems a bit
> >high though, do you have any debug option enabled? Do you run this
> >with a real-time load?
> >
> >-- 
> >					    Gilles.
> >https://click-hack.org
> 
>         I can not run real-time load ,it always stop  the flowing step.  So  i use some other load program .And I do not  enabled  debug option.
> root@imx6qdlsolo:/opt/x3/bin# ./xeno-test
> Started child 29228: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper ./xeno-test
> ++ echo 0
> ++ testdir=/opt/imx6/smp3/xenomai-3.0.1/x3/bin
> ++ /opt/imx6/smp3/xenomai-3.0.1/x3/bin/smokey --run
> arith OK
> bufp OK
> iddp OK
> leaks OK

I was rather thinking about running the user-space load which
creates high latencies with your own latency test.

But if you are interested in running xeno-test, you should check its
syntax:
- either by running it with the -h or --help argument
- or by checking its manual page, either on your disk or on xenomai
website:
https://xenomai.org/documentation/xenomai-3/html/man1/xeno-test/
- or by reading the page where we explain how we do the benchmarks
we publish:
https://xenomai.org/2014/07/benchmarking-with-xeno-test/

Regards.

-- 
					    Gilles.
https://click-hack.org

