References: <1252191047.2961926.1442232205723.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55F6B99F.1090707@xenomai.org>
Date: Mon, 14 Sep 2015 14:12:15 +0200
MIME-Version: 1.0
In-Reply-To: <1252191047.2961926.1442232205723.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] how to check RT_MUTEX_INFO.owner
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/14/2015 02:03 PM, Frederik Bayart wrote:
> In the documentation of RT_MUTEX_INFO is described :
> RT_TASK owner : Current mutex owner, or null if unlocked.
> 
> But this is not a pointer, so it can't be compared with NULL. Should you check RT_TASK.handle ?
> 

You should compare the handle to NO_ALCHEMY_TASK, i.e.:

include/alchemy/task.h:#define NO_ALCHEMY_TASK	((RT_TASK){ 0, 0 })

-- 
Philippe.

