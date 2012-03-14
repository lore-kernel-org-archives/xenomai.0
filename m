Message-ID: <4F60DE70.90505@domain.hid>
Date: Wed, 14 Mar 2012 19:07:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B78EBC6@domain.hid>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B78EBC6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Should posix threads show up in
	/proc/xenomai/sched.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chris Stone <chris.stone@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/14/2012 06:59 PM, Chris Stone wrote:
> Using the "Porting POSIX applications to Xenomai" document I have
> ported an existing application to Xenomai. We create multiple threads
> in our application and I have the following questions related to
> posix threads (I could not find an answer in a search of
> xenomai-help):
> 
> If the threads are running in primary mode, should they be listed in
> /proc/xenomai/sched? My threads show up, with the correct real time
> priorities, when I do a top -H, but they are not in
> /proc/xenomai/sched, so does that mean they are all running in
> secondary mode?
> 
No, it means that they are not xenomai thread. If the application is
compiled correctly, xenomai threads are those created with pthread_create.

-- 
                                                                Gilles.

