From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Wed, 19 Jun 2013 10:51:50 +0200
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
In-Reply-To: <49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201306191051.50947.leo@alaxarxa.net>
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Flavian,

did you use 2.6.2.1?

I'm asking because there's a bug in 2.6.2 that maybe could be it.

Leo

A Dimecres, 19 de juny de 2013, HAUTBOIS Flavian va escriure:
> Thanks a lot for this complete and short answer.
> 
> - I didn't find any mention of PTHREAD_WARNSWS throughout the entire code 
via a grep command. However, I found a T_WARNSW mention in the Orocos files, 
which according to sigdebug.c apparently does the same thing.
> - This __wrap_send problem might be a key to solving this issue. I enclosed 
the "ldd" and "nm" traces of the some_core library (you can find mentions of 
__wrap_send in the nm.txt file, as well as the core_dump.txt file which 
contains a backtrace of the core dump when the program crashes).
> - I included the handler of sigdebug.c in my own file. I'm also enclosing 
what it returned in sigcpu.txt. I didn't find anything new or unexpected in 
it, but I have to admit that I don't know how to read 95% of the file.
> 
> Do you have any ideas why RTNet does not seem to be used? How to fix it?
> 


-- 
--
Linux User 152692
Catalonia

