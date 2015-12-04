Date: Fri, 4 Dec 2015 21:41:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151204204107.GE29398@hermes.click-hack.org>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
 <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>
 <20151201181155.GC30041@hermes.click-hack.org>
 <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
 <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
 <20151204163315.GD29398@hermes.click-hack.org>
 <5661E4D5.5010804@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5661E4D5.5010804@web.de>
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jochen Behnke <jk.behnke@web.de>
Cc: xenomai@xenomai.org

On Fri, Dec 04, 2015 at 08:09:09PM +0100, Jochen Behnke wrote:
> Hello Gilles,
> 
> thanks for your response.
> 
> >>
> >> Now I have the following questions
> >> 1. What is meant by "domain stalled", "current" and "current+stalled"?
> >> 2. What is that process having ID "[   0]"
> >> 3. How can I tell processes running in secondary mode from others?
> >>     (just by looking at the priority value?)
> >>
> >> Any hint on interpreting my frozen file is appreciated.
> >
> > This trace is worthless. To have a meaningful trace, enable tracing
> > on functions entry (the default when you enable the I-pipe tracer).
> >
> Do you mean CONFIG_FUNCTION_TRACE?

I mean CONFIG_IPIPE_TRACE_MCOUNT

-- 
					    Gilles.
https://click-hack.org

