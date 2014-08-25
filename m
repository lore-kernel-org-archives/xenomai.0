From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 25 Aug 2014 09:22:36 -0400
Message-ID: <20140825132236.GT17765@csclub.uwaterloo.ca>
References: <20140822213159.GQ17765@csclub.uwaterloo.ca>
 <53F7B7E1.80009@xenomai.org> <53F7BC3B.1080800@xenomai.org>
 <20140825022930.GS17765@csclub.uwaterloo.ca>
 <53FAF3A6.6020500@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53FAF3A6.6020500@xenomai.org>
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

On Mon, Aug 25, 2014 at 10:28:22AM +0200, Gilles Chanteperdrix wrote:
> Does the kernel configured without LPAE boot?

Yes.  If I enable KVM (and hence LPAE), I get no console output at all.
I don't think I tried LPAE without KVM yet.  Maybe I should.  I think
I will finish moving from 3.12 to 3.14 first though.

-- 
Len Sorensen

