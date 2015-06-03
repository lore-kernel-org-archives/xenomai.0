Date: Wed, 3 Jun 2015 15:09:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150603130935.GR27570@hermes.click-hack.org>
References: <CAHH_qdD+0RnjOZejUuYp9Z7-7sSDfEE+c=sZGds3i_u=8zpKvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHH_qdD+0RnjOZejUuYp9Z7-7sSDfEE+c=sZGds3i_u=8zpKvg@mail.gmail.com>
Subject: Re: [Xenomai] [Xenomai 2.6] iMX6 + linux 3.16.7 + ipipe arm-7 +
 inconsistent lock state on kdevtmpfs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gautier HAOUY <gautier.haouy@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jun 03, 2015 at 03:00:33PM +0200, Gautier HAOUY wrote:
> Hello everyone,
> 
> I'm requesting once again your help as I'm getting an "INFO message on
> inconsistent lock state" while booting linux 3.16.7 with ipipe arm-7 on an
> iMX6 platform. I would like to understand how I could dive in and determine
> if this is going to be an issue or just informational.
> 
> I kindly ask for assistance as I did not find anything on the internet on
> how to proceed with such case.

Please try disabling CONFIG_TRACE_IRQFLAGS. It is known to be broken
with the I-pipe patch on ARM. You probably can not disable it
directly, you will have to remove all the options that depend on
this one.

-- 
					    Gilles.

