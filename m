References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hFeFo1qgvVjNEekyn=b7Z3yAny+4nG5Yt0OTMd+cMt8xw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55C30FF5.9080401@xenomai.org>
Date: Thu, 6 Aug 2015 09:42:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAHoW4hFeFo1qgvVjNEekyn=b7Z3yAny+4nG5Yt0OTMd+cMt8xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 08/05/2015 06:34 PM, Charles Kiorpes wrote:
> Sorry if this gets to you twice, I forgot to "Reply to all"
> 
> After applying the patch and rebuilding, my application still
> segfaults at the same point, with the same error in my dmesg output.
> 
> For a little more info, here are the config flags I'm using to build
> the libraries:
> --with-core=cobalt
> --disable-debug
> --enable-pshared

Ok, so if pshared was enabled, the bug fixed by this patch could not
bite anyway.

-- 
Philippe.

