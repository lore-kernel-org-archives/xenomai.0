MIME-Version: 1.0
In-Reply-To: <CANKLDmvSr6j-=6T-YGCG8byGsZ6oy_7sTmcknL7YC8uk9ymTrQ@mail.gmail.com>
References: <CANKLDmvSr6j-=6T-YGCG8byGsZ6oy_7sTmcknL7YC8uk9ymTrQ@mail.gmail.com>
Date: Wed, 5 Dec 2012 12:42:37 +0100
Message-ID: <CANKLDmvhj_sbQnLgmWSo6QsOnrB1CnJcpvg0DRbnW+X93bozbQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Strange behavior calling certain libraries from
 non-realtime shadow task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Tue, Dec 4, 2012 at 5:53 PM, Henri Roosen <henriroosen@gmail.com> wrote:

> Hi,
>
> I have a task that is using the libvlc (v2.0.4) library to play some media
> streams. This all works when it is a normal posix task. When the task is a
> non-realtime shadow task (prio 0, autorelax), then the shared libraries
> that libvlc loads (its plugins, codecs etc) get corrupted on disk. A second
> run of the program is not working.
>

The files get corrupted when they are loaded with a dlopen() call.
Is a dlopen() call allowed from a shadowed non-realtime task? Or what can
cause the loaded library to get corrupted at this point?


> Does anyone know what can be causing this? I was under the impression an
> autorelaxed shadow task was allowed to make all Linux calls. Are there
> known limitations or is this a bug?
>
> Platform: x86
> Xenomai 2.5.6
> Linux 2.6.38.8
>
> Thanks,
> Henri
>
