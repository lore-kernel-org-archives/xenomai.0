From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 18 Apr 2016 09:45:09 -0400
Message-ID: <20160418134509.GW11630@csclub.uwaterloo.ca>
References: <CAJ2oMh+Bp4iFpVSN0M+SvyL9WerjxJOgMWq-JEc2_AZvbvGdPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+Bp4iFpVSN0M+SvyL9WerjxJOgMWq-JEc2_AZvbvGdPg@mail.gmail.com>
Subject: Re: [Xenomai] kernel 3.12
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Apr 18, 2016 at 03:46:52PM +0300, Ran Shalit wrote:
> I see in I-PIPE patch that kernel 3.12 is not provided in the link for
> arm linux:
> 
> https://xenomai.org/downloads/ipipe/v3.x/arm/older/
> 
> Is there some way to use kernel 3.12 with Xenomai ?

We have done it in the past (by backporting the 3.14 patch to 3.12),
but it is not officially supported by xenomai.

We have since moved to 3.14 which made things simpler overall than
sticking with 3.12.

-- 
Len Sorensen

