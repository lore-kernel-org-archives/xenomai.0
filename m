Message-ID: <53667B67.3000302@xenomai.org>
Date: Sun, 04 May 2014 19:39:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53639F52.2070108@gmail.com>	<5363D871.1020901@xenomai.org>
 <CAAE81mss=omVtBQ7a0qvk_Kwy+qsrV1=ymWR05GkMAJ+h_t7pQ@mail.gmail.com>
In-Reply-To: <CAAE81mss=omVtBQ7a0qvk_Kwy+qsrV1=ymWR05GkMAJ+h_t7pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Is everything inside a function(task wchi made as a
 RT_task) is comes under Realtime ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ARUN GUPTA <mail@arungupta.co.in>, xenomai@xenomai.org

On 05/04/2014 04:15 AM, ARUN GUPTA wrote:
> How should we design Xenomai task where Linux CALLs also included.

That is simple: you should not. Linux calls mean loss of determinism.


-- 
                                                                Gilles.

