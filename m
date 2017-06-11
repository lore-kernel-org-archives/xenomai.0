References: <DB6PR0701MB24569CBFFA2BDB4E246360C8B5CF0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <0403698a-861b-8ca3-6e7a-3582b6a84a3b@xenomai.org>
 <DB6PR0701MB2456F0521C5DE7B8D4297F24B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7d82cdc5-22a6-66ee-5c23-7a626b5b5ef6@xenomai.org>
Date: Sun, 11 Jun 2017 17:47:35 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456F0521C5DE7B8D4297F24B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_taks_bind() returns -EAGAIN for existing task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/11/2017 04:11 AM, Giulio Moro wrote:
> Great info, it would be good to integrate these in the main docs somewhere. I had been at that URL a few times already, but the brief description of "session" given there is really not as complete as the one you just gave. I now see that "session" is mentioned twice in the task API documentation:
> The task documentation, for instance, mhttp://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html
> Unfortunately, someone finding it there would struggle to link it back to the command line options page and to put it in a wider context.
> 
> Perhaps a solution would be to add an "API tag" to rt_task_shadow, rt_task_create, rt_task_bind and all the other relevant functions (I assume there must be something also, e.g.: under pipe/queue/message/semaphore?) and add your description here http://xenomai.org/documentation/xenomai-3/html/xeno3prm/api-tags.html ?
> 

Yes, that would make sense.

There is a lot to do for better documenting Xenomai, especially
introducing a user guide and application notes. Today, most of the
existing documentation we have belongs to the reference manual category,
which is clearly not enough to bring newcomers up to speed for working
with Xenomai.

Technically speaking, a painful issue is that Doxygen is not very handy
to work with, when it comes to organizing the information - not to speak
of its parser which tend to drive people nuts when trying to figure out
the location of a deeply buried glitch in some obscure syntax.

The documentation on the website is fortunately based on asciidoc, but
there is not much there yet. Time which could be devoted to this subject
is too short, when other duties have to be carried out as well. Usual
dilemma, usual outcome so far.

-- 
Philippe.

