Message-ID: <50C74977.4040207@xenomai.org>
Date: Tue, 11 Dec 2012 15:55:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOpsiFBEZLFUrc_Sjf88J66Q0zDgmrNkaQ5O4xoz=iwYQ@mail.gmail.com>
In-Reply-To: <CAPpP=rOpsiFBEZLFUrc_Sjf88J66Q0zDgmrNkaQ5O4xoz=iwYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM/POSIX - Select mask return value missing in case
 of	timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: xenomai@xenomai.org

On 12/11/2012 03:07 PM, alex alex wrote:
> Hi,
> 
> 
> The problem is the following:
> 
> 
> When the timeout interval expires of the “select” function the return value
> of FD_ISSET(fdr,&readfds) is 1 whereas it should be 0.
> 
> In ksrc/skins/posix/syscall.c we can see that they are not copy to
> userspace of select return value in case of timeout.
> 
> 
> 
> The attached code shows this bug with the use of a rtdm driver.

So, could you try making the obvious change in the code? Or do you need
me to send you the patch?

-- 
					    Gilles.

