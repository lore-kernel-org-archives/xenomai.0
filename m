From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Thu, 9 May 2013 14:50:15 +0200
References: <mailman.293.1366744201.1444.xenomai@xenomai.org>
	<201305021037.24643.leo@alaxarxa.net>
	<036801ce481b$62cd9480$2868bd80$@com>
In-Reply-To: <036801ce481b$62cd9480$2868bd80$@com>
MIME-Version: 1.0
Message-Id: <201305091450.16890.leo@alaxarxa.net>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Qt - Xenomai compatibility problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

A Divendres, 3 de maig de 2013, George Pontis va escriure:
> > -----Original Message-----
> > From: Leopold Palomo-Avellaneda [mailto:leo@alaxarxa.net]
> > Sent: Thursday, May 02, 2013 1:37 AM
> > To: xenomai@xenomai.org
> > Cc: George Pontis
> > Subject: Re: [Xenomai] Qt - Xenomai compatibility problem
> > 
> > A Dimarts, 30 d'abril de 2013, George Pontis va escriure:
> > > I took a snapshot from git of the current Xenomai code and put it in the
> > hands of the software
> > > developers. They reported that Qt would not build after patching with
> > Xenomai. The problem was that
> > > Qt uses "signals" as a keyword, and that conflicts with the function
> > prototype for rt_task_notify
> > > under xenomai/native:
> > >
> > >
> > > int rt_task_notify(RT_TASK *task, rt_sigset_t signals);
> > >
> > >
> > > Although this is not a Xenomai problem, it might save some users the
> > annoyance if the name "signals"
> > > could change.
> > 
> > I'm not a C++ expert, but to solve this you must encapsulate all the 
Xenomai
> > calls of your software in a namespace. After that, I think that you could 
use
> > the signal word without problem of collision with another signal word.
> > 
> > Regards,
> > 
> > Leopold
> 
> That that won't work because Qt defines the keyword "signals" using #define,
> which is handled by the preprocessor.  The preprocessor ignores namespaces
> so namespaces wouldn't help in this case.
> 
oops,

thanks for the info. I didn't know that. I could only say that it could not be 
a good idea to make a Qt program with realtime, IMHO. Quoting Jan Kiszka from 
another mail in the list, talking about a program written in Java:

>Writing some non-RT configuration and monitoring front-end in Java is
>fine, but the actual control task is better done in C (or C++ if you
>like). The RT process containing the control task could then have a
>another thread, low priority, that does the non-RT communication with
>the front-end via TCP and transfers any parameter updates to the RT task
>(lock-free or synchronized with a compatible locking mechanism). That's
>the standard design pattern for real-time control applications.

in my opinion this could be applied to a Qt program.

Otherwise, good info about the namespaces and preprocessors.

Regards,

Leopold
-- 
--
Linux User 152692
Catalonia

