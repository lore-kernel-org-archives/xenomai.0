Message-ID: <507C89C7.2060600@xenomai.org>
Date: Tue, 16 Oct 2012 00:10:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507C8977.506@nta-inc.net>
In-Reply-To: <507C8977.506@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with ipipe-core-3.2.21-x86-1.patch?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 10/16/2012 12:08 AM, Jeff Webb wrote:

> I am trying to build xenomai from the xenomai-2.6.git repo under
> ubuntu 12.04 on a x86_64 desktop machine.  When I try to build a
> xenomai-enabled kernel from the 3.2.21 sources, the build fails with
> a compile error.  (Sorry, I didn't save the error message, but I can
> repeat the process if necessary.)  In order to get things to compile,
> I made the following change to ipipe-core-3.2.21-x86-1.patch.  Is
> this a bug?  If so, I'm wondering why no one else has run into this
> one yet.  I think I built a kernel without any compiler errors under
> ubuntu 10.04 using this patch, but I'm not 100% certain about that.


Yep, it has been reported already, and is fixed in the 3.4 branch, not
backported in 3.2 yet.

-- 
                                                                Gilles.

