From: Thierry Bultel <thierry.bultel@basystemes.fr>
Message-ID: <570B7253.1000904@basystemes.fr>
Date: Mon, 11 Apr 2016 11:45:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Issue while porting ipipe to kernel > 4.5 (clockevents
	API change)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>

Hi,
while porting ipipe to 4.5, I am facing the following issue:

clockchips.h has changed, and the set_mode function pointer has been 
replaced by

     int            (*set_state_periodic)(struct clock_event_device *);
     int            (*set_state_oneshot)(struct clock_event_device *);
     int            (*set_state_oneshot_stopped)(struct 
clock_event_device *);
     int            (*set_state_shutdown)(struct clock_event_device *);

Moreover, CLOCK_EVT_MODE_XXX have been renamed to :

enum clock_event_state {
     CLOCK_EVT_STATE_DETACHED,
     CLOCK_EVT_STATE_SHUTDOWN,
     CLOCK_EVT_STATE_PERIODIC,
     CLOCK_EVT_STATE_ONESHOT,
     CLOCK_EVT_STATE_ONESHOT_STOPPED,
};

The impact therefore goes further than ipipe , since xenomai uses a 
single pointer
for performing emulation.

I am just wondering what is the best way to deal with this, without 
impacting to much code
Is it best to add a compatibility wrapper (moreover, the set_state_xxx 
functions are only used in clockevents.c), and some extra #defines
or to spread the changes up to xenomai code ?

Thanks,
Thierry

