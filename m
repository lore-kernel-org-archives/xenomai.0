Message-ID: <510AC9FC.3020807@xenomai.org>
Date: Thu, 31 Jan 2013 20:46:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1359596966.80583.YahooMailNeo@web163402.mail.gq1.yahoo.com>
In-Reply-To: <1359596966.80583.YahooMailNeo@web163402.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] adeos-ipipe-3.2.21-x86-5.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mark LoBuono <bitfiddler1@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/31/2013 02:49 AM, Mark LoBuono wrote:

> I see there is now a timer.c in the kernel code section along with the core.c
>  
> This is the missing link to using the ipipe patch on a kernel (without installing xenomai) and setting up time driven interrupts.
>  
> There is only one problem - an example of how to code this for test purposes.


Xenomai uses teh ipipe timer interface, so you can use Xenomai code as
an example.

-- 
                                                                Gilles.

