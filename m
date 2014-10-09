Date: Thu, 9 Oct 2014 03:07:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141009010715.GC30368@sisyphus.hd.free.fr>
References: <CANgF67RGt50E9JE89caZ+v4+4Dr4x2rF20BoBMuDyteMPrwY=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgF67RGt50E9JE89caZ+v4+4Dr4x2rF20BoBMuDyteMPrwY=Q@mail.gmail.com>
Subject: Re: [Xenomai] help for understanding xenomai examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: agnes jurek <agnessjurek@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Oct 08, 2014 at 11:04:03PM +0300, agnes jurek wrote:
> I want to use examples about xenomai rtdm without device. I don't have any
> external device for now.When I executed "bufb-label.c" under
> xenomai/examples/rtdm/profiles/ipc, my pc was freezed and I shut down it.
> Maybe it entered an infinite loop?

More likely you have an oops when starting this application. Please
try and capture the kernel console output. For starters, try and run
the example in text mode instead of starting in graphical mode.

For a proper bug report, you should also give us more information
about the bugs. If you were someone different, I would point you to
this document:
http://xenomai.org/asking-for-help/

But I know that you will not bother to read it.

--
					    Gilles.

