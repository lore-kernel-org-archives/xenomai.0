Date: Wed, 12 Oct 2005 07:37:22 -0700
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF726DB2.17F3%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] more on registry stuff
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

My app always creates a set of mutexes with the same name. I do this when
creating them:

    if(name&&!rt_mutex_bind(&_m, name, TM_NONBLOCK))
assert(!rt_mutex_delete(&_m));


This way, if it already exists, I delete it. Then I create it again.

They do not seem to delete. In fact, I see some duplicate names in
/proc/registry/mutex

Steven 


