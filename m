Date: Fri, 5 Oct 2018 12:11:28 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20181005121128.7898c167@md1pvb1c.ad001.siemens.net>
In-Reply-To: <0d0ab124-f861-da42-433c-d61195a5e13f@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
 <20180927144203.5e7d006b@md1pvb1c.ad001.siemens.net>
 <20181001165112.18eafb36@md1pvb1c.ad001.siemens.net>
 <0d0ab124-f861-da42-433c-d61195a5e13f@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [I-PIPE][PATCH 00/32] 4.14.71/x86_64 port (split
 series)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Am Mon, 1 Oct 2018 17:03:52 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 10/01/2018 04:51 PM, Henning Schild wrote:
> > Am Thu, 27 Sep 2018 14:42:03 +0200
> > schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:
> >   
> >> Thanks! I just tried it on my test setup. All looking good except
> >> for one smokey test.
> >>  
> >>>  ./smokey --trace --run=sigdebug    
> >>
> >> Crashes the box without any further feedback, also nothing on the
> >> serial.
> >>
> >> Will look into that.  
> > 
> > I already found that the page-fault caused by sigdebug is causing
> > the problem.
> > 
> > ./smokey --verbose=42 --trace=42 --run=sigdebug
> > 
> > Gave me more output. The "*mem = 0xff;" is the last thing it does.
> > Did not look into the kernel(s) and the page-fault handler yet.  
> 
> This looks like the PF event not being reported through the pipeline
> via the __ipipe_notify_trap() call. This points the finger to
> __ipipe_trap_prologue() (or whatever code should call it but does
> not).

I instrumented __ipipe_trap_prologue and did not even see the #PF
there. So it is either in the assembly before that or we do not have
the trap handler mapped or something like that. nopcid and nopti did
not help.
For further analysis i would likely have to move my setup to kvm. Can
anyone actually reproduce this?

Since i will be out of office in the next two weeks, i will not be able
to investigate further before 10/22.

Henning



