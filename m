Date: Thu, 20 Nov 2014 20:21:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141120192151.GD4545@sisyphus.hd.free.fr>
References: <C34B698C-EAE2-4FDB-806A-42534A6CBD22@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C34B698C-EAE2-4FDB-806A-42534A6CBD22@gatech.edu>
Subject: Re: [Xenomai] GPU Processing Question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

On Thu, Nov 20, 2014 at 02:10:10PM -0500, Yogi A. Patel wrote:
> Hi -
> 
> I’m interested in using a GPU processing library (ArrayFire
> <http://arrayfire.com/>) to run some computationally heavy models
> in our real-time framework (data acquired->run in model->generate
> some output via DAQ).
> 
> I don’t know much about integrating GPU processing into the loop -
> and am looking for basic suggestions on the pros/cons when
> considering hard real-time demand.
> 
> Any thoughts from anyone are appreciated. Examples are also
> appreciated!

Using GPU shaders implies interacting with a Linux GPU driver. So,
will get the thread using them out of primary mode. So, if you want
to use them and keep running in primary mode, you will have to port
GPU drivers to Xenomai RTDM skin. The problem being that a lot of
GPU drivers are proprietary, so, porting them to RTDM will be
difficult, I mean very difficult, if not impossible. Among the free
ones, some drivers do not really execute the shaders on the GPU (was
surprised by that using Cg shaders with nouveau drivers recently,
granted, this is probably an old version of the nouveau drivers,
since it is the Debian stable version, but this is nevertheless
surprising). And finally a modern GPU driver is something rather
complex, which makes it even more difficult to get it to use RTDM.

-- 
					    Gilles.

