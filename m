Message-ID: <512E9417.20708@ruggedcom.com>
Date: Wed, 27 Feb 2013 18:17:43 -0500
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
References: <512E8C10.8080707@ruggedcom.com> <512E904A.2080408@xenomai.org>
In-Reply-To: <512E904A.2080408@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Gilles.

Clocktest indicates:

"hostrt data area is not live"

I've turned on

CONFIG_HAVE_IPIPE_HOSTRT=y
CONFIG_XENO_OPT_HOSTRT=y

while building the kernel. I guess that's not sufficient to get it to work.

Unfortunately I cannot upgrade to 2.6.2 so will try to selectively port 
the changes required for hostrt.

Warm Rgds,
Makarand.

On 27/02/13 06:01 PM, Gilles Chanteperdrix wrote:
> clocktest -C 42 -D


-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


