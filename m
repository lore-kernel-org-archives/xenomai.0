Date: Fri, 13 May 2011 00:52:03 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110512225203.GB2904@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] analogy: wake-up threshold
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

Hi Stefan, 

A few months ago, you asked me whether it was possible to prevent the
OS from waking up your process each time a few bytes were
acquired. You came with the idea to implement a wake-up threshold below
which the user space process is kept in sleep state.

A few days ago, I updated my experimental branch: two new user-space
functions were added: a4l_set_wakesize() and
a4l_get_wakesize(). Thanks to them, you will be able to configure the
wished behaviour.

I hope this will help you.

-- 
Alexis.

