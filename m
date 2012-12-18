Message-ID: <50D08B74.1010809@xenomai.org>
Date: Tue, 18 Dec 2012 16:27:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>
In-Reply-To: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Page fault - POSIX skin] Interraction between malloc
 en	nanosleep
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

On 12/18/2012 03:35 PM, alex alex wrote:
> Hi all,
>
> The attached program shows an interraction bug between malloc and nanosleep.
> The use of these two functions in a rt thread leads to a page fault.
> The dmesg output is:
>
> Xenomai: Switching test to secondary mode after exception #14 from
> user-space at 0xb760393e (pid 30730)
>
> I need to remove this switch because it prevents me to used the
> rtdm_sem_down function ( which return -1) in my RTDM driver and I guess it
> must also deteriorate the real time performance of my application.
>
> Thanks for your help.

If you are compiling with the Makefile in the attachment, your rt thread 
is not in fact using xenomai.

-- 
					    Gilles.

