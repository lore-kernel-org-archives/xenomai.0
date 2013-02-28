Message-ID: <512EE94A.8000802@xenomai.org>
Date: Thu, 28 Feb 2013 06:21:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512E8C10.8080707@ruggedcom.com> <512E904A.2080408@xenomai.org>
	<512E9417.20708@ruggedcom.com>
In-Reply-To: <512E9417.20708@ruggedcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Is CLOCK_HOST_REALTIME supported for powerpc?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/28/2013 12:17 AM, Makarand Pradhan wrote:

> Thanks Gilles.
> 
> Clocktest indicates:
> 
> "hostrt data area is not live"
> 
> I've turned on
> 
> CONFIG_HAVE_IPIPE_HOSTRT=y
> CONFIG_XENO_OPT_HOSTRT=y
> 
> while building the kernel. I guess that's not sufficient to get it to work.


You can not really turn CONFIG_HAVE_IPIPE_HOSTRT on, it is set by the
architecture if it supports it. Supporting hostrt is more a property of
the I-pipe patch than of Xenomai. So, you would have to upgrade to a
more recent I-pipe to have this support.

> 
> Unfortunately I cannot upgrade to 2.6.2 so will try to selectively port 
> the changes required for hostrt.


2.6.2.1 is the latest release, please do not use 2.6.2. 2.6.2.1 is in
the same branch as 2.6.0, so it is completely ABI and API compatible.
Anyway, you do as you wish, but please do not expect support from us for
2.6.0.

-- 
                                                                Gilles.

