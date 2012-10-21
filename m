Message-ID: <508344D9.1010700@xenomai.org>
Date: Sun, 21 Oct 2012 02:42:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD0gx3ij+c4m4N9gJXd5HGK2Mu1H24jR+zJtwMhSqDBE40hWnQ@mail.gmail.com>
In-Reply-To: <CAD0gx3ij+c4m4N9gJXd5HGK2Mu1H24jR+zJtwMhSqDBE40hWnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Questions about latest kernel rev supported for
	Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bill Smith <shoozboot@gmail.com>
Cc: xenomai@xenomai.org

On 10/20/2012 11:02 PM, Bill Smith wrote:

> Hello all,
> 
> I am getting started with Xenomai on the BeagleBone, and I have a few
> questions about the best route to take with cross compiling a kernel with
> the most recent support.
> 
> So far I can't seem to find any reference to the most recent kernel
> revision that is supported by Xenomai 2.6.2


Xenomai 2.6.2 is not out yet. But when it is out, simply go in the
ksrc/arch/arm/patches directory and look for the available patches.

> So if I wanted to integrate Xenomai with this image, what would the best
> plan be for that in terms of kernel sources and a cross compilation
> environment?  And would this recent A6 image on the BeagleBone be
> compatible with Xenomai 2.6.2?


The I-pipe patch maintained by the Xenomai project has no support for
BeagleBone.

-- 
                                                                Gilles.

