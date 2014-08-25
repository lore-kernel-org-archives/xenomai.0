From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sun, 24 Aug 2014 22:29:30 -0400
Message-ID: <20140825022930.GS17765@csclub.uwaterloo.ca>
References: <20140822213159.GQ17765@csclub.uwaterloo.ca>
 <53F7B7E1.80009@xenomai.org> <53F7BC3B.1080800@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53F7BC3B.1080800@xenomai.org>
Subject: Re: [Xenomai] Any idea how to fix ipipe failing to compile with ARM
 LPAE enabled?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> No, I do not think that LPAE uses exceptions. You can try moving the
> #endif at the bottom of the file to above the #ifdef CONFIG_IPIPE.

I did try that, and it did compile.  Never did boot, although I think I
may need to enable hypervisor mode in the boot loader before it will boot.
I will experiment some more.

-- 
Len Sorensen

