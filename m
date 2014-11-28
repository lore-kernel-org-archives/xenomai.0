Date: Fri, 28 Nov 2014 12:48:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141128114831.GA6395@hermes>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
 <20141128111325.GD5069@hermes>
 <CAPozGfmL+OETXBHp39T8LRUt_9jHRqXjyYbFFeopDyNu0XCadA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPozGfmL+OETXBHp39T8LRUt_9jHRqXjyYbFFeopDyNu0XCadA@mail.gmail.com>
Subject: Re: [Xenomai] Section mismatch - Porting Xenomai to
 linux-xlnx-V14.5 zynq SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Sini <jhnsini@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Nov 28, 2014 at 12:19:19PM +0100, John Sini wrote:
> Hi,
> 
> Thanks for your reply.
> 
> 
> These from the following website:
> 
> https://github.com/sncn-private/linux-neocortex/commit/b83c15a3fa27931f557f147087bf019a46e81783

If you did not top post, it could be made clear to what you are
replying, my answer contained several answers to your several
questions. 

I guess you are replying to:


> > > But I have disabled all necessary options in the kernel config and
> > > still get these warnings.
> >
> > what necessary option?

And no, this patch does not disable the section mismatch detection
option, so it will not get the warnings to disappear.

-- 
					    Gilles.

