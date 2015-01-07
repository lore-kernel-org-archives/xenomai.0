Date: Wed, 7 Jan 2015 17:20:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150107162059.GB10298@hermes.click-hack.org>
References: <CA+C+_XQi7Nji4Ecq2VH4KfVxRdtWouE4=APu4bhfo8Yk4dZ-Zg@mail.gmail.com>
 <20150107101233.GC31996@hermes.click-hack.org>
 <3FCA47A3-7859-424A-B427-B2C45939C567@gmail.com>
 <20150107140651.GA10298@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150107140651.GA10298@hermes.click-hack.org>
Subject: Re: [Xenomai] Resource utilization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jan 07, 2015 at 03:06:51PM +0100, Gilles Chanteperdrix wrote:
> On Wed, Jan 07, 2015 at 05:06:43AM -0800, Mathew Benson wrote:
> > Heap utilization,
> > cache faults, page faults, BSS size, thread
> > stack high water mark, context switch count, kernel objects in
> > use, etc... Thanks. I forgot about VFS nodes.
> 
> Xenomai tasks are just Linux tasks, so for all these "metrics", you
> should turn to what Linux provides. For the stack high water mark
> for instance, I believe neither Linux nor Xenomai have this
> information.

In the case of page faults, and context switch count, mode switches,
you can find this information in /proc/xenomai/sched and
/proc/xenomai/stat

-- 
					    Gilles.

