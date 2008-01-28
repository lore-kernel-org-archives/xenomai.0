MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18333.52494.176360.871342@domain.hid>
Date: Mon, 28 Jan 2008 13:39:42 +0100
In-Reply-To: <d3f72a390801280134l6073203fr3cee621b34321301@domain.hid>
References: <d3f72a390801280134l6073203fr3cee621b34321301@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] RESCHEDULE TASK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

axel axel wrote:
 > Hi,
 > 
 > 
 > after the previouses answers about not sleeping tasks ( mailing list thread
 > "task scheduling e priority"* *) i ask you how to reschedule a not sleeping
 > task.

When you want to reply to a previous mail, just hit the "reply" button,
that is what it is made for, and it makes discussions much easier to
follow for anyone reading the list.

 > 
 > I explain better:
 > 
 > if my xenomai primary task work for example for 7 seconds without sleep the
 > other task and linux don't work.
 > 
 > How can i run the task for a estabilished time ( for example 10 ms ) and
 > start schedule for other task without insert in the task sleep or other
 > instruction ?

We do not know exactly what is doing the task which runs all the time,
so it is hard to give you a precise answer. Thus I will give you a very
general answer: redesign your application so that it is event-driven.

-- 


					    Gilles Chanteperdrix.

