Date: Tue, 28 Feb 2017 13:26:57 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170228132657.3a57a3d4@md1em3qc>
In-Reply-To: <9fda10bb-e8bc-330b-303f-90a61e03a122@siemens.com>
References: <20170228113150.12549-1-henning.schild@siemens.com>
 <20170228123358.03955486@md1em3qc>
 <9fda10bb-e8bc-330b-303f-90a61e03a122@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] x86/mm: Fix vmalloc_fault() to handle large
 pages properly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Am Tue, 28 Feb 2017 13:00:43 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 2017-02-28 12:33, Henning Schild wrote:
> > This guy is mainline since a while, was discovered in the context of
> > ipipe and has been backported to stable kernels. But in 4.1 it came
> > in at 4.1.19 and ipipe sits on 18, so cherry pick it on
> > ipipe-4.1.y.  
> 
> 4.1 should rather be updated to recent stable version.

I can offer to do that rebase on linux-4.1.y (currently 4.1.38) and test
it for x86.

But i would like to see that cherry pick to be thrown on current
ipipe-4.1.y anyways. Because with discussions on kernel updates we run
the risk to not do it after all and finally forget about that known
problem one more time.

> Jan
> 


