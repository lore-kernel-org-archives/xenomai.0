Subject: Re: [BUG] copperlate/eventobj.c ->>> eventobj_inquire(), don't work
References: <e371ebd5-519a-cf6e-998e-b2591d4f1c48@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d926b5a5-da09-c2f1-0b81-544cae7cc9d9@xenomai.org>
Date: Fri, 10 Jul 2020 10:38:12 +0200
MIME-Version: 1.0
In-Reply-To: <e371ebd5-519a-cf6e-998e-b2591d4f1c48@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Caffreyfans <Caffreyfans@163.com>, xenomai@xenomai.org

On 7/10/20 8:04 AM, Caffreyfans via Xenomai wrote:
> Hi sir,
> 
>     I'm trying to make another skin for xenomai.  When I do something about
> "event". I use `eventobj_inquire()` to get event flags. But no matter what
> value I post, I always get 0.
> 
>     I find that eventobj_inquire() is not working. I know `alchemy/event` also
> use `eventobj`. So I write a test code by using alchemy skin. I am curious
> whether it is my own problem or there is an error in xenomai.
> 

Most likely a bug in Xenomai. In addition, looking at cobalt_event_post(),
there is a blatant race condition between the signal <-> wait operations. The
in-kernel wait() operation serializes on the ugly big lock which is not going
to help much against racing with the userland counterpart in
cobalt_event_post(), which does this:

	__sync_or_and_fetch(&state->value, bits); /* full barrier. */

	if ((state->flags & COBALT_EVENT_PENDED) == 0)
		return 0;

The somebody-is-waiting bit tested above should be part of some atomic
operation shared with the wait-side or covered by the ugly big lock, but the
way it is implemented today can lead to spurious waits.

The event code was fixed months ago for another bad issue, the whole thing
looks fragile. You may want to review all of it.

-- 
Philippe.

