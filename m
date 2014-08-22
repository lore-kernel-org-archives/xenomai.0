From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 22 Aug 2014 17:31:59 -0400
Message-ID: <20140822213159.GQ17765@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Any idea how to fix ipipe failing to compile with ARM
	LPAE enabled?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Any idea how to fix ipipe to not cause a linking error when LPAE is enabled on arm?

I see the function __ipipe_pin_range_globally is inside an ifdef block that says essentially:

#if !IPIPE
define __ipipe_pin_range_globally as do nothing
#else
#if !LPAE
define __ipipe_pin_range_globally function
#endif
#endif

So if IPIPE and LPAE are both true, then the function is never defined.

This is in arch/arm/mm/fault.c

-- 
Len Sorensen

