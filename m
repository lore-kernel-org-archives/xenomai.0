Message-ID: <5061E133.5040501@xenomai.org>
Date: Tue, 25 Sep 2012 18:52:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <743819185.213171.1348577986595.JavaMail.ngmail@webmail24.arcor-online.net>
In-Reply-To: <743819185.213171.1348577986595.JavaMail.ngmail@webmail24.arcor-online.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segmentation fault in RT_TASK with too big arrays?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hahnchristopher@arcor.de
Cc: xenomai@xenomai.org

On 09/25/2012 02:59 PM, hahnchristopher@arcor.de wrote:
> Hello,
> 
> I tried to create an int array with big size (up to 160k), but all
> sizes over 4096 throws segmentation faults! That FAQ for POSIX skin
> tells me, that there is a variable thread stack size. Is there a
> equivalent native call for pthread_attr_setstacksize() ? Or do I have
> an other problem?

The stack size is probably the issue. When using the native skin, the
stack size is passed as a parameter to the rt_task_create function, see:

http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__task.html#ga03387550693c21d0223f739570ccd992

-- 
					    Gilles.

