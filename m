Date: Mon, 30 Mar 2015 17:20:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150330152002.GL32766@hermes.click-hack.org>
References: <CAKk99t15m2dbUzGNxi4TsAVk4suZGc14qxv2cBh+iG1nWcM-kQ@mail.gmail.com>
 <55196828.9020207@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55196828.9020207@xenomai.org>
Subject: Re: [Xenomai] There is XDDP Sockets support in kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 30, 2015 at 05:13:44PM +0200, Philippe Gerum wrote:
> On 03/30/2015 04:55 PM, Helder Daniel wrote:
> > Hi,
> > 
> > When trying to compile a kernel module that sets up a XDDP socket (code
> > snippet below) with Xenomai 3.x-rc3 on Cobalt setup,
> > rtdm_bind() returns ENOSYS.
> > This means that XDDP sockets can not be used in kernel?
> > 
> 
> No, in this case it likely means that you are calling it from a
> real-time context (i.e. a real-time kthread started with
> rtdm_task_create()). The binding op can only run from a non-rt context,
> e.g. module init code, regular kthread context, _nrt handler.

Or that XDDP is not enabled in the kernel configuration, maybe?

-- 
					    Gilles.

