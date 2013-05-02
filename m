From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Thu, 2 May 2013 10:37:24 +0200
References: <mailman.293.1366744201.1444.xenomai@xenomai.org>
	<006201ce45e4$5dc8e4f0$195aaed0$@com>
In-Reply-To: <006201ce45e4$5dc8e4f0$195aaed0$@com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201305021037.24643.leo@alaxarxa.net>
Subject: Re: [Xenomai] Qt - Xenomai compatibility problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: George Pontis <GPontis@z9.com>

A Dimarts, 30 d'abril de 2013, George Pontis va escriure:
> I took a snapshot from git of the current Xenomai code and put it in the 
hands of the software
> developers. They reported that Qt would not build after patching with 
Xenomai. The problem was that
> Qt uses "signals" as a keyword, and that conflicts with the function 
prototype for rt_task_notify
> under xenomai/native:
> 
> 
> int rt_task_notify(RT_TASK *task, rt_sigset_t signals);
> 
> 
> Although this is not a Xenomai problem, it might save some users the 
annoyance if the name "signals"
> could change.

I'm not a C++ expert, but to solve this you must encapsulate all the Xenomai 
calls of your software in a namespace. After that, I think that you could use 
the signal word without problem of collision with another signal word.

Regards,

Leopold

-- 
--
Linux User 152692
Catalonia

