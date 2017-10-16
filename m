Date: Mon, 16 Oct 2017 10:23:28 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171016102328.618554d2@md1em3qc>
In-Reply-To: <DB6PR0701MB2456035E412673C8D6A78F47B5760@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24565343D7707462B972F1ACB5710@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <b846b4f5-2bdc-1540-1504-6973e65d6a80@xenomai.org>
 <DB6PR0701MB2456035E412673C8D6A78F47B5760@DB6PR0701MB2456.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] --session= is not a recognized option when using
 Posix skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, 7 Oct 2017 01:33:06 +0000
Giulio Moro <g.moro@qmul.ac.uk> wrote:

> > The POSIX API does not depend on copperplate, so
> > you don't have support for multi-process sessions when linking
> > against libcobalt exclusively.   
> 
> Ok. All we need this for is to prevent multiple instances of our
> program to be started at the same time. What would you suggest as the
> best way to check for the existence of a given real-time task using
> the POSIX API? We could just grep /proc/xenomai/sched/stat, or is
> there a better solution?

In the init-phase your process is probably not real-time yet. So you
can implement a PID-file-based singleton or something alike. Or offload
that task to systemd or whatever you use as init-system.

Henning

> Thanks,
> Giulio
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


