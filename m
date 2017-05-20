References: <1495194985.29062.9.camel@smigroup.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3621e629-53e4-288b-091d-890f6e9284f2@xenomai.org>
Date: Sat, 20 May 2017 09:57:21 +0200
MIME-Version: 1.0
In-Reply-To: <1495194985.29062.9.camel@smigroup.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] TM_INFINITE and TM_NONBLOCK not documented for some
 functions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 05/19/2017 01:56 PM, Mauro Salvini wrote:
> Hi,
> 
> reading 3.0.4 API documentation I discovered that for some blocking
> functions (e.g. rt_sem_p(), rt_mutex_acquire(), rt-event_wait() and
> relative _until calls) is not documented that TM_INFINITE or TM_NONBLOCK
> can be passed as timeout argument. Also on master branch sources doxygen
> code for these functions does not report that.
> Is this wanted or is a documentation leak? In the latter case, I can
> submit a patch to fix it.
> 

This is a leak, patch welcome.

-- 
Philippe.

