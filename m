Message-ID: <526579EA.50203@xenomai.org>
Date: Mon, 21 Oct 2013 21:00:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdYjRFk8rUs5x=g_cRYfOu=nP2DY-MAL9py9cZ9rwKMqQ@mail.gmail.com>
In-Reply-To: <CAKKWdtdYjRFk8rUs5x=g_cRYfOu=nP2DY-MAL9py9cZ9rwKMqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] how to use an alarm handler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 10/19/2013 04:50 PM, ali hagigat wrote:
> I have two questions:

Hi,

> 
> 1) I want to create an alarm object in kernel space and an alarm
> handler and then i have a user space task which waits for that alarm
> defined inside kernel.
> How can i reference the created alarm object by that user-space task?
> and how that task is unblocked inside kernel?

See:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__alarm.html

> 
> 2) is there any book and tutorial about the real-time programming and
> developing code for Xenomai?

"Building embedded Linux systems" has a chapter about Xenomai. A web search
finds the following tutorial:

http://www.cs.ru.nl/lab/xenomai/
with the following exercises:
http://www.cs.ru.nl/lab/xenomai/exercises/index.html

I once tried to explain how to port POSIX applications to Xenomai:
https://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai

Also, I know this is not what you ask, but you may have a look at the API
documentation:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native.html

Regards.

-- 
                                                                Gilles.

