MIME-Version: 1.0
In-Reply-To: <51CC031A.9030905@xenomai.org>
References: <201306260906.22955.leo@alaxarxa.net>
	<51CB231E.8030600@xenomai.org>
	<201306271109.22749.leo@alaxarxa.net> <51CC031A.9030905@xenomai.org>
From: Peter Soetens <peter@thesourceworks.com>
Date: Fri, 28 Jun 2013 17:35:13 +0200
Message-ID: <CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai warn_upon_switch
Reply-To: peter@thesourceworks.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jun 27, 2013 at 11:17 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 06/27/2013 11:09 AM, Leopold Palomo-Avellaneda wrote:
>
>>
>> AAnd I don't know how to silent (or if is possible) this messages.
>
>
> Try disabling CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX if currently set in your
> kernel config. If that is still not enough, then you will have to switch off
> PTHREAD_WARNSW manually, using pthread_set_mode_np(), for each thread which
> triggers this signal.

Quoting Gilles:
"The point is that these messages are telling you that there is a bug,
either in xenomai code (a bug was fixed since xenomai 2.6.2.1 which
could explain such a behaviour), or in orocos code. When the bug is
fixed the signal will disappear."

We're having one thread ( main() ) which is modeswitching all the time
since it's doing user IO using the console, filesystem etc.

I didn't consider this as a bug, and we only enable PTHREAD_WARNSW for
specific threads, where it does matter.

I also have the CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX option on in my test
system, and I'm not seeing any of these messages (while the MSW
increments).

So it beats me what is causing these messages in his setup.

Leo, which version (git hash tag) are you using ?

Peter

