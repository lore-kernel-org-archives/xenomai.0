Date: Fri, 21 Sep 2012 10:28:45 +0200
From: Michael Wisse <mwisse@hs-harz.de>
In-reply-to: <5058C094.9060106@xenomai.org>
Message-id: <969688a82a4682b9.505c415d@hs-harz.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <50587BCE.9000402@hs-harz.de> <50587D7B.3060507@xenomai.org>
	<505882F9.90703@hs-harz.de> <5058C094.9060106@xenomai.org>
Subject: Re: [Xenomai] native skin example with rt_pipe_monitor() ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Are there plans to remove the rt_pipe API in near future ?

Michael

----- Original Message -----
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Tuesday, September 18, 2012 8:42 pm
Subject: Re: [Xenomai] native skin example with rt_pipe_monitor() ?
To: Michael Wisse <mwisse@hs-harz.de>
Cc: xenomai@xenomai.org


> On 09/18/2012 04:19 PM, Michael Wisse wrote:
> 
> > Thanks for the link to the API documentation, but I'm looking for an 
> 
> 
> > example.
> 
> The rt_pipe API is deprecated. Non deprecated APIs such as XDDP sockets
> have examples, see:
> examples/rtdm/profiles/ipc/xddp-*
> 
> -- 
>                                                                 Gilles.

