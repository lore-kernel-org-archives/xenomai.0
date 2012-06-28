Message-ID: <4FEC570A.8040406@grandegger.com>
Date: Thu, 28 Jun 2012 15:07:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
	<4FEC3FF0.1050307@grandegger.com>,
	<4FEC4245.9090804@grandegger.com>
	<D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>
	<4FEC46B5.7060700@grandegger.com> <4FEC5381.9040804@epfl.ch>
In-Reply-To: <4FEC5381.9040804@epfl.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Klas Kronander <klas.kronander@epfl.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2012 02:52 PM, Klas Kronander wrote:
> Hi,
> 
> ok did that. The return value from rt_dev_socket is -14. I could not
> find the definition of EPROTONOSUPPORT anywhere, so I don't know if this
> was the expected value?

~$ errno 14
#define	EFAULT		14	/* Bad address */

Hm, strange. I have to look that up.
Wolfgang.

