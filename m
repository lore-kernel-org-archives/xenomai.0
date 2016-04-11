References: <570B7253.1000904@basystemes.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <570BBD4C.6040409@xenomai.org>
Date: Mon, 11 Apr 2016 17:05:48 +0200
MIME-Version: 1.0
In-Reply-To: <570B7253.1000904@basystemes.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue while porting ipipe to kernel > 4.5
 (clockevents API change)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@basystemes.fr>, xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>

On 04/11/2016 11:45 AM, Thierry Bultel wrote:
> Hi,
> while porting ipipe to 4.5, I am facing the following issue:
> 
> clockchips.h has changed, and the set_mode function pointer has been
> replaced by
> 
>     int            (*set_state_periodic)(struct clock_event_device *);
>     int            (*set_state_oneshot)(struct clock_event_device *);
>     int            (*set_state_oneshot_stopped)(struct
> clock_event_device *);
>     int            (*set_state_shutdown)(struct clock_event_device *);
> 
> Moreover, CLOCK_EVT_MODE_XXX have been renamed to :
> 
> enum clock_event_state {
>     CLOCK_EVT_STATE_DETACHED,
>     CLOCK_EVT_STATE_SHUTDOWN,
>     CLOCK_EVT_STATE_PERIODIC,
>     CLOCK_EVT_STATE_ONESHOT,
>     CLOCK_EVT_STATE_ONESHOT_STOPPED,
> };
> 
> The impact therefore goes further than ipipe , since xenomai uses a
> single pointer
> for performing emulation.
> 
> I am just wondering what is the best way to deal with this, without
> impacting to much code
> Is it best to add a compatibility wrapper (moreover, the set_state_xxx
> functions are only used in clockevents.c), and some extra #defines
> or to spread the changes up to xenomai code ?
> 

I would confine the changes to the pipeline, I don't see any reason for
spreading those changes to Xenomai only for supporting the
ONESHOT_STOPPED mode, which might be usable as a hint, but may be
ignored by Xenomai as well, especially by legacy Xenomai 2.x releases.

You could redirect the new state handlers to a set of internal wrapper
routines in the pipeline, which would translate the calls to the
Xenomai's current emulation handlers.

-- 
Philippe.

