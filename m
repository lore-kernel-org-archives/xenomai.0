MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17656.19065.549422.818297@domain.hid>
Date: Fri, 1 Sep 2006 16:58:01 +0200
Subject: Re: [Xenomai-help] [Fwd: Performance decrease]
In-Reply-To: <1157121310.4981.18.camel@domain.hid>
References: <1156941389.4323.17.camel@domain.hid> <1156942089.4323.29.camel@domain.hid>
	<17655.18827.661904.949733@domain.hid>
	<1157094795.4322.9.camel@domain.hid>
	<17656.11641.610980.162241@domain.hid>
	<1157121310.4981.18.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > > 
 > > But there is an exception: the "bind" syscall event must be intercepted
 > > for threads that are not yet marked as monitored.
 > 
 > That's the major issue. We need to keep events flowing to a filtering
 > callback in order to detect binding ops, but without going through the
 > entire pipeline abstraction. And pipelining as it is now must be kept
 > for bound Linux tasks, i.e. shadows. The idea is to save the time spent
 > in the Adeos event dispatcher for tasks that don't need to tell the
 > world about what they are actually doing.

The binding operation could be made a standard Linux operation, such as
an ioctl for instance.

-- 


					    Gilles Chanteperdrix.

