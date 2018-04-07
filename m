References: <CA+K1mPGTJBd5OmUUhCcLVJMaHPhrwDgO34xtP6gG6qCvvw2BOw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <77777f1c-8678-51e0-3a40-919305fd665b@xenomai.org>
Date: Sat, 7 Apr 2018 09:57:06 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPGTJBd5OmUUhCcLVJMaHPhrwDgO34xtP6gG6qCvvw2BOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Context switch to secondary mode in xenomai tasks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 04/06/2018 06:51 PM, C Smith wrote:
> Hi all--
> 
> Our real time application has a main rt_task which runs concurrently with
> several other rt_tasks (spawned using rt_task_create) and we are concerned
> about a context switch in one of the tasks. The problematic task uses
> libxml2 to parse an xml document sent over ethernet which seems to cause a
> switch to secondary mode. Would this also switch the other tasks we are
> running to secondary mode, or is it isolated?

This is isolated in the sense that only the xml parser task will switch
to secondary mode.

However, this may still cause a priority inversion for any rt thread
which synchronizes with that switching thread, since the former may end
up waiting for a wake up event coming from the latter, which might be
delayed until it switches back to rt mode.

-- 
Philippe.

