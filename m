Date: Fri, 27 Nov 2015 15:30:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151127143058.GB31584@hermes.click-hack.org>
References: <CANWkrROw+Ja4byL=aHjb8NpGHbNT2ebC5NH=wTpPN75C76nz9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWkrROw+Ja4byL=aHjb8NpGHbNT2ebC5NH=wTpPN75C76nz9A@mail.gmail.com>
Subject: Re: [Xenomai] Module reference count for real-time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 27, 2015 at 08:09:15AM +0200, Michael Smith wrote:
> Hi.
> I am in the process of writing a rtdm device driver that is accessing
> another rtmd driver.
> But I am having difficulty finding an rtdm alternative for something
> like the try_module_get() &
> module_put().
> Where the 1st module effectively locks the 2nd module from unloading
> (via the module's reference count) until the 1st module is finished
> accessing it.
> 
> Is there workaround for this, or an Xenomai alternative?

You can use try_module_get() and module_put(), starting from the
I-pipe patch for Linux 3.14, these can be called from real-time
context. Also note that if you plan to use
try_module_get()/module_put() from the driver open and close
callbacks, these callbacks are called from secondary mode anyway, so
they can use any Linux service.

-- 
					    Gilles.
https://click-hack.org

