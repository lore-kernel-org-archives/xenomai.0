Date: Wed, 2 Dec 2015 20:11:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151202191154.GA14193@hermes.click-hack.org>
References: <D9EDB4F689BF9F4EA6F2158A073942732E7BF245@de08ex3008.global.ds.honeywell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9EDB4F689BF9F4EA6F2158A073942732E7BF245@de08ex3008.global.ds.honeywell.com>
Subject: Re: [Xenomai] struct rtdm_fd usage in application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Dec 02, 2015 at 06:38:39PM +0000, Heinick, J Michael wrote:
> What file(s) do we have to include in an application that interacts
> with a RTDM driver with a node in the /dev/rtdm directory and needs the
> declaration of the rtdm_fd structure?  Any additional information on,
> and examples of, the usage of the rtdm_fd structure would be appreciated.
> 
> Currently, we have a RTDM driver that installs with insmod, creates the
> node in /dev/rtdm, uninstalls with rmmod, and removes the node from
> /dev/rtdm.  At this early stage this RTDM driver is only a skeleton that
> will log a message with rtdm_printk whenever the read, write, and ioctl
> handlers are called.  From the Xenomai 3.0.1 API documentation it appears
> that an application interacting with this driver through open, close,
> read, write, and ioctl will need to have the declaration of the rtdm_fd
> structure. 

Absolutely not. The open, close, read, write calls are part of the
POSIX API, which does not define a struct rtdm_fd. The file
descriptors are passed as integers.

-- 
					    Gilles.
https://click-hack.org

