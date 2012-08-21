Message-ID: <50334FAE.8020604@xenomai.org>
Date: Tue, 21 Aug 2012 11:06:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfEMAJcH=UxGX7t0dhSwHGBs5XcfqbV+ioupxOVsXxCvw@mail.gmail.com>
In-Reply-To: <CAKKWdtfEMAJcH=UxGX7t0dhSwHGBs5XcfqbV+ioupxOVsXxCvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: scheduling5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 08/21/2012 07:46 AM, ali hagigat wrote:
> Suppose one Xenomai thread migrates to the secondary mode and keeps
> its real time priority(it is 80 for example). How it can compete with
> Linux threads as their priorities are in the range of 100 to 139.

80 is a priority in the Linux POSIX API range, ranging from 0 to 99. How
these priorities are remapped internally by the Linux kernel is not
really Xenomai's business: the priority of the Xenomai thread using the
POSIX priority 80 is the same as any Linux application thread created
with priority 80, simply because Xenomai threads are created using
standard Linux services.

> So
> all Linux threads are scheduled first till some time passes and that
> Xenomai thread gets higher effective priority. Is that right?

All Linux user threads with POSIX priorities between 81 and 99, and some
kernel threads with special higher priorities are scheduled before the
Xenomai thread, yes. But:
- you have to keep in mind that a Xenomai thread running in secondary
mode is not really a real-time thread from Xenomai scheduler point of view;
- if you are worried about such priorities issues created by the root
thread priority coupling, you can disable root thread priority coupling
(see CONFIG_XENO_OPT_PRIOCPL in kernel configuration, and particularly
the option help if you do not know what is root thread priority coupling).

-- 
					    Gilles.

