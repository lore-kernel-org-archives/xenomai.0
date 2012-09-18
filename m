Message-ID: <5058C094.9060106@xenomai.org>
Date: Tue, 18 Sep 2012 20:42:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50587BCE.9000402@hs-harz.de> <50587D7B.3060507@xenomai.org>
	<505882F9.90703@hs-harz.de>
In-Reply-To: <505882F9.90703@hs-harz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] native skin example with rt_pipe_monitor() ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Wisse <mwisse@hs-harz.de>
Cc: xenomai@xenomai.org

On 09/18/2012 04:19 PM, Michael Wisse wrote:

> Thanks for the link to the API documentation, but I'm looking for an 

> example.

The rt_pipe API is deprecated. Non deprecated APIs such as XDDP sockets
have examples, see:
examples/rtdm/profiles/ipc/xddp-*

-- 
                                                                Gilles.

