Date: Tue, 12 Jan 2016 09:30:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160112083038.GA7552@hermes.click-hack.org>
References: <CABShy44Gewr4z2F5em63qBE7yqXRO57DsEzZDLs+iWkWmh-mYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABShy44Gewr4z2F5em63qBE7yqXRO57DsEzZDLs+iWkWmh-mYg@mail.gmail.com>
Subject: Re: [Xenomai] hi friends how can i develop can bus driver xenomai
 rtos for beglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: BHISHMAPALSINH THAKOR <bjthakor.337@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jan 12, 2016 at 01:43:46PM +0530, BHISHMAPALSINH THAKOR wrote:
> hi friends how can i develop can bus driver xenomai rtos for beglebone

Hi

First of all the xenomai-git and xenomai-request addresses are not
where you should send your questions. As written on xenomai mailing
list page here:
https://xenomai.org/mailman/listinfo/xenomai/

The address of the xenomai mailing list is xenomai@xenomai.org.

Second, to answer your questions, the way to develop a driver for
Xenomai is the same as the one to develop a Linux driver, so any
documentation you would find on developing a driver for Linux
applies to Xenomai drivers. The difference is the API used by the
driver, Xenomai drivers use the RTDM API. Xenomai CAN drivers may be
found in the kernel/drivers/can in Xenomai sources, if you want to
use them as examples.

Regards.

-- 
					    Gilles.
https://click-hack.org

